From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 9 Apr 2006 09:53:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 18:53:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSdAV-0004kJ-FU
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 18:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWDIQxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 12:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDIQxk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 12:53:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750813AbWDIQxj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 12:53:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k39GrZtH009857
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 9 Apr 2006 09:53:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k39GrYPl007465;
	Sun, 9 Apr 2006 09:53:34 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18550>



On Sun, 9 Apr 2006, Junio C Hamano wrote:
>
> And this makes "git log" to take common diff-tree options, so
> that it can be used as "git whatchanged".

I wonder... This all looks fine, but there are actually two different 
"diffs" that can be shown for "git log --diff <pathlimiter>":

 - the whole diff for a commit

 - the path-limited diff

and I think we'd likely want to have some way to select the output. 
Probably with the path-limited diff being the default (that's what 
"git-whatchanged" does), but perhaps with "--full-diff" showing the whole 
commit diff (which is what "gitk" does).

		Linus
