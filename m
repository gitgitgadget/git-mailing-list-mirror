From: Alex <ajb44.geo@yahoo.com>
Subject: Re: Multiple clients accessing git over NFS
Date: Tue, 16 Nov 2010 13:47:02 +0000 (UTC)
Message-ID: <loom.20101116T144422-559@post.gmane.org>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 16 14:47:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PILsV-0004Yo-M3
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 14:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870Ab0KPNrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Nov 2010 08:47:15 -0500
Received: from lo.gmane.org ([80.91.229.12]:60315 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757525Ab0KPNrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 08:47:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PILsP-0004Wr-A5
	for git@vger.kernel.org; Tue, 16 Nov 2010 14:47:13 +0100
Received: from 212.44.20.129.ip.redstone-isp.net ([212.44.20.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 14:47:13 +0100
Received: from ajb44.geo by 212.44.20.129.ip.redstone-isp.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 14:47:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.44.20.129 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.11) Gecko/2009060403 Red Hat/3.0.11-4.el4 Firefox/3.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161562>


Khawaja Shams <kshams <at> usc.edu> writes:

>=20
> =C2=A0=C2=A0Is it a recommended practice to share a repository over N=
=46S, where
> multiple clients can be pushing changes simultaneously?=C2=A0 In our
> production environment, we have a Git repository setup behind
> git-http-backend. We would like to place multiple Apache servers
> behind a load balancer to maximize availability and performance.
> Before we proceed, we wanted to check to see if this practice has a
> potential to cause repository corruption. If there are other ways
> others have solved this problem, we would be very interested in
> learning about those as well. Thank you.
>=20


Others have commented on the git aspects of this, but FYI there is a ha=
ndy
program here: http://www.unixcoding.org/NFSCoding#NFS_Cache_Tester
that tests aspects of your NFS implementation. (Sadly the one we have
at work is crap, or at least it was last time I ran the program).

Alex
=20
