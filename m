From: =?ISO-8859-2?Q?Micha=B3_=A3owicki?= <mlowicki@gmail.com>
Subject: Re: gsoc - Better git log --follow support
Date: Fri, 15 Apr 2011 21:41:33 +0200
Message-ID: <BANLkTinPkGocaF71V9r0-XhY=wHUxJM1Bg@mail.gmail.com>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
	<BANLkTik7t=Tfh_Y_+swnaAWyetfy8MU6VA@mail.gmail.com>
	<20110415040649.GA25780@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 21:41:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAotf-00043S-4O
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 21:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925Ab1DOTle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 15:41:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59532 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab1DOTle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 15:41:34 -0400
Received: by gwaa18 with SMTP id a18so1221620gwa.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MitQU9zN4OZuC+gHpdL9OYq9flOUJRnMRYMFHs7E3xk=;
        b=BfOdwUEYd2lSg4wfinaHnRi2EO421zYMwLPxlWVezAtXtx5cjOBCjt9k4vgeRGtU/9
         wFglUrPi1hvvThEN+xYxICX1yvQhBExkfOFyfrNf4PjiEEs7HsozgguEly+G+amwxDw2
         0HY/qlgtN7391wtGFPzYcTol4ka90+481O27k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aT0u3JB1vYYfsVcBTqRvztq3+0/70NbackWgYI8GSWDj2rpUwOwunfmG189CShBIOt
         UCwhhbdRAecpzO5WOo4IHASH+Nfn9iVg3KJJgrSjs7lEbQWqyWCeT84hidxqk79XwhjZ
         bAfmIkCnHKnI8ewYBBzWEgogmZ13IvstSTgmA=
Received: by 10.42.29.138 with SMTP id r10mr3353602icc.83.1302896493095; Fri,
 15 Apr 2011 12:41:33 -0700 (PDT)
Received: by 10.42.222.195 with HTTP; Fri, 15 Apr 2011 12:41:32 -0700 (PDT)
In-Reply-To: <20110415040649.GA25780@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171635>

W dniu 15 kwietnia 2011 06:06 u=BFytkownik Jonathan Nieder
<jrnieder@gmail.com> napisa=B3:
> Hi,
>
> Micha=B3 =A3owicki wrote:
>
>> 25.04 - 15.06
>> 1) study the revision walking code
> [...]
>> 2) study the pathspec matching + limiting and rename detaction API
> [...]
>> 3) figure out what state --follow will need to maintain, where it wi=
ll
>> fit into the revision walking process and design new architecture fo=
r
>> it
>
> Ideally this should happen in the next couple of days, rather than th=
e
> next couple of months. =A0Otherwise the project would be an unknown a=
nd
> it would be hard in good conscience to accept funding for it.

Right, I could try do this sooner but is it doable without deep
understanding of 1 and 2?

>
> That said, I am personally willing to help out in the next few days
> (to help put a solid proposal together) and throughout the summer (to
> fix git log --follow) regardless. =A0I will be very happy when --foll=
ow
> works reliably.

Great!

>
>> 16.06 - 26-08
>> 4) implementation
>>
>> I plan to spend about 2 months for the first 3 points. It's all abou=
t
>> poking the right developers and sending question to the mailing list=
=2E
>
> It's hard to say how the process of studying code works. =A0Certainly
> asking a question can be a good way to start, and reading code can
> lead to more questions. =A0Another strategy that can work well is to
> take the plunge and see what effect changes to the code have.
>
>> I'll try to send some updates soon when I get through some basic
>> lecture and the most important code.
>
> Ok. =A0Remember it's okay to ask for help (though of course not so gr=
eat
> to demand it) if you get stuck or have no idea where to start on
> something.
>
>> Any suggestions/ideas are as always welcome. Be prepare for many
>> questions from my side :)
>
> Looking forward to it. =A0If we end up with better technical
> documentation as a side effect, all the better.
>
> Regards,
> Jonathan
>



--=20
Pozdrawiam,
Micha=B3 =A3owicki
