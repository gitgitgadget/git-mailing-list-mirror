From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: git fetch over ssh trouble
Date: Fri, 26 Jan 2007 00:08:42 -0500
Message-ID: <20070126050842.GA18058@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 06:08:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAJKR-0002dK-03
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 06:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030745AbXAZFIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 00:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030747AbXAZFIo
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 00:08:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:47334 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030745AbXAZFIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 00:08:43 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HAJKM-0000pp-Ir
	for git@vger.kernel.org; Fri, 26 Jan 2007 00:08:42 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37798>

Any idea why this is happening?:

bfields@pickle:git$ git fetch linux-nfs
Password:
/usr/local/bin/git-parse-remote: line 145: test: !=: unary operator
expected
Password:
error: no such remote ref CVSROOT=bfields@cvs.citi.umich.edu
error: no such remote ref DBUS_SESSION_BUS_ADDRESS=unix
error: no such remote ref DISPLAY=
error: no such remote ref GTK_RC_FILES=/etc/gtk/gtkrc
error: no such remote ref LONG_USAGE='Usage
error: no such remote ref MATHPATH=
error: no such remote ref PATH=/usr/local/bin
error: no such remote ref SESSION_MANAGER=local/pickle
error: no such remote ref SHELLOPTS=braceexpand
error: no such remote ref XPSERVERLIST='
Fetch failure: ssh://linux-nfs.org/~bfields/exports/git.git
bfields@pickle:git$

--b.
