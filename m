From: Derek Mahar <derek.mahar@gmail.com>
Subject: git-svn and incorrect working copy file timestamps?
Date: Thu, 19 Mar 2009 12:54:12 -0700 (PDT)
Message-ID: <1237492452300-2505059.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 20:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOLu-00060n-T6
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357AbZCSTyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 15:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755607AbZCSTyP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:54:15 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40743 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473AbZCSTyO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 15:54:14 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LkOJg-0004qQ-DE
	for git@vger.kernel.org; Thu, 19 Mar 2009 12:54:12 -0700
X-Nabble-From: derek.mahar@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113816>


Should "git svn" not preserve the file timestamps of the original commit tree
in the working copy?  Using Git 1.6.2.1, built from source, I find that "git
svn clone" sets the file timestamps in the working copy to the current date. 
I expected the timestamps to match those of the tree as it was originally
committed.  I get this result using both Cygwin and Crunchbang Linux 8.10.02
(an Ubuntu derivative).

Derek
-- 
View this message in context: http://n2.nabble.com/git-svn-and-incorrect-working-copy-file-timestamps--tp2505059p2505059.html
Sent from the git mailing list archive at Nabble.com.
