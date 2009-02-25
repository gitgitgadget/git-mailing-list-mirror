From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [PATCH] README: fix path to "gitcvs-migration.txt" and be more consistent
Date: Wed, 25 Feb 2009 10:25:13 +0100
Message-ID: <200902251025.14960.brian.foster@innova-card.com>
References: <20090224211637.07d764f5.chriscool@tuxfamily.org>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>,
	Brian Gernhardt <benji@silverinsanity.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 10:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcG3G-0000ng-Ht
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbZBYJZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 04:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754529AbZBYJZz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:25:55 -0500
Received: from mail-ew0-f164.google.com ([209.85.219.164]:33304 "EHLO
	mail-ew0-f164.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbZBYJZx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 04:25:53 -0500
Received: by ewy8 with SMTP id 8so606073ewy.13
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 01:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=cFW0NR0+exeHwg76Priyu8uAdMO9JhcvaRbsnonSo68=;
        b=ONSBHCzluuUNcaJZHrZWgLicSVDZSkP4xOFz1SZQgN7LkPfrg0aaLXjsCsqDzM3YZG
         P5XF4wUfzBeQoTEUXSo9uuhuBiTWg3iGIkVOUGZ08+IQygDQIueGzEdwQA5SOqFkl4qH
         RYxidIpnPflKocsKibBq3Plyayme3LIQnjT78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uml+TSQxysEuxHJ5fKKUIDhqiwEfQ5hS8BhDZTwB/w+OIHCBo0w7c+MA+b5D7GE6iM
         Lku6t5S0RNoTMognFHQMI8fQa7cjlRnyoo8+h18VkeOl4682oXFoW1aPnqwZzaC9gi2J
         fCk2IXQ2ou8mqlrVuz06lLf5m7khh6WbR/25A=
Received: by 10.210.91.7 with SMTP id o7mr380946ebb.196.1235553948684;
        Wed, 25 Feb 2009 01:25:48 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id 7sm9437942ewy.58.2009.02.25.01.25.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 01:25:46 -0800 (PST)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
In-Reply-To: <20090224211637.07d764f5.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111418>

On Tuesday 24 February 2009 21:16:37 Christian Couder wrote:
>[ ... ]
> diff --git a/README b/README
> index 5fa41b7..c932ab3 100644
> --- a/README
> +++ b/README
> @@ -24,10 +24,18 @@ It was originally written by Linus Torvalds with =
help of a group of
>  hackers around the net. It is currently maintained by Junio C Hamano=
=2E
> =20
>  Please read the file INSTALL for installation instructions.
> +
>  See Documentation/gittutorial.txt to get started, then see
> -Documentation/everyday.txt for a useful minimum set of commands,
> -and "man git-commandname" for documentation of each command.
> -CVS users may also want to read Documentation/cvs-migration.txt.
> +Documentation/everyday.txt for a useful minimum set of commands, and
> +Documentation/git-commandname.txt for documentation of each command.
> +If git has been correctly installed, then the tutorial can also be
> +read with "man gittutorial" or "git help tutorial", and the
> +documentation of each command with "man git-commandname" or "git hel=
p
> +commandname".

 seems Ok to me, with a caveat =E2=80=94 the information is correct,
 but the presentation has a (very minor!) problem (IM(H?)O).
 I find a bit confusing that whilst you type (e.g.):

    git help tutorial

 you don't type:

    git help commandname

 but (e.g.):

    git help log

 that is, the =E2=80=98commandname=E2=80=99 is a placeholder (variable)=
, whilst
 the =E2=80=98tutorial=E2=80=99 is a literal (constant).  there doesn't=
 seem to
 be a clear distinction made....?    if a clear distinction is
 to be made, it should be done in a consistent manner throughout
 the README.  however, after a brief glance, there does not seem
 to be any distinction made in the README, so this is minor nit.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
