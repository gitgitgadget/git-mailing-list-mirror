From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Add case insensitive support in matching pathspec
Date: Thu, 3 Feb 2011 21:17:32 +0100
Message-ID: <201102032117.32745.j6t@kdbg.org>
References: <1296751106-15316-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 21:17:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl5cc-00058m-GX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 21:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276Ab1BCURg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 15:17:36 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:22282 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751060Ab1BCURe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 15:17:34 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A9FBDA7EB2;
	Thu,  3 Feb 2011 21:16:54 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CA54919F5F2;
	Thu,  3 Feb 2011 21:17:32 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1296751106-15316-1-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165993>

On Donnerstag, 3. Februar 2011, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy wrote:
> Commit 21444f1 (Add case insensitivity support when using git ls-file=
s
> - 2010-10-03) teaches match_pathspec() to ignore case when
> core.ignorecase=3Dtrue.
>
> match_pathspec_depth() is developed independently and does not have
> this feature. Teach it.

Is match_pathspec_depth() used to match names of files on the filesyste=
m, or=20
names of files in the index or in the repository?

core.ignorecase should be honored only when files on the filesystem are=
=20
matched, IMO.

-- Hannes
