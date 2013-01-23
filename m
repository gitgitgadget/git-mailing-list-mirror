From: Don Marti <dmarti@perforce.com>
Subject: Defensive publication on Git replication
Date: Wed, 23 Jan 2013 10:00:10 -0800 (PST)
Message-ID: <4e91728c-ea52-448d-8174-f8487768a505@caret.perforce.com>
References: <a3951c54-efb8-476f-952f-4893bcc5e4a9@caret.perforce.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 19:10:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty4lz-0000po-6h
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 19:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab3AWSJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 13:09:45 -0500
Received: from waypost.perforce.com ([206.173.243.13]:45484 "EHLO
	waypost.perforce.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab3AWSJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 13:09:45 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2013 13:09:45 EST
Received: from imappy.perforce.com ([10.0.50.41])
  by mx2.perforce.com with ESMTP; 23 Jan 2013 10:00:13 -0800
Received: from caret.perforce.com (caret.perforce.com [10.0.50.22])
	by imappy.perforce.com (8.14.3/8.14.3) with ESMTP id r0NI0C3Q020124
	for <git@vger.kernel.org>; Wed, 23 Jan 2013 10:00:13 -0800 (PST)
	(envelope-from dmarti@perforce.com)
In-Reply-To: <a3951c54-efb8-476f-952f-4893bcc5e4a9@caret.perforce.com>
X-Originating-IP: [10.0.102.208]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - FF3.0 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214339>

Just wanted to get this simple scheme out there in the hope of minimizing
patent troll risks for people working on replication.

You run an update hook that blocks pushes unless the branch reference in
the repository matches the corresponding reference stored in a synchronized
system, and flood the objects out using an inexpensive, simple system.

(Apologies if this is too obvious for the list; I didn't want to take
chances with the patent office definition of "obvious.")

 Replication Mechanism for a Distributed Version Control System 
 http://ip.com/IPCOM/000225058

 Disclosed is a mechanism for replication of content repositories of a
 distributed version control system (DVCS), which is unique in that objects
 and branch references are transferred between nodes by independent means,
 with only branch references subject to synchronization among nodes. The
 object of this disclosure is to simplify deployment of a DVCS in a
 replicated configuration. Replication can be performed efficiently by
 transferring objects using a key-value store, such as a distributed hash
 table (DHT), independently of a repository's branch references, which are
 transferred using a synchronized data store.

-- 
Don Marti           Perforce Software          +1-510-473-3142
http://www.perforce.com/git-fusion
