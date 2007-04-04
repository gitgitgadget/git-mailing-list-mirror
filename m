From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 4 Apr 2007 10:12:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704041011170.6730@woody.linux-foundation.org>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net>
 <200704041540.59977.andyparkins@gmail.com> <4613C97C.9050600@dawes.za.net>
 <Pine.LNX.4.63.0704041819340.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0704040935350.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0704041856210.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:12:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ92P-0003BY-Mt
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 19:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbXDDRMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 13:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbXDDRMp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 13:12:45 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48299 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbXDDRMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 13:12:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l34HCdPD023776
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 Apr 2007 10:12:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l34HCcis025737;
	Wed, 4 Apr 2007 10:12:38 -0700
In-Reply-To: <Pine.LNX.4.63.0704041856210.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.454 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43759>



On Wed, 4 Apr 2007, Johannes Schindelin wrote:
> 
> ... and by this (size of binary patch) you mean the deltified object?

yes. Just the size of the delta. Although I guess you're right - we 
may not have generated that.

		Linus
