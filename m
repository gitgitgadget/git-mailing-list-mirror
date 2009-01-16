From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Confusing text in git-prune.txt
Date: Fri, 16 Jan 2009 17:50:13 +0100
Message-ID: <20090116165013.GA14196@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 17:51:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrv3-0004aA-38
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbZAPQuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 11:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbZAPQuR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:50:17 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1033
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbZAPQuP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 11:50:15 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 21B9D801C0E0
	for <git@vger.kernel.org>; Fri, 16 Jan 2009 17:50:14 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LNrtd-0003kW-CA
	  for git@vger.kernel.org; Fri, 16 Jan 2009 17:50:13 +0100
Content-Disposition: inline
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105975>

=46rom git-prune.txt:

    [...] prunes all unpacked objects unreachable from any of
    these head objects from the object database. In addition,
    it prunes the unpacked objects that are also found in packs by
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    running git-prune-packed.

How can "unpacked objects" be "found in packs"? Maybe the first
"unpacked" should be "unreachable". But if that's the case, wouldn't
this be better:

    [...] prunes from the object database all objects unreachable from
    any of these heads. Prunning already-packed objects is done with
    the help of git-prune-packed.

Thoughts? Or am I reading the original text wrong?

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
I promise you. Once I enter into an exclusive relationship, I sleep wit=
h
very few people.
                -- Denny Crane
