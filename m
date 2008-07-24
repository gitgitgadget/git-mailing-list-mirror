From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Thu, 24 Jul 2008 20:07:10 +0200
Message-ID: <20080724180710.GA26088@atjola.homenet>
References: <alpine.DEB.1.00.0807241821440.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, spearce@spearce.org,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5Ed-0004FN-KX
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYGXSHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYGXSHP
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:07:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:44873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751950AbYGXSHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:07:13 -0400
Received: (qmail invoked by alias); 24 Jul 2008 18:07:12 -0000
Received: from i577BA220.versanet.de (EHLO atjola.local) [87.123.162.32]
  by mail.gmx.net (mp065) with SMTP; 24 Jul 2008 20:07:12 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/Q5Tdx7w7QebnoygyeizSWscFSdG6o61AbHE/ele
	kJQJmloTFcaBqB
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807241821440.8986@racer>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89927>

On 2008.07.24 18:32:00 +0100, Johannes Schindelin wrote:
>=20
> From: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
>=20
> When index-pack completes a thin pack it appends objects to the pack.=
 =20
> Since the commit 92392b4(index-pack: Honor core.deltaBaseCacheLimit w=
hen=20
> resolving deltas) such an object can be pruned in case of memory
> pressure.
>=20
> To be able to re-read the object later, a few more fields have to be =
set.

Ah, thanks a lot! I tried to come up with a sane commit message
yesterday but totally failed, and then after a night of sneezing, I had
forgotten about it. And I wouldn't have managed to write an equally goo=
d
message anyway ;-)

> Noticed by Pierre Habouzit.
>=20
> Hopefully-signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>

Sure!

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>

Thanks,
Bj=F6rn
