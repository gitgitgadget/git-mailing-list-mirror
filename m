From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/4] git-archive: wire up TAR format.
Date: Fri, 08 Sep 2006 22:21:35 +0200
Message-ID: <4501D0CF.70306@lsrfire.ath.cx>
References: <450019C3.4030001@innova-card.com> <11576347252834-git-send-email-vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 22:21:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLmr6-0001fZ-Af
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 22:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWIHUVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Sep 2006 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWIHUVg
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 16:21:36 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:36817
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751202AbWIHUVf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 16:21:35 -0400
Received: from [10.0.1.3] (p508E5573.dip.t-dialin.net [80.142.85.115])
	by neapel230.server4you.de (Postfix) with ESMTP id E30931903B;
	Fri,  8 Sep 2006 22:21:33 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <11576347252834-git-send-email-vagabon.xyz@gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26705>

=46ranck Bui-Huu schrieb:
> From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>

I did not sign off this exact patch.  I wrote and submitted the
builtin-tar-tree.c part, with memory leak and all, then sent a note
on where the leak needs to be plugged.  You put it together and
converted it to struct archiver_args.  I'd very much have liked to
see a comment stating this.  Or simply just say "based on code by
Rene" or something.  The same is true for patch 3/4.

> ---
>  archive.h          |    4 +++
>  builtin-archive.c  |    4 ++-
>  builtin-tar-tree.c |   67 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 74 insertions(+), 1 deletions(-)
>=20
> diff --git a/archive.h b/archive.h
> index f33398e..3690c53 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -37,5 +37,9 @@ extern void parse_treeish_arg(const char
> =20
>  extern void parse_pathspec_arg(const char **pathspec,
>  			       struct archiver_args *args);
> +/*
> + *
> + */

Especially I would not have signed off this invisible comment. ;)

Ren=E9
