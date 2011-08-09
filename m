From: Daniel Mack <zonque@gmail.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Tue, 9 Aug 2011 09:40:28 +0200
Message-ID: <CACTFLAN4cg-7Z8WLVROZcAkOjSdf0_ZRbneTE=BasFz=zQwisA@mail.gmail.com>
References: <4E3EF38A.9010307@gmail.com>
	<20110807234634.GA3236@kroah.com>
	<CACTFLAOhApGVNZ7JsWhoHBEaQ_87stXjxkXvadmauNfhSuPD1g@mail.gmail.com>
	<D95ADFD4-2504-4BE6-BCD4-7B916F6F2FEB@gmail.com>
	<CACTFLAN0gM-xvEU32KHEsaApH4apvGUwGkiDHx06PngHUvH0Ew@mail.gmail.com>
	<20110808204448.GF18294@sigill.intra.peff.net>
	<20110808210714.GA16512@elie.gateway.2wire.net>
	<20110809070141.GA13623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Aguilar <davvid@gmail.com>, Greg KH <greg@kroah.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 09 09:40:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqgvS-000050-Rc
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 09:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1HIHka convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 03:40:30 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37878 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab1HIHk3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 03:40:29 -0400
Received: by pzk37 with SMTP id 37so9666033pzk.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZCuO5ubhTHInJSSKMfPtD1JqAffJU/MoBrrm9s0LZT4=;
        b=itmwoQMzxEHvEwQ01Zs1odAbNrAXrmHARtJqIaNdWxzzasq50Bgq66pVhIYCwucq6g
         zf1Pg/N1rcmyfXzNf0bkiHHHJKXKjBK9+lTIHY9yRU00YyKSetajLx6cPB9t54gYIXpA
         Il1XRmbSiz+9fDBN0eshhJ6c7T5TjYWRu8cAg=
Received: by 10.142.150.38 with SMTP id x38mr4407054wfd.128.1312875628949;
 Tue, 09 Aug 2011 00:40:28 -0700 (PDT)
Received: by 10.142.194.11 with HTTP; Tue, 9 Aug 2011 00:40:28 -0700 (PDT)
In-Reply-To: <20110809070141.GA13623@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179024>

On Tue, Aug 9, 2011 at 9:01 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 08, 2011 at 11:07:14PM +0200, Jonathan Nieder wrote:
>
>> > I'm kind of confused why you would mark an address as "cc", but no=
t cc
>> > it. Wouldn't it make sense to call the header something else?
>>
>> Maybe the patch is a draft and he is seeking early feedback. =A0The
>> final version will be cc-ed to the indicated person later (and that'=
s
>> part of what it is time to get feedback on).
>
> I suspect in that workflow, you would use --suppress-cc=3Dall, and th=
en
> just address it to whomever you are getting feedback from.
>
>> Or maybe the Cc: line is from the original patch and he is using git
>> send-email to forward it without mangling.
>
> In that case, shouldn't the cc either be respected (since the origina=
l
> patch author wanted it so), or stripped (if the patch no longer has
> anything to do with that cc).
>
>
> Still, we are only guessing at possible workflows here. I don't have =
a
> problem with the idea of per-address suppression; it makes git more
> flexible and doesn't hurt people who don't need the flexibility.
>
> I was more objecting to it as a solution to a workflow that is "we wa=
nt
> a unique tag in the commit, so we called it 'cc', but don't want peop=
le
> to actually 'cc' it". That's just wrong and silly. But it turns out t=
hat
> isn't happening here, anyway.

Right. I thought I might fix something here to improve a widely
anticipated workflow, but as it turns out, it's not actually needed. I
don't personally have any other use for this feature, so I don't care
much whether it will be applied eventually. Except for the fact that
it would be my first contribution to git, of course ;)

So - up to you to decide.


Thanks,
Daniel
