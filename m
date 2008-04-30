From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: rename "hooks.txt" to "githooks.txt" and make it a man page
Date: Wed, 30 Apr 2008 12:29:17 +0200
Organization: At home
Message-ID: <fv9hlt$nvv$1@ger.gmane.org>
References: <20080430080820.ef5a4c2a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 12:30:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr9a0-0000a1-8o
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 12:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbYD3K31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 06:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbYD3K31
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 06:29:27 -0400
Received: from main.gmane.org ([80.91.229.2]:51245 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350AbYD3K30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 06:29:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jr9Yy-0000f3-2R
	for git@vger.kernel.org; Wed, 30 Apr 2008 10:29:24 +0000
Received: from abvd205.neoplus.adsl.tpnet.pl ([83.8.201.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 10:29:24 +0000
Received: from jnareb by abvd205.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 10:29:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvd205.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80823>

[Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org]

Christian Couder wrote:

> Also now "gitcli(5)" becomes "gitcli(7)".

>  Documentation/githooks.txt |  301 ++++++++++++++++++++++++++++++++++++++++++++
>  Documentation/hooks.txt    |  285 -----------------------------------------
>  4 files changed, 304 insertions(+), 289 deletions(-)
>  create mode 100644 Documentation/githooks.txt
>  delete mode 100644 Documentation/hooks.txt

Please generate such rename patches with '-M' option, i.e. with rename
detection enabled.  This way patches are smaller, and it is easier to
see what has changed (beside renaming).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
