From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information in the config
Date: Sun, 30 Apr 2006 18:07:01 +0200
Organization: At home
Message-ID: <e32n9j$ibl$1@sea.gmane.org>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de> <e32h0o$15n$1@sea.gmane.org> <Pine.LNX.4.63.0604301749130.3641@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Apr 30 18:06:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaERe-0000hk-1a
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 18:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWD3QGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 12:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWD3QGk
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 12:06:40 -0400
Received: from main.gmane.org ([80.91.229.2]:59352 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751158AbWD3QGj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 12:06:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaERF-0000eJ-T6
	for git@vger.kernel.org; Sun, 30 Apr 2006 18:06:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 18:06:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 18:06:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19344>

Johannes Schindelin wrote:

> On Sun, 30 Apr 2006, Jakub Narebski wrote:
> 
>> P.S. I wonder if it would be difficult to implement 'include <file>' for
>> config file...
> 
> You really need that?

Need? Not exactly. I don't think git ever reach complexity of Apache or
Samba configuration files, and _need_ for includes. Still dividing separate
areas of configuration (core, user, default commands options, remotes) has
it's merits.

-- 
Jakub Narebski
Warsaw, Poland
