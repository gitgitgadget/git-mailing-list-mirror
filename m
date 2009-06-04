From: Nikos Chantziaras <realnc@arcor.de>
Subject: Using different protocols for "pull" and "push".
Date: Fri, 05 Jun 2009 02:16:44 +0300
Organization: Lucas Barks
Message-ID: <h09kk8$rb4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 01:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCMBZ-0002kQ-AG
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 01:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbZFDXQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 19:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbZFDXQk
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 19:16:40 -0400
Received: from main.gmane.org ([80.91.229.2]:44304 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbZFDXQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 19:16:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MCMAo-0008PV-MP
	for git@vger.kernel.org; Thu, 04 Jun 2009 23:16:38 +0000
Received: from athedsl-375207.home.otenet.gr ([79.131.17.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 23:16:38 +0000
Received: from realnc by athedsl-375207.home.otenet.gr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 23:16:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: athedsl-375207.home.otenet.gr
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120726>

Hi.

I wonder if it's possible to setup Git (probably in .git/config) to use 
SSH only for "git push" and use the git protocol for "git pull".  My 
current configuration is:

[remote "origin"]
         url = ssh://user@project.someserver.net/gitroot/project
         fetch = +refs/heads/*:refs/remotes/origin/*

Issuing a "git pull" command results in pulling using SSH (along with 
asking for a password).  Is there a way to alter the configuration so 
that a "pull" will use git:// instead of ssh:// ?
