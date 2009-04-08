From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 6/8] archive: use index instead of parsing tree directly
Date: Wed, 08 Apr 2009 23:02:35 +0200
Message-ID: <49DD10EB.3090706@lsrfire.ath.cx>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> <1239185133-4181-2-git-send-email-pclouds@gmail.com> <1239185133-4181-3-git-send-email-pclouds@gmail.com> <1239185133-4181-4-git-send-email-pclouds@gmail.com> <1239185133-4181-5-git-send-email-pclouds@gmail.com> <1239185133-4181-6-git-send-email-pclouds@gmail.com> <1239185133-4181-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 23:05:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrex5-0006Cz-Go
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 23:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764191AbZDHVCu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757807AbZDHVCu
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 17:02:50 -0400
Received: from india601.server4you.de ([85.25.151.105]:47822 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760243AbZDHVCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 17:02:49 -0400
Received: from [10.0.1.101] (p57B7EF55.dip.t-dialin.net [87.183.239.85])
	by india601.server4you.de (Postfix) with ESMTPSA id 0A7032F8043;
	Wed,  8 Apr 2009 23:02:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239185133-4181-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116123>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> Currently:
>=20
>  - "git archive" parses trees directly
>  - attr mechanism does not support in-tree attributes
>=20
> Making attr.c support in-tree attributes is quite a non-trivial task,
> IMHO. Instead this patch makes "git archive" read tree to index first=
,
> then start exporting from there.
>=20
> One minor regression: "git archive" now will no longer generate
> directory entries, only files.

I don't like the need to prepare an index of all paths up front, but
that's just a gut feeling.  I haven't looked into implementing in-tree
attribute support in attr.c; is it really that hard?  Other commands
would benefit from this, too, right (e.g. any command using attributes
in a bare repo)?

Ren=C3=A9
