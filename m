From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 12:10:19 -0700
Message-ID: <432F0D1B.60303@zytor.com>
References: <200509172141.31591.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 21:13:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHR28-0002aL-0C
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 21:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVISTK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Sep 2005 15:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVISTK1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 15:10:27 -0400
Received: from terminus.zytor.com ([209.128.68.124]:35467 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932593AbVISTK1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 15:10:27 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8JJAOGC005979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 12:10:24 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200509172141.31591.dtor_core@ameritech.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8898>

Dmitry Torokhov wrote:
>=20
> git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux-2.6.git work
>=20
> and it seems there is some garbage in .git directory:
>=20
> [dtor@anvil work]$ ls -la .git/
> total 40
> drwxrwxr-x    9 dtor dtor 4096 Sep 17 21:17 .
> drwxrwxr-x    3 dtor dtor 4096 Sep 17 21:17 ..
> drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 branches
> -rw-rw-r--    1 dtor dtor   58 Sep 17 21:17 description
> lrwxrwxrwx    1 dtor dtor   17 Sep 17 21:17 HEAD -> refs/heads/master
> drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 hooks
> drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 info
> drwxr-xr-x  260 dtor dtor 4096 Sep 17 17:41 objects
> drwxrwxr-x    4 dtor dtor 4096 May  1 19:15 refs
> drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:28 remotes
> drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 V?Cl?=EF=BF=BD?E ???#V?C?=
?=C5=BFl??E#V?C??;H
>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^
>=20
> The similar garbage(?) shows when I clone git's repository.
>=20

=46WIW, using cg-clone (using git-core 0.99.6 and cogito 0.14.1) I keep=
=20
finding a directory in .git which consists of a single DEL character (\=
177).

	-hpa
