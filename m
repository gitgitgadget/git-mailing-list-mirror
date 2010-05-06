From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 13:20:18 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
 <20100506094212.GB9921@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 06 13:20:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9z80-0007Wj-Sw
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 13:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab0EFLUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 07:20:23 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:42114 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab0EFLUW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 07:20:22 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o46BKJm9005997;
	Thu, 6 May 2010 13:20:19 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 6 May 2010 13:20:19 +0200
Thread-Topic: Any way to get complete diff up to a tag?
Thread-Index: AcrtAJB2Yj27ehQiTwWwGMqsTT6W5QADQ7sw
In-Reply-To: <20100506094212.GB9921@atjola.homenet>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146474>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Bj=F6rn Steinbrink
> Sent: den 6 maj 2010 11:42
> To: Peter Kjellerstedt
> Cc: git@vger.kernel.org
> Subject: Re: Any way to get complete diff up to a tag?
>=20
> On 2010.05.06 11:27:40 +0200, Peter Kjellerstedt wrote:
> > If I use
> >
> > $ git diff $(git rev-list --reverse v1.7.1 |head -1)..v1.7.1
> >
> > I almost get what I want, but the initial commit is still missing.
> > Is there any way to get that initial commit included in the diff?
>=20
> git internally knows about the empty tree, so you can use:
> git diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904 v1.7.1
>=20
> Bj=F6rn

Thank you, that was useful. However, I need to be able to do this
for an arbitrary repository, and that SHA seems to be specific for=20
the git repository. How do I get the SHA for the empty tree in an=20
arbitrary repository?

//Peter
