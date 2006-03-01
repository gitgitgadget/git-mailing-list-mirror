From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 1/2] Let git-svnimport's author file use same syntax as
	git-cvsimport's
Date: Wed, 01 Mar 2006 15:19:53 -0600
Message-ID: <1141247993.12729.42.camel@cashmere.sps.mot.com>
References: <440195D4.7080905@op5.se>
	 <20060227230814.12298.63006.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 22:20:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEYjw-0003SZ-NK
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 22:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWCAVT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 1 Mar 2006 16:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWCAVT7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 16:19:59 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:51116 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751914AbWCAVT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 16:19:58 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k21LaY2J024856;
	Wed, 1 Mar 2006 14:36:35 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k21LTJnE015927;
	Wed, 1 Mar 2006 15:29:20 -0600 (CST)
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060227230814.12298.63006.stgit@backpacker.hemma.treskal.com>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17013>

On Mon, 2006-02-27 at 17:08, Karl Hasselstr=F6m wrote:

> diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svni=
mport.txt
> index e0e3a5d..912a808 100644
> --- a/Documentation/git-svnimport.txt
> +++ b/Documentation/git-svnimport.txt
> @@ -75,9 +75,9 @@ When importing incrementally, you might=20
>  -A <author_file>::
>  	Read a file with lines on the form
> =20
> -	  username User's Full Name <email@addres.org>
> +	  username =3D User's Full Name <email@addr.es>
> =20
> -	and use "User's Full Name <email@addres.org>" as the GIT
> +	and use "User's Full Name <email@addr.es>" as the GIT
>  	author and committer for Subversion commits made by
>  	"username". If encountering a commit made by a user not in the
>  	list, abort.

Actually, I believe that "example.com" was reserved
specifically for instances such as this.

See:
    http://www.faqs.org/rfcs/rfc2606.html

jdl
