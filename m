From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] refs.c: add a function to sort a ref list, rather then
 sorting on add
Date: Tue, 17 Apr 2007 09:03:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 17 18:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdqAB-0001DG-QE
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 18:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031101AbXDQQDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 12:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031107AbXDQQDv
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 12:03:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52852 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031101AbXDQQDu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 12:03:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HG3jTW007351
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 09:03:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HG3iIl000932;
	Tue, 17 Apr 2007 09:03:45 -0700
In-Reply-To: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
X-Spam-Status: No, hits=-2.464 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44789>



On Tue, 17 Apr 2007, Julian Phillips wrote:
>
> Rather than sorting the refs list while building it, sort in one go
> after it is built using a merge sort.  This has a large performance
> boost with large numbers of refs.
> 
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

Looks fine. I think that even your new times are a bit high (over two 
seconds?) but things are clearly better. Have you looked at what takes so 
long now? 

		Linus
