From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: specifying one-side of a merge commit?
Date: Thu, 12 Aug 2010 08:11:11 +0200
Message-ID: <20100812061111.GA25026@atjola.homenet>
References: <AANLkTi=mnO8+XM4Bcjneaq+ngUSFesvZ_TYMRyy=f43a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 08:11:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjR0g-0005UU-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 08:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758717Ab0HLGLX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 02:11:23 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:38235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1758691Ab0HLGLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 02:11:21 -0400
Received: (qmail invoked by alias); 12 Aug 2010 06:11:19 -0000
Received: from i59F57E1E.versanet.de (EHLO atjola.homenet) [89.245.126.30]
  by mail.gmx.net (mp007) with SMTP; 12 Aug 2010 08:11:19 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX193RXQ9Unt32VOAY5x0YrlWmuZ/nrOHLVgo6SdH+/
	Mu05VaO1EdUtkW
Content-Disposition: inline
In-Reply-To: <AANLkTi=mnO8+XM4Bcjneaq+ngUSFesvZ_TYMRyy=f43a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153345>

On 2010.08.12 13:11:52 +0800, Tay Ray Chuan wrote:
> Hi,
>=20
> I wonder how do you guys do this?
>=20
> So far, what I've come up with is this:
>=20
>   $ git rev-list $MERGE ^$MERGE^ | head -2 | tail -1
>=20
> I'm sure there's a better way.

Are you looking for $MERGE^2? See SPECIFYING REVISIONS in
git-rev-parse(1).

Bj=F6rn
