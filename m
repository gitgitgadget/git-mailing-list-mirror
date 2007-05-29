From: Florian Weimer <fw@deneb.enyo.de>
Subject: git-svn dcommit failure
Date: Tue, 29 May 2007 11:16:03 +0200
Message-ID: <87veecat2k.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 11:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsxoN-0001Bp-2K
	for gcvg-git@gmane.org; Tue, 29 May 2007 11:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXE2JQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 05:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbXE2JQH
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 05:16:07 -0400
Received: from mail.enyo.de ([212.9.189.167]:1900 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbXE2JQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 05:16:06 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HsxoC-0003jD-Ua
	for git@vger.kernel.org; Tue, 29 May 2007 11:16:05 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HsxoB-0002Hq-Ul
	for git@vger.kernel.org; Tue, 29 May 2007 11:16:03 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48674>

I suddenly can't run dcommit on some of my working copies.  The change
I'm trying to push is pretty innocuous: just a single-line change (no
new file or directory).  dcommit fails with: "Network connection
closed unexpectedly: Connection closed unexpectedly at
/usr/bin/git-svn line 405".  I've looked at the data that is received
over SSH, and it looks pretty regular to me (that is, no interspersed
error message or something like that).

Is there any option to generate more debug output?

This with git-svn 1.5.1.4-2 on something that is quite close to Debian
etch.
