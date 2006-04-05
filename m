From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 17:11:43 +0200
Organization: At home
Message-ID: <e10mn9$cjs$1@sea.gmane.org>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com> <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 05 17:12:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR9fx-0003Mo-Bl
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 17:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDEPMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 11:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDEPMB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 11:12:01 -0400
Received: from main.gmane.org ([80.91.229.2]:14535 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750765AbWDEPMA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 11:12:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FR9fl-0003Jl-Hd
	for git@vger.kernel.org; Wed, 05 Apr 2006 17:11:53 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 17:11:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 17:11:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18437>

Junio C Hamano wrote:

> It _might_ make sense to adopt a well-defined binary patch
> format (or if there is no prior art, introduce our own) and
> support that format with both git-diff-* brothers and git-apply,
> but that would be a bit longer term project.

bsdiff? http://www.daemonology.net/bsdiff/
EDelta? http://www.diku.dk/~jacobg/edelta/
Xdelta? http://xdelta.blogspot.com/

IIRC bsdiff is used by Firefox to distribute binary software updates.
Xdelta is generic (not optimized for binaries like bsdiff and edelta), but
supposedly offers worse compression (bigger diffs).

-- 
Jakub Narebski
Warsaw, Poland
