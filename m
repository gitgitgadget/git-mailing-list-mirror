From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 12:20:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101219280.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <200704101828.37453.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
 <200704102004.08329.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:26:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbLtU-0007vj-Ex
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 21:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbXDJTUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 15:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXDJTUk
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 15:20:40 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42237 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbXDJTUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 15:20:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AJKTVZ008330
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 12:20:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AJKOuj015335;
	Tue, 10 Apr 2007 12:20:27 -0700
In-Reply-To: <200704102004.08329.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44170>



On Tue, 10 Apr 2007, Andy Parkins wrote:
> 
> Would it be nicer if .gitmodules were line-based to aid in merging?

I seriously doubt you'll ever be merging or changing this a lot. So I 
don't think it's a huge concern.

		Linus
