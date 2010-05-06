From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 11:42:12 +0200
Message-ID: <20100506094212.GB9921@atjola.homenet>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu May 06 11:42:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9xbD-0001hJ-7X
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab0EFJmR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 05:42:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:56462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751534Ab0EFJmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 05:42:16 -0400
Received: (qmail invoked by alias); 06 May 2010 09:42:14 -0000
Received: from i59F54DBC.versanet.de (EHLO atjola.homenet) [89.245.77.188]
  by mail.gmx.net (mp029) with SMTP; 06 May 2010 11:42:14 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19N0aV0zeNNfacAuaZ6cVh1xXt+rVxFxTBRqU5GZj
	Arq2yRPgdeCbKA
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146470>

On 2010.05.06 11:27:40 +0200, Peter Kjellerstedt wrote:
> If I use
>=20
> $ git diff $(git rev-list --reverse v1.7.1 |head -1)..v1.7.1
>=20
> I almost get what I want, but the initial commit is still missing.
> Is there any way to get that initial commit included in the diff?

git internally knows about the empty tree, so you can use:
git diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904 v1.7.1

Bj=F6rn
