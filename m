From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Enhancement Request: "locale" git option
Date: Sat, 6 Dec 2014 20:28:35 +0100
Message-ID: <CAN0XMO+hn0cYrd=gVpUad_mQCvkNwdFzFLn0Vo7045-M_0Gsvw@mail.gmail.com>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
	<54801B50.4080500@web.de>
	<20141204095557.GE27455@peff.net>
	<CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com>
	<548087F8.1030103@drmicha.warpmail.net>
	<CACBZZX6iOtO-Wv_T1Sgtmjqdi8kEziBCHwp1X319x0o1QMOnGA@mail.gmail.com>
	<20141204205527.GA19953@peff.net>
	<5481D30B.2020104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 06 20:28:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxL29-0008T5-TV
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 20:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbaLFT2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 14:28:38 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:60779 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaLFT2h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 14:28:37 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so3359469wgh.20
        for <git@vger.kernel.org>; Sat, 06 Dec 2014 11:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=l2LTG36AgX+KhCWJDaHT+1bT+wmVTqXPUGvQTmFn194=;
        b=cu1CaKlxIYlmMEDAxmVItDZqsAiuA+aBVE5SF7GGtUiNbugMpwkX6EIu0Zpr8/wOaq
         lhPG+V1NnRGNx8PQ8nzxzuKFK5w9F4DdUMkwDFM7gaWjJzRQvgyxpjYGlCWQGFgL3k5q
         TGtuGBSxTswbDZtOKgK/X5PXok5VO0iZoiALQVeCGYoWAeFGXd86yR/K/1MEIoQf9al/
         uCxTqRkuyduRju7X9OF35IdovtOD4yt9N3NoAOFTtmwFa/CBmGfYDgeaH75qffqlQ5qn
         uFTIAIc4v92PC1jO99v9i53rkTxlj55SwvqEfcn+qn0+APwRPqAiKyV7eFjTyyZ25bBD
         XB3w==
X-Received: by 10.180.11.140 with SMTP id q12mr13128693wib.45.1417894115889;
 Sat, 06 Dec 2014 11:28:35 -0800 (PST)
Received: by 10.194.235.167 with HTTP; Sat, 6 Dec 2014 11:28:35 -0800 (PST)
In-Reply-To: <5481D30B.2020104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260957>

2014-12-05 16:45 GMT+01:00 Torsten B=C3=B6gershausen <tboegi@web.de>:
>
> I do not know who was first, and who came later, but
> <http://git-scm.com/book/de/v1/Git-Grundlagen-%C3%84nderungen-am-Repo=
sitory-nachverfolgen>
>
> uses "versioniert" as "tracked"
>
>
> LANG=3Dde_DE.UTF-8 git status
> gives:
> nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Dateien (ben=
utzen Sie "git add" zum Beobachten)
>
>
> Does it make sense to replace "beobachten" with "versionieren" ?
>

I think it makes sense. "versionieren" describes the concept of trackin=
g
better than "beobachten", IMO. I'll send a patch for that.

Thanks
