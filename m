From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 2/2] ls-files: fix broken --no-empty-directory
Date: Sun, 8 Mar 2009 22:13:12 +0100
Message-ID: <20090308211312.GE4371@genesis.frugalware.org>
References: <20090308012049.GA18616@coredump.intra.peff.net> <20090308012722.GB18714@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VI7iFJw/I65Bwf78"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQKc-0000vx-KQ
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 22:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbZCHVNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 17:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754200AbZCHVNS
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 17:13:18 -0400
Received: from virgo.iok.hu ([212.40.97.103]:41099 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbZCHVNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 17:13:17 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7C20758140;
	Sun,  8 Mar 2009 22:13:14 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4525644777;
	Sun,  8 Mar 2009 22:13:13 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F31D811B877E; Sun,  8 Mar 2009 22:13:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090308012722.GB18714@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112644>


--VI7iFJw/I65Bwf78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 07, 2009 at 08:27:22PM -0500, Jeff King <peff@peff.net> wrote:
> diff --git a/builtin-ls-files.c b/builtin-ls-files.c
> index 1742c0f..437c366 100644
> --- a/builtin-ls-files.c
> +++ b/builtin-ls-files.c
> @@ -454,8 +454,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
>  		OPT_BIT(0, "directory", &dir.flags,
>  			"show 'other' directories' name only",
>  			DIR_SHOW_OTHER_DIRECTORIES),
> -		OPT_BIT(0, "empty-directory", &dir.flags,
> -			"list empty directories",
> +		OPT_BIT(0, "no-empty-directory", &dir.flags,
> +			"don't show empty directories",
>  			DIR_HIDE_EMPTY_DIRECTORIES),
>  		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
>  			"show unmerged files in the output"),

Thanks for catching this. But then why not using PARSE_OPT_NONEG?

That would avoid --no-no-empty-directory.

--VI7iFJw/I65Bwf78
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm0NOgACgkQe81tAgORUJZOFgCgjiYRxznkaE8s3ou1neFdC5Pt
/JYAn1kkCe0dgwz8r19Gu6JNuafjabvg
=nwJj
-----END PGP SIGNATURE-----

--VI7iFJw/I65Bwf78--
