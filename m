From: David Roden <david.roden@sysart.de>
Subject: Re: How do I show only log messages for commits on a specific branch?
Date: Thu, 17 Dec 2009 10:20:35 +0100
Organization: Sysart UG =?UTF-8?B?KGhhZnR1bmdzYmVzY2hyw6Rua3Qp?=
Message-ID: <hgct5i$fbg$1@ger.gmane.org>
References: <20091216101647.GB27373@bc-bd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 10:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLCqL-0000cI-Lj
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 10:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764240AbZLQJkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 04:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764232AbZLQJkN
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 04:40:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:48768 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759208AbZLQJkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 04:40:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NLCq4-0000VW-W5
	for git@vger.kernel.org; Thu, 17 Dec 2009 10:40:05 +0100
Received: from p548ee7b7.dip.t-dialin.net ([84.142.231.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 10:40:04 +0100
Received: from david.roden by p548ee7b7.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 10:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p548ee7b7.dip.t-dialin.net
User-Agent: KNode/4.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135363>

bd@bc-bd.org wrote:

> imagine this:
>=20
> --A--*--B (new)
> /
> *--X--*--Y (master)
>=20
> Now I'd like to list only log messages for A..B (X..B would be okay t=
oo).
>=20
> I know of
>=20
> git log master..new
>=20
> however then I need to remember that I branched new of master, and to=
 be
> honest, sometimes I forget.
>=20
> So how do I:
>=20
> git please-tell-me-the-branch-I-started-this-branch-from new
>=20
> Thanks in advance,

I have had wonderful results using

    git log new --not master

or

    git log new ^master

This is using git 1.6.4.4 and this way of specifying commits is not=20
mentioned in the man page=E2=80=94it seems to work, though.

	David
