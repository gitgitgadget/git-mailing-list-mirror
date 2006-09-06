From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Wed, 06 Sep 2006 20:48:18 +0200
Organization: At home
Message-ID: <edn54s$c4s$1@sea.gmane.org>
References: <200609061504.40725.jnareb@gmail.com> <Pine.LNX.4.64.0609060847521.27779@g5.osdl.org> <edmv57$lt7$1@sea.gmane.org> <Pine.LNX.4.64.0609061125000.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 06 20:48:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL2S3-0004pJ-D3
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 20:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWIFSsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWIFSsj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 14:48:39 -0400
Received: from main.gmane.org ([80.91.229.2]:24706 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751133AbWIFSsi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 14:48:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GL2RX-0004iA-M7
	for git@vger.kernel.org; Wed, 06 Sep 2006 20:48:12 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 20:48:11 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 20:48:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26549>

Linus Torvalds wrote:

>> Every single merge is for parents to be connected, or what?
> 
> Well, "--parents" on its own means that we want a connected graph. It's 
> just that if you don't ask for full history, then the connected graph 
> result is obviously much smaller.

Well, I just didn't realize that --parents gives parents in _simplified_
history, unless --full-history is used. Hence my confusion.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
