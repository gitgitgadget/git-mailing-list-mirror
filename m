From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Preserve cwd in setup_git_directory()
Date: Fri, 25 Jul 2008 12:04:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807251203001.11976@eeepc-johanness>
References: <20080724031441.GA26072@laptop>  <alpine.DEB.1.00.0807241324040.8986@racer>  <fcaeb9bf0807240540i400fe0d1s7ea8efe72203471d@mail.gmail.com>  <alpine.DEB.1.00.0807241506340.8986@racer>  <fcaeb9bf0807241137h65292d7egad8cc5f797114607@mail.gmail.com>
 <93c3eada0807250248l60c81090sd1953df24cca1421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 12:04:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKAQ-0001AO-4W
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbYGYKDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbYGYKDx
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:03:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:51638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753310AbYGYKDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:03:53 -0400
Received: (qmail invoked by alias); 25 Jul 2008 10:03:51 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp021) with SMTP; 25 Jul 2008 12:03:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xEdhU0vnxGWS+0WM767SS08erHWwWdD9DS2oITk
	koRpO6sOXkzB+N
X-X-Sender: user@eeepc-johanness
In-Reply-To: <93c3eada0807250248l60c81090sd1953df24cca1421@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 25 Jul 2008, Geoff Russell wrote:

> I was pretty surprised to find that my command line switch (--work-tree) 
> was being stored in the config file, which ended up causing the problem.  
> Duy thinks he can fix this, which is fine, but as a matter of principle, 
> I'm not keen on command line switches being magically saved for me when 
> I didn't ask for this to happen.

You were initializing a repository.  How on earth could you be surprised 
when _important_ things like work-tree git-dir or if it is bare are stored 
inside the freshly initialized repository?

> The reason for using a command line switch is because I want to override 
> default behaviour on this execution, if I wanted to change the default 
> behaviour, then I'd set values in the config file.

No, you would not.  Because there is no config file yet.

Htrh,
Dscho
