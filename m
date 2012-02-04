From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] t: mailmap: add 'git blame -e' tests
Date: Sat, 4 Feb 2012 23:59:04 +0200
Message-ID: <CAMP44s2djXurzMSXLOAkx84Sm8P2YV67M1yS2AuidkfGbTdmEQ@mail.gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-3-git-send-email-felipe.contreras@gmail.com>
	<20120204201027.GE22928@burratino>
	<CAMP44s3tmiPGgAUakUgoen2aJcsKw4CygtF5f=4x2dxNTrGbGA@mail.gmail.com>
	<20120204211351.GB3278@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:59:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtndX-0003lN-CT
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab2BDV7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 16:59:06 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39113 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408Ab2BDV7F convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 16:59:05 -0500
Received: by lagu2 with SMTP id u2so2405742lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 13:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KgzlGJ6ebGZFCAInuOevQpyH62y8ruukxS4DhSr6T9s=;
        b=TEwiocEM7MJlti2gPPC2HvRhUSnu6aLCrTpgXYIdjvb6dHfKww26prjwhzqcj4/ZXI
         IU+abihvIvg9Rumv9DFbJcqXKz53Y0uvnSV/orEjJybiPAu3St5stckmrDo+bjKgYx9R
         gx9JA7yG8vHi5GozAIUiYKnZn+kEclM96Ei/A=
Received: by 10.152.114.169 with SMTP id jh9mr6330554lab.20.1328392744054;
 Sat, 04 Feb 2012 13:59:04 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sat, 4 Feb 2012 13:59:04 -0800 (PST)
In-Reply-To: <20120204211351.GB3278@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189916>

On Sat, Feb 4, 2012 at 11:13 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>> On Sat, Feb 4, 2012 at 10:10 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>
>>> Since I didn't receive a copy of the cover letter or patch 1, I don=
't
>>> know what this is intended to test _for_. =C2=A0Good --- I can more=
 easily
>>> convey the reaction of future readers who do not necessarily know t=
he
>>> context in which the patch was written (and the commit message does
>>> not seem to say).
> [...]
>> Look at the title:
>> add 'git blame -e' tests
>>
>> s/blame/blame -e/
>
> And? =C2=A0After copy/pasting this particular test with that substitu=
tion,
> what do we get a test for?

=46or 'git blame -e'.

> What class of problem is it supposed to catch?

Problems related to 'git blame -e'?

> By the way, "I blindly copy/pasted" does not seem like a very sensibl=
e
> excuse for writing meaningless code (such as the "# git blame" commen=
t
> line). =C2=A0Before the code contained one riddle. =C2=A0Afterwards i=
t has two.

=46ine, the drop the patch then... Who needs to test 'git blame -e'
anyway, the current situation of having zero tests for it is perfectly
fine.

Or just apply it. Don't let the perfect be the enemy of the good.

Cheers.

--=20
=46elipe Contreras
