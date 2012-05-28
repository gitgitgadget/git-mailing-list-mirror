From: Timothy Normand Miller <theosib@att.net>
Subject: =?windows-1252?Q?Re=3A_Git_hangs_at_=93Writing_objects=3A_11=25?=
 =?windows-1252?Q?=94?=
Date: Mon, 28 May 2012 08:48:32 -0400
Message-ID: <3BBC77C3-B747-4F68-A135-954C3C00ECBA@att.net>
References: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net> <20120525005156.GC11300@sigill.intra.peff.net> <033AF49C-4CB3-4412-8845-0246D356358C@att.net> <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net> <201205270312.q4R3Chef014187@no.baka.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon May 28 14:48:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYzNR-0001sG-4c
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 14:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab2E1Msl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 08:48:41 -0400
Received: from nm27-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.188]:26335
	"HELO nm27-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753696Ab2E1Msj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 08:48:39 -0400
Received: from [98.139.44.103] by nm27.access.bullet.mail.sp2.yahoo.com with NNFMP; 28 May 2012 12:48:33 -0000
Received: from [98.139.44.76] by tm8.access.bullet.mail.sp2.yahoo.com with NNFMP; 28 May 2012 12:48:33 -0000
Received: from [127.0.0.1] by omp1013.access.mail.sp2.yahoo.com with NNFMP; 28 May 2012 12:48:33 -0000
X-Yahoo-Newman-Id: 650039.13797.bm@omp1013.access.mail.sp2.yahoo.com
Received: (qmail 17335 invoked from network); 28 May 2012 12:48:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1338209313; bh=qTCqSW2DSvugfrgpuMe5+vkmiFsMXyzF037P42FzB+M=; h=X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Subject:Mime-Version:Content-Type:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=R4HsKRRr57tGnuadwOy84Z+6c36S4dCd2dLUX7ZdOSy2Hs7VvDhhvwX2Y8OyqjJ5pju6ZHwUxcn1DI5Gm6UVzlPA2nAE6kRU7+fNGtPIUVWVdOhKEuSRRAFvkP/1Us9YtBgqxVCI8VVUxBl8EMWIUnNGFA1/NgkrYLKff/dGUL4=
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: mqEr7t8VM1klyjht3UcdDRgxCJ25F55MA_O1euBScPpUBXb
 5sZhIXQ.iaG1BPrzcTSmQ56lGZP9jwsRKI2sFkbbT2k0Fnw1ONwHHPgD_xsN
 fCxu3BkrOL0VeP9QJ0SczdcX..LMC1AWWKiBYwIcVj1jOnAJwaMw4TsoqupN
 JlHZ7lTYz0P4P3sjJykGMNwO5OZFtNcuHQr4SSudJ7uhO6EGLPp5Crmx6xjf
 rdO5NDRVXTWUFw__bPHAK6yb3UbYQ5j_kiMH3MGmfADc9EGy8IwZh28DgRc3
 wEyx02rTQQloYrtCdVE.TAWL9ubokNasKABVRFUiFjeApAd1naRzTHiOys7h
 hwnPV3pZFKyhaIpL0zXQ75HswhrucEUzPSYAqcpMb6hZyKpb978P0v6PgfnY
 utBnOVst9L2dwv0QtdZ24kZKp2T3ryVZmmodlHATFBiV466EWKhwf7NlSFH2
 emuBxvd5j4vGf5cqFOwNoC5WHME0yBgCvyuc6w5XIy8rMO9vRnf77KQ46ntG
 QuFhJX5_8Mfo-
X-Yahoo-SMTP: fnCipqKswBBOUfpM7XF4CajMkMYSy.KS.UTLsA--
Received: from [192.168.1.107] (theosib@76.232.38.36 with plain)
        by smtp108.sbc.mail.gq1.yahoo.com with SMTP; 28 May 2012 05:48:33 -0700 PDT
In-Reply-To: <201205270312.q4R3Chef014187@no.baka.org>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198707>

I tried uploading a file via sftp, and it stalls out at 160K.  So this is the cause of the problem.  SSH is broken.  Unfortunately, googling for ssh and stall isn't getting me anywhere.

On May 26, 2012, at 11:12 PM, Seth Robertson wrote:

> 
> In message <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net>, Timothy Normand Miller writes:
> 
>    I did some more research and testing.  This is an ssh problem.  If
>    I change the protocol to git://, then I can push remotely all I
>    want.  Same for file://.  But using ssh, it hangs.  Since I want
>    ssh encryption, I still need to figure out why ssh is going wrong.
> 
> You could try smart-http with encryption, either as an experiment or
> as a workaround.
> 
> http://sethrobertson.github.com/HowToPutGitOnTheWeb/ provides
> information on how to put a git repository on the web, with encryption
> and password/pam/ldap/public key authentication.
> 
> 					-Seth Robertson
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
