From: Jon Loeliger <jdl@freescale.com>
Subject: git-fsck-cache cleaning
Date: Tue, 02 Aug 2005 17:24:41 -0500
Message-ID: <1123021481.2614.6.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 03 00:25:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E05Bo-0006l6-UL
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 00:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVHBWYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 18:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVHBWYo
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 18:24:44 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:13237 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261453AbVHBWYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2005 18:24:44 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id j72MUupj026649
	for <git@vger.kernel.org>; Tue, 2 Aug 2005 15:30:56 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j72MTOxW000029
	for <git@vger.kernel.org>; Tue, 2 Aug 2005 17:29:24 -0500 (CDT)
To: Git List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi GITers,

So, after you dink around in a GIT tree for a while,
and you discover little bloblets left around by using
git-fsck-cache, what do you do?  How can you clean up
afterwards?

Specifically, I have a GIT tree that shows some dangling
blobs that are unreferenced in my tree.  Not sure how the
got there, but I've verified through git-cat-file that
the contents of many of those blobs are actually validly
represented in my tree.  Yet, fsck suggests they dangle.

So, for each of the various fsck warnings, what can be
done to clean things up and yet maintain integrity in
the tree?  I have apparently unreferenced blobs.  I should
be able to just "rm .git/objects/xx/<sha1>" and be done
with them, right?  What about the other warnings?

Thanks,
jdl
