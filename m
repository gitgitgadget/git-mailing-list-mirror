From: bruce <bruce.e.robertson@intel.com>
Subject: orphan blob or what?
Date: Thu, 08 Nov 2012 16:24:36 -0800
Message-ID: <87a9urlj23.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 01:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWcOw-0002Dl-PB
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 01:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289Ab2KIAYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 19:24:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:25405 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755Ab2KIAYh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 19:24:37 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 08 Nov 2012 16:24:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,741,1344236400"; 
   d="scan'208";a="217043000"
Received: from brucer42-desktop.jf.intel.com (HELO brucer42-desktop) ([10.7.197.86])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2012 16:24:36 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209197>

In today's and older clones of https://github.com/mirrors/linux.git I
find this object, 6fa98ea0ae40f9a38256f11e5dc270363f785aee, that I can't
figure out how to eliminate^h^h^h^h^h^h^h^h^hget rid of. I don't see it
in 'git fsck', 'git gc --aggressive --prune' doesn't seem to prune it,
can't see it via 'git log'. And yet

linux/.git/objects/pack$ git verify-pack -v *.idx | grep 6fa98ea0ae40f9a38256f11e5dc270363f785aee
6fa98ea0ae40f9a38256f11e5dc270363f785aee blob   1519697 124840 515299673
8231eaa31ce1107c1463deb6ec33f61618aedbb9 blob   67 63 515424513 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
f21a8c1b9d47736fa4e27def66f04b9fe2b4bc53 blob   90 83 515424576 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee

Thanks,
bruce
