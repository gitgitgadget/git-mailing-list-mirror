From: Russell King <rmk@arm.linux.org.uk>
Subject: cogito-0.10 broken for cg-commit < logmessagefile
Date: Wed, 8 Jun 2005 14:46:32 +0100
Message-ID: <20050608144632.A28042@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 08 15:49:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg0qK-0002P0-Dj
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 15:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFHNqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 09:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFHNqy
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 09:46:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30216 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261232AbVFHNqi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 09:46:38 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Dg0t7-00027Y-QJ
	for git@vger.kernel.org; Wed, 08 Jun 2005 14:46:34 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1Dg0t6-0007pU-IO
	for git@vger.kernel.org; Wed, 08 Jun 2005 14:46:32 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The command in the subject prepends the log message with a blank line.
This ain't good because it messes up commit messages as per Linus'
requirements (the first line must be a summary.)

Is this known about / has this been fixed in 0.11 ?

(It's presently a blocking bug...)

-- 
Russell King

