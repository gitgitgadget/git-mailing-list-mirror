From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add ".git/config" file parser
Date: Mon, 10 Oct 2005 14:47:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510101446180.14597@g5.osdl.org>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
 <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org> <Pine.LNX.4.63.0510100220330.23242@iabervon.org>
 <7vu0fpbz43.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510101354520.23242@iabervon.org>
 <Pine.LNX.4.64.0510101120410.14597@g5.osdl.org> <Pine.LNX.4.64.0510101415080.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 23:47:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP5UQ-0005OV-CO
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVJJVrT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVJJVrT
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:47:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751275AbVJJVrS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 17:47:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9ALlD4s006997
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Oct 2005 14:47:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9ALlCmG007730;
	Mon, 10 Oct 2005 14:47:12 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0510101415080.14597@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9946>



On Mon, 10 Oct 2005, Linus Torvalds wrote:
> 
> 	; core variables
> 	[core]
> 		; Don't trust file modes
> 		filemode = false
> 
> 	; Our diff algorithm 
> 	[diff]
> 		external = "/usr/local/bin/gnu-diff -u"
> 		renames = true
> 
> which parses into two variables: "core.filemode" is associated with the 
> string "false", and "diff.external" gets the appropriate quoted value.

_Three_ variables. Duh. I added the "renames" thing later, as I was 
looking at what kinds of default flags the "git-diff-xyz" family might be 
interested in having.

		Linus
