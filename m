From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some index-base bug in "next" branch ("git-applymbox"-related?)..
Date: Thu, 12 Apr 2007 21:16:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704122115240.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
 <7vbqhti0nr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704121812440.4061@woody.linux-foundation.org>
 <7vlkgxgc9d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 06:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcDDJ-0001Sw-1X
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 06:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbXDMEQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 00:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbXDMEQb
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 00:16:31 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46386 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbXDMEQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 00:16:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3D4GPIs003521
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 21:16:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3D4GPo9024353;
	Thu, 12 Apr 2007 21:16:25 -0700
In-Reply-To: <7vlkgxgc9d.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44383>



On Thu, 12 Apr 2007, Junio C Hamano wrote:
> 
> The whole reason I did not _enhance_ git-applymbox but wrote a
> separate git-am was because I found git-applymbox's command line
> parameter quite insane and felt that supporting it at the same
> time doing a saner command line parameter was too much kludge.

Heh. I'll try to make my alias be

	alias dotest='git-am --utf8'

and see what happens ;)

		Linus
