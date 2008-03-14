From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 01:17:10 +0100
Organization: At home
Message-ID: <frcg66$2nb$1@ger.gmane.org>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site> <20080313224741.GA5000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 01:18:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxci-0006DS-OM
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 01:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758488AbYCNAR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 20:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758480AbYCNAR0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 20:17:26 -0400
Received: from main.gmane.org ([80.91.229.2]:43095 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbYCNARZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 20:17:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZxbq-0006us-4G
	for git@vger.kernel.org; Fri, 14 Mar 2008 00:17:18 +0000
Received: from abwi55.neoplus.adsl.tpnet.pl ([83.8.232.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 00:17:18 +0000
Received: from jnareb by abwi55.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 00:17:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwi55.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77155>

Clemens Buchacher wrote:

> Handle file mode changes similarly to changes of content. If the file mode
> changed in only one branch, keep the changed version. If the file mode
> changed in both branches, prompt the user to choose one by reporting a
> conflict.

Shouldn't it print "CONFLICT(mode/mode)" then?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
