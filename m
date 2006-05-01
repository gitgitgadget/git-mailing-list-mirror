From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Mon, 01 May 2006 06:44:06 +0200
Organization: At home
Message-ID: <e343l1$2pj$1@sea.gmane.org>
References: <20060429165151.2570.qmail@science.horizon.com>	<e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>	<e30k0n$ij5$1@sea.gmane.org> <e32kkf$amc$1@sea.gmane.org>	<7vfyjuwt0v.fsf@assigned-by-dhcp.cox.net> <7v8xpmva9x.fsf@assigned-by-dhcp.cox.net> <4455638A.3070802@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 01 06:43:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaQG6-00082i-EJ
	for gcvg-git@gmane.org; Mon, 01 May 2006 06:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWEAEnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 00:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWEAEnb
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 00:43:31 -0400
Received: from main.gmane.org ([80.91.229.2]:2798 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750746AbWEAEnb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 00:43:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FaQFn-00081F-Uh
	for git@vger.kernel.org; Mon, 01 May 2006 06:43:23 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 May 2006 06:43:23 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 May 2006 06:43:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19370>

Take a look at complexity of that explanation. And the need for additional
commit. That balanced against all the headaches of having connectivity
header other than "parent".

Perhaps it would be better (and easier) just to say

   note prior parent^1

or

   note prior <sha1>

repeating <sha1> found in parent.


Just a thought.

-- 
Jakub Narebski
Warsaw, Poland
