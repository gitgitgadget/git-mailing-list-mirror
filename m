From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Allow fetch-pack to decide keeping the fetched pack without exploding
Date: Tue, 23 Jan 2007 18:22:43 +0100
Organization: At home
Message-ID: <ep5g7f$bok$1@sea.gmane.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0701230809440.32200@woody.linux-foundation.org> <87sle17lnm.fsf@morpheus.local> <Pine.LNX.4.63.0701231738460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 23 18:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9PLl-0000eK-8V
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 18:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbXAWRWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 12:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbXAWRWN
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 12:22:13 -0500
Received: from main.gmane.org ([80.91.229.2]:42056 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965038AbXAWRWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 12:22:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9PLM-0004Sk-1h
	for git@vger.kernel.org; Tue, 23 Jan 2007 18:22:00 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 18:22:00 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 18:22:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37553>

Johannes Schindelin wrote:

> Seriously again, your comment got me thinking: it could actually make 
> sense to include the information of code moves and code copies (for easier 
> review) in the "@@ .. @@" lines (or before them, if git apply does not 
> choke on inserting garbage lines before them).
> 
> But maybe it is not that good after all: if you review code, you should 
> inspect it (even if it was only moved), since it might have all kinds of 
> side effects, or you might have missed some other aspect before.

It would be nice to have extended git header dealing with code copies
(or stuff it in chunk header or above), because sometimes both sides
of code movement (removal from one file, adding in next file) can be
separated by a few pagefulls of chunks.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
