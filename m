From: pasky@suse.cz
Subject: [PATCH 0/5] git-gui: Support for "Locators" - address templates
Date: Thu, 25 Sep 2008 00:12:49 +0200
Message-ID: <20080924221249.037449176@suse.cz>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 00:19:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KichR-0008KG-4q
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbYIXWRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 18:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbYIXWRo
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:17:44 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:49856 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752347AbYIXWRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:17:43 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 33A772AC8FA; Thu, 25 Sep 2008 00:17:30 +0200 (CEST)
User-Agent: quilt/0.46_cvs20080326-19.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96699>

This patch allows "locators" to be configured and used in the GUI,
basically as URL templates the input string is subsituted into.
The default operation of git-gui is not much affected (only some
labels change to be less confusing).

This is aimed mainly at corporate Git deployments - the integrator
might want to configure the central corporate repository store as
the default locator so that people do not need to type the same
URL over and over but can instead just type the repository name
on the server. Or avid repo.or.cz users might set up a 'repo'
locator pointing at 'git://repo.or.cz/%s'.

In practice, this seems to be a more significant usability improvement
than it might seem. Less technical users appear to be less daunted
to type in just the project name instead of dealing with long URLs.
