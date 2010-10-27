From: longphant <longphant@yahoo.com>
Subject: How git detects changes during commit?
Date: Wed, 27 Oct 2010 13:36:51 -0700 (PDT)
Message-ID: <1288211811436-5680208.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 22:36:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBCjx-0003LI-9G
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 22:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab0J0Ugw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 16:36:52 -0400
Received: from kuber.nabble.com ([216.139.236.158]:51964 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0J0Ugv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 16:36:51 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <longphant@yahoo.com>)
	id 1PBCjr-0000s0-Ef
	for git@vger.kernel.org; Wed, 27 Oct 2010 13:36:51 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160122>


Say you check out a directory of 100 files. You edit 5 of the files, and you
go to commit the directory back. How does git know which of the 100 files
were modified (not all of them were)?
-- 
View this message in context: http://git.661346.n2.nabble.com/How-git-detects-changes-during-commit-tp5680208p5680208.html
Sent from the git mailing list archive at Nabble.com.
