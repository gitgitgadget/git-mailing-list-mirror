From: Florian Weimer <fw@deneb.enyo.de>
Subject: git-svn: cloning from svn.apache.org
Date: Sun, 25 Jan 2009 11:49:01 +0100
Message-ID: <8763k364pu.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 11:51:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR2Zp-0007gJ-7g
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 11:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbZAYKtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 05:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZAYKtE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 05:49:04 -0500
Received: from mail.enyo.de ([212.9.189.167]:57812 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbZAYKtE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 05:49:04 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1LR2Y1-0003bH-Lu
	for git@vger.kernel.org; Sun, 25 Jan 2009 11:49:01 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1LR2Y1-0002H1-8z
	for git@vger.kernel.org; Sun, 25 Jan 2009 11:49:01 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107049>

What can be done to speed up cloning from svn.apache.org?  It's a
Subversion repository with over 700,000 revisions.  Many projects
stored there started their life in some of the later revisions, and
the forward-scanning part of git-svn takes ages.

I wonder if it were faster to search history backwards, starting with
the specified path, similar to what "svn log" does?
