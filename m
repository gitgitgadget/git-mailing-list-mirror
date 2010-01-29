From: Ron1 <ron1@flownet.com>
Subject: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 12:20:46 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-2E17EF.12204629012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 21:25:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaxP8-0005Op-Dl
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab0A2UZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 15:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298Ab0A2UZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:25:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:39877 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab0A2UZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:25:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NaxOq-0005BT-Ro
	for git@vger.kernel.org; Fri, 29 Jan 2010 21:25:04 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 21:25:04 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 21:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138346>

[ron@mickey]$ git checkout master
Already on 'master'
[ron@mickey]$ git checkout master^
Note: moving to 'master^' which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 7be05e0... test
[ron@mickey]$ git branch
* (no branch)
  master
[ron@mickey]$

Huh?!?

This is a test repository which has never been pulled from nor pushed to 
anywhere.  So how is it possible that I have a non-local branch?

Thanks,
rg
