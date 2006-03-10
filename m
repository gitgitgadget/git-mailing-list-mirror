From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list feature request
Date: Thu, 9 Mar 2006 21:16:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603092114570.18022@g5.osdl.org>
References: <17424.53563.622642.738307@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0603091950360.18022@g5.osdl.org> <17425.1459.786864.172060@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0603092056300.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 06:17:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZzl-0006qU-L1
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 06:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWCJFQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 00:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWCJFQw
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 00:16:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751587AbWCJFQw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 00:16:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2A5GkDZ018161
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Mar 2006 21:16:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2A5GjMU001351;
	Thu, 9 Mar 2006 21:16:46 -0800
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0603092056300.18022@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17455>



On Thu, 9 Mar 2006, Linus Torvalds wrote:
> 
> Ahh, ok, you actually wanted something simpler than I thought you might.

Btw, what I _thought_ you migth want is to do the current "strong 
pruning", and then look up - from the stuff left behind - which ones reach 
to a ref or a tag. That's where the reverse refs would come in, and it 
requires some fundamental surgery (but it shouldn't be hard at all).

		Linus
