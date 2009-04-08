From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/8] archive: add shortcuts for --format and --prefix
Date: Wed, 08 Apr 2009 21:51:31 +0200
Message-ID: <49DD0043.9080803@lsrfire.ath.cx>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> <1239185133-4181-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 21:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrdpu-000511-15
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 21:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764392AbZDHTvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 15:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761571AbZDHTvu
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 15:51:50 -0400
Received: from india601.server4you.de ([85.25.151.105]:59112 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461AbZDHTvt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 15:51:49 -0400
Received: from [10.0.1.101] (p57B7EF55.dip.t-dialin.net [87.183.239.85])
	by india601.server4you.de (Postfix) with ESMTPSA id 32E622F8043;
	Wed,  8 Apr 2009 21:51:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1239185133-4181-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116116>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> +-f=3D<fmt>::
>  --format=3D<fmt>::
>  	Format of the resulting archive: 'tar' or 'zip'.  The default
>  	is 'tar'.
> @@ -45,6 +46,7 @@ OPTIONS
>  --verbose::
>  	Report progress to stderr.
> =20
> +-p=3D<prefix>/::
>  --prefix=3D<prefix>/::
>  	Prepend <prefix>/ to each filename in the archive.

With short options, you can't use an equal sign to separate their
parameters (-f=3D<fmt> vs. -f<fmt>).

Ren=C3=A9
