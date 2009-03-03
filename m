From: Jonas Smedegaard <dr@jones.dk>
Subject: [TopGit] Multiple concurrent sets of patches
Date: Tue, 3 Mar 2009 12:37:41 +0100
Message-ID: <20090303113741.GO12820@jones.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 12:45:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeT4B-0006iu-Ni
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbZCCLoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 06:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbZCCLoJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:44:09 -0500
Received: from 0x573b188a.cpe.ge-1-2-0-1101.hknqu1.customer.tele.dk ([87.59.24.138]:58767
	"EHLO xayide.jones.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbZCCLoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:44:08 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2009 06:44:07 EST
Received: from localhost (localhost [127.0.0.1])
	by xayide.jones.dk (Postfix) with ESMTP id B976A11B7FA
	for <git@vger.kernel.org>; Tue,  3 Mar 2009 12:37:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at jones.dk
Received: from xayide.jones.dk ([127.0.0.1])
	by localhost (xayide.jones.dk [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id hr1scyElN-FL for <git@vger.kernel.org>;
	Tue,  3 Mar 2009 12:37:48 +0100 (CET)
Received: from auryn.jones.dk (auryn.jones.dk [192.168.222.52])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by xayide.jones.dk (Postfix) with ESMTPS id CDF1F11B7F9
	for <git@vger.kernel.org>; Tue,  3 Mar 2009 12:37:48 +0100 (CET)
Received: by auryn.jones.dk (Postfix, from userid 1000)
	id 7388A356EE; Tue,  3 Mar 2009 12:37:41 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Face: "yShHCQ6@h{]=Se"1&kVc#Yd%l<B\s%RAjk)T'F6yYw3/unDabXtVB2LIg(-J0zo^aE2 U[s (uhG@f$_ZpbxE53gCn:WZ_a.Gz8yI;ko-,iqW@*+8k<F$2G-nyl;^55>b=>9&
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112058>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have run into a challenge that I suspect is a limitation of current 
TopGit. I am hoping you could help enlighten me, as I otherwise feel 
that TopGit is not generally usable for my Debian packaging needs:

How to manage patches against multiple source branches using TopGit?

Let's take netatalk as an example. Upstream only quite infrequently 
release new upstream tarball releases, so I cherry-pick patches from 
upstream VCS. Recently a security-related bug was discovered which 
needed fixing not only in the current packaging development (git master 
branch) but also needed branching off earlier releases of the package 
(those included in the "stable" and "oldstable" Debian distro releases) 
and applying same fix for them.

The actual patch needed for the various branches was obviously not 
identical, as upstream sources were different and my cherry-picked set 
of patches had evolved.

It seems to me that TopGit is incapable of handling this. That it can 
only handle patchset against a single branch, and if the need arise for 
restructuring an additional patchset for e.g. a stable or oldstable 
branch, then quilt needs to be used manually anyway.


   - Jonas

Debian developer

- -- 
* Jonas Smedegaard - idealist og Internet-arkitekt
* Tlf.: +45 40843136  Website: http://dr.jones.dk/

   [x] quote me freely  [ ] ask before reusing  [ ] keep private
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmtFoUACgkQn7DbMsAkQLgvrACdHfy5K0igPa6Yj/LYyhh3Llyn
jvcAnRfla1QyuUrx8+L4IL9XYY2CB+Su
=B1Kc
-----END PGP SIGNATURE-----
