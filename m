From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb using "--cc"?
Date: Thu, 9 Feb 2006 12:37:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org> <43EAA560.8030504@didntduck.org>
 <Pine.LNX.4.64.0602081817040.2458@g5.osdl.org> <7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602090822100.2458@g5.osdl.org> <Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
 <7v3bisb9qn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 21:38:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7IXg-0007Ew-JT
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 21:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWBIUhT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 15:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWBIUhT
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 15:37:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750771AbWBIUhR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 15:37:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19KbDDZ019184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Feb 2006 12:37:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k19Kb9Lq011374;
	Thu, 9 Feb 2006 12:37:11 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15824>



On Thu, 9 Feb 2006, Linus Torvalds wrote:
> 
> Here's a test-case, in case you care. Do "git-diff-tree --cc HEAD" in the 
> merge-test directory.

Btw, that test-case is also designed to show the different M/A/D cases for 
the merge result. The merge diff obviously doesn't do rename/copy 
detection (I don't think it's necessarily even a well-defined op, or if 
it is, it's damn complicated).

		Linus
