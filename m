From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH/RFT] git-rm: update to saner semantics
Date: Thu, 21 Dec 2006 10:38:52 +0100
Organization: At home
Message-ID: <emdkib$fve$1@sea.gmane.org>
References: <7vwt4lboa2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Dec 21 10:40:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxKPU-0007fN-1C
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWLUJkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWLUJkM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:40:12 -0500
Received: from main.gmane.org ([80.91.229.2]:58930 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965177AbWLUJkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:40:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GxKPC-00029J-GG
	for git@vger.kernel.org; Thu, 21 Dec 2006 10:40:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 10:40:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 10:40:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35043>

Junio C Hamano wrote:

> -"git-rm [-n] [-v] [-f] <filepattern>...";
> +"git-rm [-n] [-f] [--cached] <filepattern>...";

Why do we lost -v (for verbose)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
