From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Tue, 13 Nov 2007 15:07:05 +0100
Organization: At home
Message-ID: <fhcb29$ef$2@ger.gmane.org>
References: <11949569992214-git-send-email-msmith@cbnco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 15:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrwWp-0002fw-4o
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 15:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbXKMONv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 09:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbXKMONv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 09:13:51 -0500
Received: from main.gmane.org ([80.91.229.2]:35120 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbXKMONu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 09:13:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrwTj-0005j6-Ir
	for git@vger.kernel.org; Tue, 13 Nov 2007 14:10:59 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 14:10:59 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 14:10:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64800>

Michael Smith wrote:

> +You can use the gitlink:git-cherry[1] command to display the commit
> +IDs that are only present on your local branch, or only on the remote
> +branch, respectively:

I think git-cherry is deprecated in favor of "git log --left-right" (with
appropriate format, for example '--abbrev-commit --pretty=oneline')

BTW. that means that git-cherry can be removed from git-help output,
I think.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
