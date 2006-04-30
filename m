From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information in the config
Date: Sun, 30 Apr 2006 16:19:54 +0200
Organization: At home
Message-ID: <e32h0o$15n$1@sea.gmane.org>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Apr 30 16:21:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaCnH-0002US-Cq
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 16:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWD3OUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWD3OT4
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 10:19:56 -0400
Received: from main.gmane.org ([80.91.229.2]:12479 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751140AbWD3OTa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 10:19:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaCla-0002GU-Kl
	for git@vger.kernel.org; Sun, 30 Apr 2006 16:19:18 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 16:19:18 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 16:19:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19339>

There was thread about storing somewhere default branch we merge to during
pull, instead of using always surrent one. Different schemes were proposed,
most of them depending on the remotes configuration being available [also]
in config file.

Perhaps it would be easiest to extend existing notation in the following
way: 
  <from>:<to>[:<merge>]

By the way: it would be nice to have command/script to trasform freely
between 'remotes/' and config file.


P.S. I wonder if it would be difficult to implement 'include <file>' for
config file...

-- 
Jakub Narebski
Warsaw, Poland
