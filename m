From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1.3.2 git-clone segfaults
Date: Wed, 17 May 2006 17:54:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171752190.10823@g5.osdl.org>
References: <879BAFDD-87DB-4041-8753-5D63630076B5@cs.utexas.edu> 
 <1147894165.16654.10.camel@dv> <1147909920.32050.29.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Yoder <byoder@cs.utexas.edu>, git@vger.kernel.org,
	Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Thu May 18 02:55:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgWnJ-0000Mg-W7
	for gcvg-git@gmane.org; Thu, 18 May 2006 02:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWERAzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 20:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWERAzE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 20:55:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35206 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbWERAzD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 20:55:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4I0sWtH019382
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 17:54:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4I0sUAT002644;
	Wed, 17 May 2006 17:54:31 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1147909920.32050.29.camel@dv>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20254>



On Wed, 17 May 2006, Pavel Roskin wrote:
> 
> Looks like a curl bug to me.  curl 7.15.1, glibc 2.4, git master branch.

If the thing is fixed by turning off DAV support (and I thought somebody 
reported it was), maybe we should turn that off by default? Ie, make 
NO_EXPAT be the default, and you have to explicitly turn it off.

		Linus
