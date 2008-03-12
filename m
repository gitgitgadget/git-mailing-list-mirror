From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: CVS to git: parsing ChangeLog entries?
Date: Wed, 12 Mar 2008 20:08:27 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080312190827.GE3198@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 20:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZWK7-0004JF-Ft
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYCLTId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYCLTId
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:08:33 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43310 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbYCLTIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:08:32 -0400
Received: from localhost.localdomain (xdsl-87-78-70-167.netcologne.de [87.78.70.167])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 0981F400026B8
	for <git@vger.kernel.org>; Wed, 12 Mar 2008 20:08:31 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JZWJP-0001AN-F9
	for git@vger.kernel.org; Wed, 12 Mar 2008 20:08:27 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76973>

Hello,

when migrating a project that uses GNU-style ChangeLogs from CVS
to git, is it possible to extract patch author information from
the ChangeLog entries rather than from the CVS commit logs?
For simplicity let's first assume the project used only one
ChangeLog file.

Asking because it is not uncommon that patches are committed on
behalf of other people, and it would be nice to credit them.

Related question: when CVS commit logs have varying encoding,
say, some latin1 and some UTF-8, is it possible to have uniformly
encoded git log entries?

Thank you, and please Cc: me on replies,
Ralf
