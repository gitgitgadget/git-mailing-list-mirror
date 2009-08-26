From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitosis-lite
Date: Wed, 26 Aug 2009 10:31:21 +0530
Message-ID: <2e24e5b90908252201m66b88ab4gc6ec47f7ad4601c2@mail.gmail.com>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
	 <m363cdm4pm.fsf@localhost.localdomain>
	 <2e24e5b90908242253v411ad5f3t8a2802079914d0bf@mail.gmail.com>
	 <200908251405.17644.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 07:01:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgAdu-0004pr-Sz
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 07:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718AbZHZFBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 01:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756348AbZHZFBV
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 01:01:21 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:45929 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbZHZFBT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 01:01:19 -0400
Received: by iwn42 with SMTP id 42so1530616iwn.33
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 22:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nhRy9F+fKvmG5WEvbML/qeye+qeoP50m+f7cgBpnNZY=;
        b=oWGu+EzC1ZxOTHYP3sSLYtUn2QLJXSSrwkn8VW3C+LLtx+nFj5ZOaM2vgv3G/Buyjr
         B4QJ0KkjXvlSVeETy3q3OSqbOnJ0uf1jU8o8v8x9iodRifp7fXbPrnG6VobbjxURoW3u
         F3fct/h9EhrrQffBItD5LP/fdBJPkU9QaSZv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HPKGjbEzHCTUANwnr0+S1d0wVcUGdQhi35jowFoziBYeRfp/cImXRTqbNYc2i3ZcEC
         H6h5xPt1xmBoM6Oi+cPinAFwGe2NPkkcUIc14RMaMzYdPpWS2Vlz9f6TvTT5aFkcMjE9
         DV06wQ6FhQy3AMAxX2vEkWCgTzSKwvsf17FVI=
Received: by 10.231.37.77 with SMTP id w13mr3529103ibd.3.1251262881473; Tue, 
	25 Aug 2009 22:01:21 -0700 (PDT)
In-Reply-To: <200908251405.17644.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127065>

On Tue, Aug 25, 2009 at 5:35 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> Sitaram Chamarty wrote:
>> On Tue, Aug 25, 2009 at 12:14 AM, Jakub Narebski<jnareb@gmail.com> w=
rote:

>> > Wouldn't it be better to use "use warnings" instead of 'perl -w'?

>> I'm not sure what is the minimum perl required for git

> I think that git requires Perl at least version 5.6

thanks; I'll change "-w" to "use warnings"

>> > It would be, I think, better if you have used POD for such
>> > documentation. =A0One would be able to generate manpage using pod2=
man,
>> > and it is no less readable in source code. =A0See e.g. perl/Git.pm=
 or
>> > contrib/hooks/update-paranoid.
>>
>> Hmm... I've been spoiled by Markdown's sane bullet list
>> handling. =A0Visually, POD forces everything other than code
>> to be flush left -- any sort of list is definitely less
>> readable in source code as a result. =A0IMHO of course.
>
> How it is relevant to the issue at hand? =A0I was talking about repla=
cing
> documentation comments in the header with POD markup.
>
> Also you usually document top-level structures with POD.

=46orget I mentioned markdown :)  All I'm saying is that even in the
documentation you speak of, I have a couple of small "lists".  And I
like lists to be properly indented, that's all -- I am mentally unable
to edit them if they are all flush left :-( just like it's irritating
to edit code that's mis-indented or not indented.  Sorry...!

And yes, one of my python friends has then asked "why do you not like
python".  I have no answer.  As Whitman said
(http://www.quotationspage.com/quote/26914.html):

    Do I contradict myself?
    Very well then I contradict myself,
    (I am large, I contain multitudes.)

:-)

Regards,

--=20
Sitaram "not normally given to quoting poets" Chamarty
