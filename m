From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] blame: fix email output with mailmap
Date: Sun, 5 Feb 2012 22:58:05 +0200
Message-ID: <CAMP44s1GntxQZ38Bz=+2Km8b9xeRyF2bTmKj6R_FgXWo3mcMoA@mail.gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-2-git-send-email-felipe.contreras@gmail.com>
	<87liohvysi.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 05 21:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9A6-0003nK-1n
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab2BEU6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 15:58:08 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45984 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751236Ab2BEU6H convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 15:58:07 -0500
Received: by lagu2 with SMTP id u2so2653096lag.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 12:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FR+jORSQh7k/ZXfW2x+s2QezACjGZA+5JUz35CmXgI4=;
        b=rxt+s2J7NR+lskCvTH2JjsatBNI798FLC3ky1m4vNfmiYVnoeCy38Trunudurj58pV
         wibcgTPs2jzdk4d5yD6xksVnUCkT4/VkWreXjCwURmnLzg5d/2uF1luQIFFgKQJTcMW4
         4ZS11A/QQuCENJOOlcEBUzuq8ZqT2AdicdMgE=
Received: by 10.152.123.68 with SMTP id ly4mr2628895lab.13.1328475485473; Sun,
 05 Feb 2012 12:58:05 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sun, 5 Feb 2012 12:58:05 -0800 (PST)
In-Reply-To: <87liohvysi.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189960>

On Sun, Feb 5, 2012 at 9:57 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Cc: git@vger.kernel.org, =C2=A0Junio C Hamano <gitster@pobox.com>, =C2=
=A0"Brian Gianforcaro" <b.gianfo@gmail.com>, =C2=A0"Marius Storm-Olsen"=
 <marius@trolltech.com>, =C2=A0"Junio C Hamano" <junkio@cox.net>
>
> I hope you noticed that Cc lists like the above really prove my point
> that you cannot automate common sense. =C2=A0Your cccmd script appare=
ntly
> uses the line range in

The fact that my script is less than perfect, doesn't mean you
*cannot* automate. Again, look at Linux's scripts/get_maintainer.pl.
It works * perfectly* fine.

>> diff --git a/builtin/blame.c b/builtin/blame.c
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -1403,10 +1403,13 @@
>
> to determine who to Cc. =C2=A0But in doing so, it dug up an old addre=
ss for
> Junio. =C2=A0It also added Brian whose only fault in all of this was =
fixing
> style of the 'if' you are patching.

Yes, it can be improved. But it's still better than nothing.

> And on top of that it had absolutely no way of knowing that Cc'ing Pe=
ff
> would have been a good idea, seeing as you two were involved in an
> earlier discussion about this precise bug.
>
> (Granted, omitting *Peff* doesn't make that much of a difference, sin=
ce
> for all I know he reads every email that crosses this list. =C2=A0But=
 my
> point still stands.)

That's not the fault of the script; that's what --cc is for.

--=20
=46elipe Contreras
