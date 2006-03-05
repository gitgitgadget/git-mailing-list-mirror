From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-blame: Kill warning "print_map defined but not used"
Date: Sun, 5 Mar 2006 10:58:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603051054330.13139@g5.osdl.org>
References: <20060305111650.GC23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 05 19:58:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFyRH-0000gZ-73
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 19:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWCES6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 13:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWCES6c
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 13:58:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10689 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750758AbWCES6c (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 13:58:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k25IwKDZ028871
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Mar 2006 10:58:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k25IwJIM001006;
	Sun, 5 Mar 2006 10:58:20 -0800
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060305111650.GC23448@c165.ib.student.liu.se>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17237>



Fredrik,

Three comments on "git-blame":

 - you should use "-u -U 0" instead of "-u0" to avoid warnings from some 
   versions of GNU diff

 - Please default to HEAD so that you don't need to say it.

 - What I'd actually want to see is blame for a certain group of lines. 
   Ie, I'd like to see

	git-blame --line=50-56 filename

   which only shows those 7 lines. That would be wonderful for a visual 
   interface where you could mark off a few lines and say "follow these 
   backwards" kind of thing, and should make it more efficient than trying 
   to resolve the _whole_ file.

Hmm?

		Linus
