From: Marcel Holtmann <marcel@holtmann.org>
Subject: Remove unneeded packs
Date: Sat, 12 Nov 2005 14:04:23 +0100
Message-ID: <1131800663.29461.11.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 12 14:05:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eav40-0002b5-MS
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 14:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKLNER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 08:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVKLNER
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 08:04:17 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:8857 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932265AbVKLNEQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 08:04:16 -0500
Received: from blade (p5487E170.dip.t-dialin.net [84.135.225.112])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id jACD4WGB025282
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 14:04:33 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.5.1 
X-Virus-Scanned: ClamAV 0.85.1/1169/Fri Nov 11 22:28:05 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11683>

Hi guys,

every time Linus re-creates the pack for his linux-2.6 tree, I end up
with another pack. I use HTTP as transport and thus the new pack will be
download (which is almost 100 MB), but that is fine. However it seems
that the old (previous) pack will never be deleted. For the no longer
needed object files I can use git-prune-packed, but the old pack I have
to identify and delete by myself. Exists an easy and nice way to get rid
of old unneeded packs? Can't git-prune-packed also do this job?

Regards

Marcel
