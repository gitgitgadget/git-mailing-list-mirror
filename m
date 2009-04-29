From: Olaf Hering <olaf@aepfle.de>
Subject: Invalid search parameter in webinterface
Date: Wed, 29 Apr 2009 11:12:54 +0200
Message-ID: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 11:24:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz62D-0003iE-3t
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 11:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758811AbZD2JYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 05:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758287AbZD2JYP
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 05:24:15 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:18319 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758760AbZD2JYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 05:24:14 -0400
X-Greylist: delayed 678 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2009 05:24:14 EDT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1240997049; l=414;
	s=domk; d=aepfle.de;
	h=Date:Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:To:
	From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=Xb63iTXe4z/mYZkaWIvR8q93UWs=;
	b=J3nxnw9kndhjpFz0jqPf7RoT0+jNjJ0/mSj5FRa5PXfXbB+5iFpXbqLGFAAxZFbjeEY
	uZPLCZU1OsawAd9D2eYUQEtaG4EddJyI2ClFTnJyi9F43qDbFrZIwZt9W7BCG5qUzxDCo
	RqmHOvOUHxF5XadBZQn2uULKC5ukjkZZebQ=
X-RZG-AUTH: :P2EQZQWpfu9jTztxfPzuU9A5K3T2AgG4vCx9L62AnOp4JNgVHIVt
X-RZG-CLASS-ID: mo05
Received: from [192.168.2.100]
	(dslb-084-057-095-146.pools.arcor-ip.net [84.57.95.146])
	by post.strato.de (mrclete mo45) (RZmta 18.31)
	with AES128-SHA encrypted ESMTP id 6000f7l3T83VoO
	for <git@vger.kernel.org>; Wed, 29 Apr 2009 11:12:54 +0200 (MEST)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117872>


Hello.

An 'author' search string like "torvalds@linux" at
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git
generates a 'next' link due to the huge number of commits.

This link has an incorrect escaping for the @ sign.
The backslash does not work, it generates an error:

403 Forbidden - Invalid search parameter

It should be s=torvalds%40linux instead of s=torvalds\@linux

Olaf
