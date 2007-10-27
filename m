From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Add NEED_WORK_TREE for more commands
Date: Sat, 27 Oct 2007 11:08:22 +0200
Organization: glandium.org
Message-ID: <20071027090822.GA6789@glandium.org>
References: <20071027081910.GA23381@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 11:09:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilhfs-0005Z6-7c
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 11:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbXJ0JJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbXJ0JJb
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 05:09:31 -0400
Received: from vawad.err.no ([85.19.200.177]:48882 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbXJ0JJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 05:09:30 -0400
Received: from aputeaux-153-1-53-36.w82-124.abo.wanadoo.fr ([82.124.139.36] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IlhfM-0007ww-24; Sat, 27 Oct 2007 11:09:14 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IlheY-0001mi-5P; Sat, 27 Oct 2007 11:08:22 +0200
Content-Disposition: inline
In-Reply-To: <20071027081910.GA23381@laptop>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62479>

On Sat, Oct 27, 2007 at 03:19:10PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  git.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/git.c b/git.c
> index 23a430c..9db40b3 100644
> --- a/git.c
> +++ b/git.c
> +		{ "ls-files", cmd_ls_files, RUN_SETUP | NEED_WORK_TREE },
> +		{ "update-index", cmd_update_index, RUN_SETUP | NEED_WORK_TREE },

At least these two work very fine without a working tree (and I *do*
need them to work without a working tree).

Mike
