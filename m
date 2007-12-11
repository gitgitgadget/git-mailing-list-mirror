From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin
	command.
Date: Tue, 11 Dec 2007 18:38:06 -0500
Message-ID: <1197416286.7552.4.camel@hinata.boston.redhat.com>
References: <20071211195712.GA3865@bitplanet.net>
	 <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Egg-0002B7-Ey
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 00:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbXLKXiP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 18:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbXLKXiP
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 18:38:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42679 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbXLKXiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 18:38:14 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBBNcCDB000537;
	Tue, 11 Dec 2007 18:38:12 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBBNcCos016049;
	Tue, 11 Dec 2007 18:38:12 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBBNcBXx029192;
	Tue, 11 Dec 2007 18:38:11 -0500
In-Reply-To: <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67970>

On Tue, 2007-12-11 at 15:59 -0500, Daniel Barkalow wrote:
> On Tue, 11 Dec 2007, Kristian H=C3=B8gsberg wrote:
>=20
> > Ok, don't flame me, I know this isn't appropriate at the moment wit=
h
> > stabilization for 1.5.4 going on, but I just wanted to post a heads=
 up
> > on this work to avoid duplicate effort.  It's one big patch at this=
 point
> > and I haven't even run the test suite yet, but that will change.
>=20
> Is that why you misspelled Junio's email address? :)=20

Hehe, yeah, do not mess with maintainers in release mode :)

> Also as a heads-up, I've got a builtin-checkout that I've got passing=
 all=20
> the tests (plus a few to test stuff I originally hadn't implemented).=
 This=20
> mostly involved correcting the "interesting" states that unpack_trees=
()=20
> can leave the index in memory when it returns and figuring out how th=
e=20
> merge code works. I can send it off for review and testing to people =
who=20
> are interested and don't have other things they should be doing inste=
ad.

Thanks, that's useful, I was already considering what to do next.  I
wouldn't mind having a look, but maybe it's better to not discuss new
features on the list at this point.  I appreciate the heads up though.

cheers,
Kristian
