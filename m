From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git svn: consistent spacing after "W:" in warnings
Date: Fri, 8 Mar 2013 10:01:52 +0000
Message-ID: <20130308100152.GA32643@dcvr.yhbt.net>
References: <000e01ce1b26$dbb65570$93230050$@certicon.cz>
 <20130308095330.GA20205@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, 'Matthieu Moy' <Matthieu.Moy@grenoble-inp.fr>,
	'Sam Vilain' <sam@vilain.net>,
	Jan =?utf-8?B?UGXFoXRh?= <jan.pesta@certicon.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 11:02:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDu84-0007iV-3s
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 11:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236Ab3CHKBy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 05:01:54 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54071 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684Ab3CHKBx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 05:01:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9554E1F6E1;
	Fri,  8 Mar 2013 10:01:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130308095330.GA20205@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217655>

Eric Wong <normalperson@yhbt.net> wrote:
> will push another change for formatting existing warnings more
> consistently.

  Just pushed.  My master is sitting at git://git.bogomips.org/git-svn.=
git
  commit eae6cf5aa8ae2d8a90a99bbe4aeb01c29e01fd02

  Eric Wong (1):
        git svn: consistent spacing after "W:" in warnings

  Jan Pe=C5=A1ta (1):
        git svn: ignore partial svn:mergeinfo

  I don't have further updates planned, maybe others do.
----------------------------8<------------------------------
=46rom eae6cf5aa8ae2d8a90a99bbe4aeb01c29e01fd02 Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Fri, 8 Mar 2013 09:46:41 +0000
Subject: [PATCH] git svn: consistent spacing after "W:" in warnings

All other instances of "W:"-prefixed warning messages have a space afte=
r
the "W:" to help with readability.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 46aeb85..5273ee8 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1504,7 +1504,7 @@ sub lookup_svn_merge {
 		my $top_commit =3D $gs->find_rev_before( $top, 1, $bottom );
=20
 		unless ($top_commit and $bottom_commit) {
-			warn "W:unknown path/rev in svn:mergeinfo "
+			warn "W: unknown path/rev in svn:mergeinfo "
 				."dirprop: $source:$range\n";
 			next;
 		}
--=20
Eric Wong
