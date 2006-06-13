From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Collecting cvsps patches
Date: Tue, 13 Jun 2006 08:47:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606130841200.5498@g5.osdl.org>
References: <20060611122746.GB7766@nowhere.earth> <1150173310.15831.6.camel@dv>
 <20060613095445.GM1297@nowhere.earth> <448EC1C6.5060902@dm.cobite.com>
 <20060613151504.GN1297@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <centos@dm.cobite.com>,
	Pavel Roskin <proski@gnu.org>, GIT list <git@vger.kernel.org>,
	cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Tue Jun 13 17:47:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqB70-0001er-O7
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 17:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWFMPrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 11:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWFMPrY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 11:47:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932150AbWFMPrX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 11:47:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5DFlGgt021525
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Jun 2006 08:47:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5DFlFDc031392;
	Tue, 13 Jun 2006 08:47:15 -0700
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060613151504.GN1297@nowhere.earth>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21782>



On Tue, 13 Jun 2006, Yann Dirson wrote:
> 
> I have setup a Q&D page at
> http://ydirson.free.fr/en/software/scm/cvsps.html to link to.
> 
> I'll expand it later with more information.

Will you be able to set up gitweb on that site, perhaps? 

Also, I guess that patch I posted in the "cvsps wierdness" thread (yeah, 
yeah, bad spelling, but it wasn't me who started the thread) should 
probably be added, since it fixed at least one test-case.

Although it should probably get more testing with a bigger and more 
real-life repository..

(David: in case you didn't follow the git list, it makes 
"compare_patch_sets_by_time()" compare by members _first_, and by time 
_second_, so that if a file revision shows that a patchset was before 
another one, it will use that as the primary sort order).

			Linus
