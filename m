From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add history and blame to git_difftree_body()
Date: Sun, 01 Oct 2006 18:41:05 +0200
Organization: At home
Message-ID: <efor2e$d0i$1@sea.gmane.org>
References: <20060928002449.64051.qmail@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 01 18:41:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU4NO-00015N-Dd
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 18:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWJAQlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 12:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWJAQlK
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 12:41:10 -0400
Received: from main.gmane.org ([80.91.229.2]:39814 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751267AbWJAQlJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 12:41:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GU4NG-00014L-TW
	for git@vger.kernel.org; Sun, 01 Oct 2006 18:41:06 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 18:41:06 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 18:41:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28181>

Luben Tuikov wrote:

> Add blame and history to Deleted files.
> Add blame and history to Modified or Type changed files.
> Add blame and history to Renamed or Copied files.

Blame has to be added conditionally (gitweb_have_blame).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
