From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] format-patch: add --prefix to prepend a prefix to output
 file names
Date: Tue, 09 Jun 2009 15:30:47 +0200
Message-ID: <4A2E6407.1010402@viscovery.net>
References: <1244547227-6466-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 15:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME1Pm-0001mt-6t
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 15:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758451AbZFINat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 09:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757699AbZFINas
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 09:30:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29792 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757409AbZFINar convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 09:30:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1ME1Pb-0004SI-MP; Tue, 09 Jun 2009 15:30:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 647376B7; Tue,  9 Jun 2009 15:30:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1244547227-6466-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121173>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> I use git to manages patches in my Gentoo development. In Gentoo,
> all ebuilds (another form of RPM spec) corresponding to different
> versions of the same package are grouped into one directory. So patch=
es
> for each versions usually have a prefix to separate them from the one=
s
> for other versions. With --prefix it comes handy to produce such patc=
hes,
> for example:
>=20
> git format-patch --prefix dbus-1.2.3- HEAD~5
>=20
> will generate patches for dbus-1.2.3 for me, all starting with "dbus-=
1.2.3-".

Can't you use --output-directory/-o? It is not the same, but almost.

-- Hannes
