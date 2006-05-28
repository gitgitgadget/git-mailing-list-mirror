From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 00:00:32 +0200
Organization: At home
Message-ID: <e5d6i0$rnf$1@sea.gmane.org>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 29 00:01:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkTJo-0004DT-OJ
	for gcvg-git@gmane.org; Mon, 29 May 2006 00:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWE1WBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 18:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWE1WBB
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 18:01:01 -0400
Received: from main.gmane.org ([80.91.229.2]:56247 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750973AbWE1WBA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 18:01:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FkTJf-0004BU-FA
	for git@vger.kernel.org; Mon, 29 May 2006 00:00:55 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 00:00:55 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 00:00:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20899>

Michael Richardson wrote:

> This change adds $GIT_DIR/umask to contain a single line, an integer
> which will be fed to umask(). This should also work for the git daemon,
> which I personally do not use, so this may be inappropriate.

Shouldn't it be done rather via $GIT_DIR/config file, and 
git-repo-config? I.e. instead of adding new file to repository layout,
$GIT_DIR/umask, add core.umask to git configuration?

-- 
Jakub Narebski
Warsaw, Poland
