From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 17:27:17 +0200
Message-ID: <20100506152717.GA12230@atjola.homenet>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
 <20100506094212.GB9921@atjola.homenet>
 <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
 <4BE2BE2C.8050403@viscovery.net>
 <A612847CFE53224C91B23E3A5B48BAC74482E50F03@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu May 06 17:27:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA2z4-0007ys-BO
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 17:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758814Ab0EFP1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 11:27:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:34285 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754449Ab0EFP1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 11:27:23 -0400
Received: (qmail invoked by alias); 06 May 2010 15:27:20 -0000
Received: from i59F54DBC.versanet.de (EHLO atjola.homenet) [89.245.77.188]
  by mail.gmx.net (mp063) with SMTP; 06 May 2010 17:27:20 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19HB9UNlwtHNzvDfMHERMt7huS2dfmpB5PPTJYiYz
	7pmwVtwy7eerrQ
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74482E50F03@xmail3.se.axis.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146481>

On 2010.05.06 17:09:57 +0200, Peter Kjellerstedt wrote:
>=20
> Well, I figured out my mistake. I had abbreviated the SHA1 since I
> typed it in manually, and it worked fine in git's own repository,=20
> but not in another repository. But when I used the full SHA1 it=20
> worked in both. So I guess the empty dir SHA1 hardcoded in git just=20
> happened to be the SHA1 for the empty dir in git's own repository...

No, there can be only one SHA1 for the empty tree. It's the SHA1 hash o=
f
the object, and the empty tree is the empty tree, always.

git.git just happens to actually contain that object, so the abbreviate=
d
hash works, because git can find the object and doesn't actually need
the hardcoded built-in empty tree (which is only used when the full has=
h
is given).

Bj=F6rn
