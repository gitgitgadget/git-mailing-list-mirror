From: Gilles Filippini <gilles.filippini@free.fr>
Subject: Re: [PATCH] contrib/subtree - unset prefix before proceeding
Date: Mon, 03 Mar 2014 15:53:28 +0100
Message-ID: <53149768.4090200@free.fr>
References: <53120BDC.9000406@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 15:53:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKUFU-0004Mc-7y
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 15:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbaCCOxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 09:53:37 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:37468 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035AbaCCOxg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 09:53:36 -0500
Received: from [129.200.100.4] (unknown [88.189.102.17])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C47BF9400D4
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 15:53:29 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53120BDC.9000406@free.fr>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243224>

Hi,

Any chance to have this patch considered?
Thanks in advance,

_g.

Gilles Filippini a =C3=A9crit , Le 01/03/2014 17:33:
> This is to prevent unwanted prefix when such an environment variable
> exists. The case occurs for example during the Debian package build
> where the git-subtree test suite is called with 'prefix=3D/usr', whic=
h
> makes test 21 fail:
> not ok 21 - Check that prefix argument is required for split
>=20
> Signed-off-by: Gilles Filippini <gilles.filippini@free.fr>
> ---
>  contrib/subtree/git-subtree.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-sub=
tree.sh
> index dc59a91..db925ca 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -46,6 +46,7 @@ ignore_joins=3D
>  annotate=3D
>  squash=3D
>  message=3D
> +prefix=3D
> =20
>  debug()
>  {
>=20
