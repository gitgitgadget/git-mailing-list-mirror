From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Mon, 28 Nov 2011 14:51:20 +0530
Message-ID: <CAMK1S_jskf-ztZXtz=Pg7nOoX03j8-VizOEoRFOzL-d=5MqxKw@mail.gmail.com>
References: <20111126225519.GA29482@sigill.intra.peff.net>
	<7vr50uwk7x.fsf@alter.siamese.dyndns.org>
	<20111126233133.GA31129@sigill.intra.peff.net>
	<CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
	<20111126235135.GA7606@sigill.intra.peff.net>
	<CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
	<20111127000603.GA7687@sigill.intra.peff.net>
	<7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
	<CAMK1S_jbofsWyag3Sospz8wYHqD4Z1Fs0p+MJWi02eCq0e+uHQ@mail.gmail.com>
	<7vzkfgvjdo.fsf@alter.siamese.dyndns.org>
	<20111128080145.GB16901@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 10:21:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUxP0-0007AF-2g
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 10:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab1K1JVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 04:21:23 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64964 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab1K1JVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 04:21:21 -0500
Received: by yenl6 with SMTP id l6so2638956yen.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 01:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4CRpkT2fP5OHLwn3hGeNSTbgZB5/XXul6vVqrtFIqCM=;
        b=DiwXbHfvDGx3fnA7HxZWavYTwb7v1JGwkJHM/bfRR3ikQ5T3LEjR654I/5CrpVVrI4
         oIR53H18lAojPRD81TohIrS4OjLKhJbne6awGvM9y0cWznuGnq7d9cFLDeKy5ZR7GlGV
         3cXXGvuYBBIQb/JJMDrP2zGamzxNwBCjk8Z1c=
Received: by 10.182.111.8 with SMTP id ie8mr12136630obb.50.1322472081050; Mon,
 28 Nov 2011 01:21:21 -0800 (PST)
Received: by 10.182.6.41 with HTTP; Mon, 28 Nov 2011 01:21:20 -0800 (PST)
In-Reply-To: <20111128080145.GB16901@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186006>

On Mon, Nov 28, 2011 at 1:31 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 27, 2011 at 10:41:39PM -0800, Junio C Hamano wrote:
>
>> >> I actually like the idea of allowing pre-upload-pack hook on git:=
// and
>> >> possibly http:// only....
>> >>
>> >> One scenario I do not want to see is this. Suppose ...
>> >
>> > I'm sorry I started this discussion. =C2=A0I worked around it, tho=
ugh it's
>> > a bit kludgy, so maybe time to drop the debate.
>>
>> I do not want you to feel sorry, and I do not understand why you fee=
l that
>> way.
>
> Agreed. This is a topic that has come up several times before for oth=
er
> users (GitHub and Gentoo come to mind), and which I've given some
> thought to, which is why I'm writing so many words on the subject.

I can see that you have, and I appreciate that.

I was vaguely feeling guilty about *causing* all that extra effort,
because I think it is a bit of a waste of time.  I sincerely believe
there is *no* place for shared setups [1] these days, however common
they may be.  In fact, if I didn't already believe so, your last few
emails would have convinced me!

I'm amazed to learn in this thread that people apparently even *push*
in such setups!

[1] not just "upload-pack runs as invoking user" but also other
settings like liberal umask, (which you mentioned) and so on.

> As for your kludge, I took a peek at gitpod. I actually think
> intercepting the call to upload-pack is a reasonably sane approach,

Thanks.  I wasn't happy at first but now I'm fine with it.

--=20
Sitaram
