From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Tue, 9 May 2006 21:51:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605092150460.3718@g5.osdl.org>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605092117240.3718@g5.osdl.org> <7vd5emze3h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 06:52:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdgg9-0001vh-DR
	for gcvg-git@gmane.org; Wed, 10 May 2006 06:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWEJEvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 00:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEJEvz
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 00:51:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964811AbWEJEvz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 00:51:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4A4pjtH009231
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 21:51:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4A4pibp002245;
	Tue, 9 May 2006 21:51:45 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5emze3h.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19875>



On Tue, 9 May 2006, Junio C Hamano wrote:
> 
> It is problematic but not more than the current index + "Binary
> files differ" output.  If you have both pre and postimage then
> you do not need the binary data.

Fair enough.

> > But at least in theory we might well want to do "-R" eventually.
> 
> Yes, but even without binary, -R has a funny implication when
> copy-edit patch is involved.  What if a patch copy-edits to
> create a new file B based on old A, and also modifies A
> in-place, and somehow the postimages of A and B you already have
> are not consistent with what that patch does?

Yeah, that could get exciting ;)

		Linus
