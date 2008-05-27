From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git log --grep missing entries?
Date: Tue, 27 May 2008 22:40:32 +0200
Message-ID: <20080527204032.GA26161@atjola.homenet>
References: <20080527202842.GA32252@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Tue May 27 22:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15z6-0000rw-BU
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158AbYE0Ukg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 16:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756428AbYE0Ukg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:40:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:53693 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756416AbYE0Ukg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:40:36 -0400
Received: (qmail invoked by alias); 27 May 2008 20:40:33 -0000
Received: from i577B80F6.versanet.de (EHLO atjola.local) [87.123.128.246]
  by mail.gmx.net (mp026) with SMTP; 27 May 2008 22:40:33 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+H2LwKVFGHKJO0wJ3TfXlaO7VlfZIluCxrK1giTg
	5YXAtjEgLL0x90
Content-Disposition: inline
In-Reply-To: <20080527202842.GA32252@foursquare.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83046>

On 2008.05.27 16:28:42 -0400, Chris Frey wrote:
> Hi,
>=20
> I ran into this the other day when I was looking at jgit's log histor=
y.
> I retested today with the latest master branch, and it does the same =
thing.
>=20
> So... what am I doing wrong?
>=20
> 	git clone git://repo.or.cz/egit/spearce.git bsd
> 	git log |grep "^Author:" | sort | uniq
>=20
> 	# note the user: Thad Hughes <thadh@thad.corp.google.com>
>=20
> 	# nothing appears for these commands
> 	git log --grep=3D"thadh@thad.corp.google.com"
> 	git log --grep=3D"google.com"
> 	git log --grep=3D"thadh"
>=20
> 	# this works
> 	git log --author=3D"thadh@thad.corp.google.com"
>=20
> 	# this works
> 	git log | grep thadh@thad.corp.google.com

--grep only works on the log message, not on the author or committer
fields. As Thad's commit does not have a SoB line, --grep won't find it=
=2E

Bj=F6rn
