From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Tue, 27 Nov 2007 22:21:20 +0100
Organization: At home
Message-ID: <fii1od$d38$1@ger.gmane.org>
References: <20071127211730.GA11861@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 22:22:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix7sP-0005YQ-Vt
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 22:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757573AbXK0VVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 16:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757012AbXK0VVf
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 16:21:35 -0500
Received: from main.gmane.org ([80.91.229.2]:49558 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827AbXK0VVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 16:21:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ix7ry-0008Dh-S1
	for git@vger.kernel.org; Tue, 27 Nov 2007 21:21:26 +0000
Received: from abvx114.neoplus.adsl.tpnet.pl ([83.8.221.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 21:21:26 +0000
Received: from jnareb by abvx114.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 21:21:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx114.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66262>

Steven Grimm wrote:

> +The hook may optionally choose to update the ref on its own, e.g.,
> +if it needs to modify incoming revisions in some way. If it updates
> +the ref, it should exit with a status of 100.

Why 100, and not for example 127, 128 or -1?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
