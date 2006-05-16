From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn vs. $Id$
Date: Tue, 16 May 2006 10:48:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605161037220.3866@g5.osdl.org>
References: <446A0CCF.2060903@inoi.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 19:51:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg3gf-0003re-OV
	for gcvg-git@gmane.org; Tue, 16 May 2006 19:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWEPRsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWEPRsM
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 13:48:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932418AbWEPRsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 13:48:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4GHm4tH008895
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 10:48:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4GHm3BK015455;
	Tue, 16 May 2006 10:48:03 -0700
To: Tommi Virtanen <tv@inoi.fi>
In-Reply-To: <446A0CCF.2060903@inoi.fi>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20129>



On Tue, 16 May 2006, Tommi Virtanen wrote:
> 
> Just wanted to let you know of a workaround:
> manually edit the relevant file in .git/git-svn/tree/ to
> undo the $Id$ change, and git-svn fetch works again.

Isn't there some flag to svn to avoid keyword expansion, like "-ko" to 
CVS?

Any import script definitely should avoid keyword expansion (and that's 
true whether you end up wanting to use keywords or not).

(And yes, CVS is probably a bad example. Those "substitution modes" are 
confusing as hell, and I don't know which one is the right one. Is it 
"-ko" or "-kk"? Don't ask me, I'm CVS-illiterate. I don't know why the 
current cvsimport uses -kk, and only does it conditionally. Whatever.)

		Linus
