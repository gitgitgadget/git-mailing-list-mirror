From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Remove --allow-empty from the git-commit synopsis
Date: Wed, 7 Apr 2010 20:55:29 +0200
Message-ID: <201004072055.30017.j6t@kdbg.org>
References: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com> <1270661327-28078-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:57:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzaRh-00075H-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab0DGS5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 14:57:44 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:40941 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751239Ab0DGS5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 14:57:44 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 90B74A7EBA;
	Wed,  7 Apr 2010 20:57:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 23B6C19F5BF;
	Wed,  7 Apr 2010 20:55:30 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1270661327-28078-1-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144269>

On Mittwoch, 7. April 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrot=
e:
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -10,9 +10,8 @@ SYNOPSIS
>  [verse]
>  'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend]
> [--dry-run] [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-auth=
or]
> -	   [--allow-empty] [--no-verify] [-e] [--author=3D<author>]
> -	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status] =
[--]
> -	   [[-i | -o ]<file>...]
> +	   [--no-verify] [-e] [--author=3D<author>] [--date=3D<date>]
> +	   [--cleanup=3D<mode>] [--status | --no-status] [--] [[-i | -o ]<f=
ile>...]

IMO the option should not be removed from the synopsis section of the=20
documentation. I would agree that it is removed from the output of 'git=
=20
commit -h', and I think this was the original intent when someone (Juni=
o?)=20
suggested to remove it.

-- Hannes
