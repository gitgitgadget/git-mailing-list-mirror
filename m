From: Ishaaq Chandy <ishaaq@gmail.com>
Subject: disable branch modification
Date: Sat, 18 Jul 2009 11:16:13 -0700 (PDT)
Message-ID: <24550469.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 20:16:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSESM-0007nq-P8
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 20:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbZGRSQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 14:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbZGRSQN
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 14:16:13 -0400
Received: from kuber.nabble.com ([216.139.236.158]:50013 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbZGRSQN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 14:16:13 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MSESD-0004rq-2R
	for git@vger.kernel.org; Sat, 18 Jul 2009 11:16:13 -0700
X-Nabble-From: ishaaq@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123530>


Hi all,
I've got a remote git repository that I want multiple users to be able to
push to. This is all set up fine and working beautifully. The only thing is,
I want to be able to lock down the branches on this remote repo, once set up
users should not be able to:

1. Create new branches on it
2. Delete existing branches from it
3. push non-fast-forward commits to it.

I think I'll need to write a pre-receive hook for this, but before I embark
on this, any helpful pointers would be appreciated.

Thanks,
Ishaaq
-- 
View this message in context: http://www.nabble.com/disable-branch-modification-tp24550469p24550469.html
Sent from the git mailing list archive at Nabble.com.
