From: Sven Ekman <svekman@yahoo.se>
Subject: SV: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 14:02:16 +0200 (CEST)
Message-ID: <20060608120216.46722.qmail@web25908.mail.ukl.yahoo.com>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jun 08 14:02:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoJDZ-0005XJ-V9
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 14:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWFHMCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 08:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWFHMCS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 08:02:18 -0400
Received: from web25908.mail.ukl.yahoo.com ([217.12.10.206]:44183 "HELO
	web25908.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964804AbWFHMCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 08:02:18 -0400
Received: (qmail 46724 invoked by uid 60001); 8 Jun 2006 12:02:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.se;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MjaDtINTLSAhoCO3MionmMGzfhaPhA92JEM9o9wCticswiaDIfbrk8ZQrs7P1jP/MJw9ONkm3cId6xHlg3S0P25AXLne6KfeKEg7ZYn+Ol3tw0YGL7p4KK56dQUKplJKnF+s5F/3crqAhmF9ZQEKadL7hhRV5s9bKOhPjxhXLP0=  ;
Received: from [213.113.27.79] by web25908.mail.ukl.yahoo.com via HTTP; Thu, 08 Jun 2006 14:02:16 CEST
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21482>

<Johannes.Schindelin@gmx.de> skrev:
 
> There are three subjects for discussion:

Have you considered making ~/.gitconfig a directory?
Maybe Git wants to store more data later.

Maybe, porcelains would want to use this directory,
too.  Gitk, tig, maybe Cogito at some time.  One could
have the configuration of all these git-related tools
in a common namespace.

People like me, who work on a lot of different
machines, could simply sync this directory across
accounts and always work in their environment.

Sven
