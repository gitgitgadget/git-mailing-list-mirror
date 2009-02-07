From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fix t1504 on Windows
Date: Sat, 07 Feb 2009 01:25:25 +0100
Message-ID: <498CD4F5.8010102@lsrfire.ath.cx>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498B3F6B.5080002@lsrfire.ath.cx> <498C3328.70804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 01:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVb26-0004T7-Vf
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 01:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbZBGAZ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 19:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZBGAZ2
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 19:25:28 -0500
Received: from india601.server4you.de ([85.25.151.105]:34018 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZBGAZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 19:25:28 -0500
Received: from [10.0.1.101] (p57B7E1CE.dip.t-dialin.net [87.183.225.206])
	by india601.server4you.de (Postfix) with ESMTPSA id 377E72F8056;
	Sat,  7 Feb 2009 01:25:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <498C3328.70804@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108803>

Johannes Sixt schrieb:
> I also need this to complete this test:
>=20
> diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
> index 9c9c4c9..e377d48 100755
> --- a/t/t1504-ceiling-dirs.sh
> +++ b/t/t1504-ceiling-dirs.sh
> @@ -93,13 +93,13 @@ GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/subdi"
>  test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
>=20
>=20
> -GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub"
> +GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub"
>  test_fail second_of_two
>=20
>  GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/sub:/bar"
>  test_fail first_of_two
>=20
> -GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub:bar"
> +GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub:/bar"
>  test_fail second_of_three
>=20

Just to confirm: after updating msys, I also need this patch to make
t1504 pass.

Ren=E9
