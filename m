From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: bad object
Date: Wed, 22 Apr 2009 14:48:42 -0400
Message-ID: <20090422184842.GC9541@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 20:50:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwhWU-0000a9-54
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 20:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbZDVSsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZDVSsn
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 14:48:43 -0400
Received: from mail.fieldses.org ([141.211.133.115]:35032 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbZDVSsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 14:48:43 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LwhUw-0002xg-Rw
	for git@vger.kernel.org; Wed, 22 Apr 2009 14:48:42 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117226>

Just today operations started warning:

	error: Could not read 4e69489a0ac11a9b62a25923975bfc370a30eae5

This is Documentation/networking/baycom.txt from
518e6540831c69422faecceee8f964bd439ac9d0 (pre-2.6.13), which is easy
enough to find from another repository and fix the problem.

But I'm curious--how do I find out what pack file that object should be
in, and what the corruption looks like?

This is the third time I've found corruption in a repository on this
laptop, so I'm a little suspicious of the hardware.  (The second time I
reported here: http://marc.info/?l=git&m=121968278319668&w=2.)

--b.
