From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Alternate index output file
Date: Sun, 1 Apr 2007 09:08:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704010904430.6730@woody.linux-foundation.org>
References: <7vwt11itbz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0703280759230.6730@woody.linux-foundation.org>
 <7v4po04nit.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 18:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HY2bq-0008NC-MG
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 18:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933576AbXDAQIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 12:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933591AbXDAQIj
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 12:08:39 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44809 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933576AbXDAQIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 12:08:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l31G8Yod010170
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 Apr 2007 09:08:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l31G8X4g013745;
	Sun, 1 Apr 2007 09:08:33 -0700
In-Reply-To: <7v4po04nit.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.964 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43590>



On Sat, 31 Mar 2007, Junio C Hamano wrote:
>
> If a curious user has the environment variable set to something
> other than the file GIT_INDEX_FILE points at, almost everything
> will break.  This should instead be a command line parameter to
> tell these plumbing commands to write the result in the named
> file, to prevent stupid mistakes.

I agree, that sounds sane. In general, we should probably support 
command-line parameters for most of those things, rather than force the 
use of environment parameters (the way we already do with "--author", for 
example).

		Linus
