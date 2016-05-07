From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: t6044 broken on pu
Date: Sat, 07 May 2016 14:19:47 +0200
Message-ID: <878tzmrrfg.fsf@linux-m68k.org>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: newren@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 07 14:20:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az1DD-0007nY-37
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 14:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbcEGMTw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 08:19:52 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45042 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbcEGMTw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 08:19:52 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3r274h3mh8z3hjTg;
	Sat,  7 May 2016 14:19:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3r274h3Q4yzvh1k;
	Sat,  7 May 2016 14:19:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id HbgE-_UjlYUb; Sat,  7 May 2016 14:19:47 +0200 (CEST)
X-Auth-Info: siwtYZmDr+miBerpAXCEHUuXxO1TayXsZ9fid9QkX/QYBwUQWTTvh56QWOVmyyU3
Received: from igel.home (ppp-88-217-9-210.dynamic.mnet-online.de [88.217.9.210])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  7 May 2016 14:19:47 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 70E942C0861; Sat,  7 May 2016 14:19:47 +0200 (CEST)
X-Yow: I've been WRITING to SOPHIA LOREN every 45 MINUTES since JANUARY 1ST!!
In-Reply-To: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sat, 7 May 2016 14:00:08
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293893>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The "seq" is not understood by all shells,
> using printf fixes this,
>
> index 20a3ffe..48d964e 100755
> --- a/t/t6044-merge-unrelated-index-changes.sh
> +++ b/t/t6044-merge-unrelated-index-changes.sh
> @@ -20,7 +20,7 @@ test_description=3D"merges with unrelated index cha=
nges"
>  #   Commit E: renames a->subdir/a, adds subdir/e
>
>  test_expect_success 'setup trivial merges' '
> -       seq 1 10 >a &&
> +       printf 1 2 3 4 5 7 8 9 10 >a &&

$ printf 1 2 3 4 5 7 8 9 10
1

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
