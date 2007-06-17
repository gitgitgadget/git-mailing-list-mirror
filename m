From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: merge into branch currently not active / checked out
Date: Sun, 17 Jun 2007 09:22:25 +0200
Message-ID: <20070617072225.GF23473@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 17 09:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzp5j-0001y4-SD
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 09:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbXFQHW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 03:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbXFQHW1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 03:22:27 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:37756 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750997AbXFQHW0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2007 03:22:26 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 57FEA3F43A; Sun, 17 Jun 2007 09:22:25 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50336>

Hello,
is it possible to merge into a branch currently not active/checked out?
I have the following scenario:

        - One branch per feature (cstatus, headers, mutt-collapse-flags, small-fixes)
        - One upstream branch (master)
        - One branch that has every feature branch (tg)

(faui00u) [~/work/mutt/mutt] git branch
  cstatus
  headers
  master
  mutt-collapse-flags
  small-fixes
* tg

I want to merge master in every of the feature branches. Is that possible or
just bullshit because I don't have a working tree to handle conflicts?

        Thomas
