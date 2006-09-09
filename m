From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support perl 5.6
Date: Sat, 09 Sep 2006 14:19:46 +0200
Organization: At home
Message-ID: <edubfu$rjm$1@sea.gmane.org>
References: <20060909104605.GA22331@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 09 14:19:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM1o5-0002mx-2Y
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 14:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWIIMTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 08:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWIIMT3
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 08:19:29 -0400
Received: from main.gmane.org ([80.91.229.2]:42114 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932112AbWIIMT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 08:19:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GM1nu-0002k2-1U
	for git@vger.kernel.org; Sat, 09 Sep 2006 14:19:22 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 14:19:22 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 14:19:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26745>

Sven Verdoolaege wrote:

> Specifically, perl 5.6 doesn't have the Encode module and
> doesn't support the open "-|" list form.

The way to remove requirement of Encode module is done nice.

Changing open "-|" list form back to the 3-arg form -- it would
be better IMVHO to refactor this into git_pipe or similar function.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
