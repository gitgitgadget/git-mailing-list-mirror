From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 11:23:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
 <46250175.4020300@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:23:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdsKf-0005NO-Df
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 20:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbXDQSXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 14:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161360AbXDQSXJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 14:23:09 -0400
Received: from smtp.osdl.org ([65.172.181.24]:56754 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161359AbXDQSXI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 14:23:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HIN46q012172
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 11:23:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HIN3nG004096;
	Tue, 17 Apr 2007 11:23:03 -0700
In-Reply-To: <46250175.4020300@dawes.za.net>
X-Spam-Status: No, hits=-0.963 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44809>



On Tue, 17 Apr 2007, Rogan Dawes wrote:
> 
> Well, if the only keyword we support is $BlobId:$, then if the tree/object
> hasn't changed, then we still don't need to touch the object.
> 
> Not so?

Correct. However, is that actually a useful expansion?

Most of the time, I'd expect people to want things like "last committer, 
time, story of their life" etc.. I don't think the SHA1 ID's are pretty 
enough that anybody would ever want to see them. But yes, they are 
certainly stable.

			Linus
