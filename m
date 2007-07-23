From: Lars Noschinski <lars@public.noschinski.de>
Subject: git-gui ignores core.excludesFile
Date: Mon, 23 Jul 2007 17:07:00 +0200
Message-ID: <20070723150700.GA17167@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jul 23 17:14:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICzbo-0001Xe-La
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 17:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbXGWPNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 11:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbXGWPNr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 11:13:47 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:49863 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbXGWPNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 11:13:46 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2007 11:13:45 EDT
Received: (qmail 2646 invoked from network); 23 Jul 2007 15:07:03 -0000
Received: from unknown (HELO vertikal.home.noschinski.de) (336680@[137.226.12.97])
          (envelope-sender <lars@public.noschinski.de>)
          by smtprelay05.ispgateway.de (qmail-ldap-1.03) with AES256-SHA encrypted SMTP; 23 Jul 2007 15:07:03 -0000
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.67)
	(envelope-from <lars@public.noschinski.de>)
	id 1ICzUy-0004UF-UI; Mon, 23 Jul 2007 17:07:00 +0200
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53441>

Hello!

It seems git-gui (0.7.5 from git 1.5.2.4 tarball) ignores the global
ignore file configured with the core.excludesfile option. My
~/.gitconfig contains

[core]
excludesFile = /home/noschinski/.gitignore

which is honoured by git-status but not by git-gui.


Greetings,
    Lars.
