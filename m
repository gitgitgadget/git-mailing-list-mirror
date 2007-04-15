From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Define a few built-in attribute rules.
Date: Sat, 14 Apr 2007 18:41:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net> <200704131033.15751.andyparkins@gmail.com>
 <7vejmm78qp.fsf@assigned-by-dhcp.cox.net> <7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 03:42:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hctkn-0008Fa-Ju
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 03:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbXDOBmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 21:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbXDOBmF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 21:42:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42882 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250AbXDOBmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 21:42:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3F1g0Is014833
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Apr 2007 18:42:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3F1fxd3004146;
	Sat, 14 Apr 2007 18:41:59 -0700
In-Reply-To: <7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.955 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44480>



On Sat, 14 Apr 2007, Junio C Hamano wrote:
>
> This adds an obviously sane pair of default attribute rules as built-ins.

I'm not sure.

> +	"[attr]binary !diff !crlf",
> +	"* diff crlf",

Why would 

	* diff crlf

be "obviously sane"?

In fact, I'd call it obviously insane.

We do *not* want to default crlf to all files. We want the default to be 
"automatic crlf depending on content". 

Then, on top of that, you can *explicitly* specify crlf or !crlf on some 
particular filename pattern bases.

(Side thought - I have to concur with whoever suggested "-" instead of 
"!". It just reads better, I think)

		Linus
