From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Increase some limits in git-mailinfo
Date: Mon, 26 Feb 2007 13:21:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702261320350.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0702261036550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702261107060.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702262020590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702261207520.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702262117160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702261221530.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702262135140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 22:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLnHk-0005va-Or
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 22:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbXBZVVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 16:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbXBZVVL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 16:21:11 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34602 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030512AbXBZVVK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 16:21:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1QLL3hB007048
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 13:21:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1QLL2fK031420;
	Mon, 26 Feb 2007 13:21:02 -0800
In-Reply-To: <Pine.LNX.4.63.0702262135140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.442 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40666>



On Mon, 26 Feb 2007, Johannes Schindelin wrote:
> 
> Just my 2 cents: I can live with prefixcmp(). And since I use strcmp() to 
> compare strings, not strings_eq() or similar, I am quite happy with 
> prefixcmp(), too.

Oh, I can live with it too. This is not a big issue for me. I just 
explained why I didn't use it, and why I would probably have done it 
differently had I done the prefixcmp() thing.

		Linus
