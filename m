From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] gitattributes documentation: link to gitignore for glob format
Date: Sun, 21 Sep 2008 15:00:05 +0200
Message-ID: <C4AD5305-CDD8-418D-95C8-C738A86E78E1@wincent.com>
References: <1222001031-11382-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 15:01:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhOYy-0003x2-F9
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 15:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYIUNAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 09:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYIUNAL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 09:00:11 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:35386 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbYIUNAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Sep 2008 09:00:10 -0400
Received: from cuzco.lan (97.pool85-53-24.dynamic.orange.es [85.53.24.97])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m8LD06Rc018005
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 21 Sep 2008 09:00:08 -0400
In-Reply-To: <1222001031-11382-1-git-send-email-pclouds@gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96394>

El 21/9/2008, a las 14:43, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy es=
cribi=C3=B3:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> Documentation/gitattributes.txt |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/=20
> gitattributes.txt
> index 9a75257..45c11df 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -21,7 +21,9 @@ Each line in `gitattributes` file is of form:
> 	glob	attr1 attr2 ...
>
> That is, a glob pattern followed by an attributes list,
> -separated by whitespaces.  When the glob pattern matches the
> +separated by whitespaces. Glob pattern format is as same as

It's "whitespace", not "whitespaces". And the sentence you added has =20
two errors:

"as same as" should be "the same as"

> +one used by `gitignore` files. Please refer to linkgit:gitignore[5]
> +for more information. When the glob pattern matches the

And: "as one" should be "as the one".

And as a style point, you probably should start the sentence with "The =
=20
glob pattern" rather than "Glob pattern".

Did you actually proofread this before sending it?

Cheers,
Wincent
