From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: RFD Use git for off-site backups
Date: Sun, 13 May 2007 11:34:17 +0200
Message-ID: <20070513093417.GA18546@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 13 11:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnATB-0006tP-6w
	for gcvg-git@gmane.org; Sun, 13 May 2007 11:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbXEMJeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756924AbXEMJeT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 05:34:19 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:51730 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756864AbXEMJeS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 05:34:18 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 79BBF3F376; Sun, 13 May 2007 11:34:17 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47132>

Hello,
I am thinking about using git for doing differential backups of a whole
machines. And I would like to know what is necessary to obtain that. In
such a scenario the machine to be backed up should have a local index
file but sends its objects directly to the remote machine via git-via-ssh
or git protocol. Is it possible to store extra information like extended
attributes / acls in git? I don't care about named pipes, sockets and
device files for the moment.

        Thomas
