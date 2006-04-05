From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: n-heads and patch dependency chains
Date: Wed, 05 Apr 2006 09:11:52 +0200
Organization: At home
Message-ID: <e0vqjk$5dr$1@sea.gmane.org>
References: <4430D352.4010707@vilain.net>	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>	<4431B60E.3030008@vilain.net> <7vhd596ua0.fsf@assigned-by-dhcp.cox.net> <443364F5.2040504@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 05 09:12:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR2BY-0000Es-ET
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 09:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWDEHMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 03:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWDEHMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 03:12:09 -0400
Received: from main.gmane.org ([80.91.229.2]:63189 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751130AbWDEHMI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 03:12:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FR2BL-0000Dk-B3
	for git@vger.kernel.org; Wed, 05 Apr 2006 09:11:59 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 09:11:59 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 09:11:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18420>

First, hydras or n-head was invented to avoid capping and recapping, and
just advance it as a normal head (and to remember what are
subprojects/patch dependency chains/whatever to choose).

Second, we could generalize those extra commit references in commit
structure (be they "bind", "prior" or "previous", or "depends-on") and have
commit/merge pluggable helper manage them. And merge strategy may make use
of them.

Third, would using *directory* with for a N-HEAD (containing all the
subheads, subprojects, chains, branches, fibers, whatever) instead of an
ordinary file for HEAD be a good idea? For hydra if we want it to be easily
interweaved with ordinary commit I think we would also need the link for
bottom, hydra shoulder, hydra tail i.e. common commit being starting point
for all the chains, or subprojects (for subprojects it can be empty tree
commit).

-- 
Jakub Narebski
Warsaw, Poland
