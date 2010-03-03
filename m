From: jateeq <jawad_atiq@hotmail.com>
Subject: Git diff does not detect newly added files to working tree
Date: Wed, 3 Mar 2010 12:03:48 -0800 (PST)
Message-ID: <27772711.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 21:04:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmunb-0007Yz-TT
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab0CCUDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:03:50 -0500
Received: from kuber.nabble.com ([216.139.236.158]:43835 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474Ab0CCUDt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:03:49 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NmunM-0002uW-Sb
	for git@vger.kernel.org; Wed, 03 Mar 2010 12:03:48 -0800
X-Nabble-From: jawad_atiq@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141467>



Hello,

If I add a new file to a working tree, and run the following command without
having staged or committed the file, according to the manual I should be
able to get the name of the file - but it just doesn't show up. Anyone knows
what I'm doing wrong? Note that the added file is not empty.

Command: git diff --name-only --diff-filter=[ACDM*] 
The manual is  http://www.kernel.org/pub/software/scm/git/docs/git-diff.html
here .

Fanks, 
Jawad
-- 
View this message in context: http://old.nabble.com/Git-diff-does-not-detect-newly-added-files-to-working-tree-tp27772711p27772711.html
Sent from the git mailing list archive at Nabble.com.
