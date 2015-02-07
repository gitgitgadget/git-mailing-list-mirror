From: Joachim Schmitz <jojo@schmitz-digital.de>
Subject: hang in git-upload-pack
Date: Sat, 7 Feb 2015 16:25:45 +0000 (UTC)
Message-ID: <loom.20150207T171056-519@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 17:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YK8Co-0005Av-5n
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 17:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbbBGQZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 11:25:54 -0500
Received: from plane.gmane.org ([80.91.229.3]:50358 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349AbbBGQZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 11:25:53 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YK8Cc-00055J-UO
	for git@vger.kernel.org; Sat, 07 Feb 2015 17:25:51 +0100
Received: from dslb-188-109-251-074.188.109.pools.vodafone-ip.de ([188.109.251.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 17:25:50 +0100
Received: from jojo by dslb-188-109-251-074.188.109.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 17:25:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.109.251.74 (Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263442>

Hi there

In HP-Nonstop we're experiencing hangs in git-upload-pack, which seems to 
be the result of reads from / writes to pipes don't ever finish or don't 
get interrupted properly (SIGPIPE, SIGCHLD?)

Any idea why that might be and how to fix it?


bye, Jojo
