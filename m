From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] t: mailmap: add 'git blame -e' tests
Date: Sat, 4 Feb 2012 23:04:23 +0200
Message-ID: <CAMP44s3tmiPGgAUakUgoen2aJcsKw4CygtF5f=4x2dxNTrGbGA@mail.gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-3-git-send-email-felipe.contreras@gmail.com>
	<20120204201027.GE22928@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:04:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtmmd-0004yS-OT
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab2BDVE0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 16:04:26 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:45264 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753284Ab2BDVEY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 16:04:24 -0500
Received: by lbom4 with SMTP id m4so760779lbo.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 13:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=g4bVsqDnY/IzLRcR615WmfzwlWasJIvxeXB5iFWMkzs=;
        b=rEGgr8B2ZbFDPWDTDPIIrDLwezOIh6NR7MFONZ4hNnVPD4I45bWCE8hMC1nrzdASjK
         BwmbS4O/0gp438cQfSS/zLGTShqbJVzYl5XuhbiweqalxosLb3YcKuvJfFz6HIVhDSXX
         Gx2Oi4X6AL68PZhh3gNR5I9fQ+d6BiEQOVrO8=
Received: by 10.112.32.1 with SMTP id e1mr3269500lbi.3.1328389463218; Sat, 04
 Feb 2012 13:04:23 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sat, 4 Feb 2012 13:04:23 -0800 (PST)
In-Reply-To: <20120204201027.GE22928@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189908>

On Sat, Feb 4, 2012 at 10:10 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Since I didn't receive a copy of the cover letter or patch 1, I don't
> know what this is intended to test _for_. =C2=A0Good --- I can more e=
asily
> convey the reaction of future readers who do not necessarily know the
> context in which the patch was written (and the commit message does
> not seem to say).
>
> Looking above, I see
>
> =C2=A0- a lone comment "git blame". =C2=A0What is it trying to tell m=
e? =C2=A0I guess
> =C2=A0 you copy/pasted it, but is there any purpose to it?
>
> =C2=A0- a test asserting the claim "Blame output (complex mapping)". =
=C2=A0This
> =C2=A0 title is identical to the test before. =C2=A0I have no idea wh=
at this is
> =C2=A0 about.

Look at the title:
add 'git blame -e' tests

s/blame/blame -e/

--=20
=46elipe Contreras
