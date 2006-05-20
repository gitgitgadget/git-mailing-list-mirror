From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk highlight feature
Date: Sat, 20 May 2006 09:42:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605200934240.10823@g5.osdl.org>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0605021659430.4086@g5.osdl.org> <Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
 <17496.7073.507895.484698@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0605030946260.4086@g5.osdl.org>
 <17518.24000.952384.563448@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 18:42:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhUXQ-0007vQ-4l
	for gcvg-git@gmane.org; Sat, 20 May 2006 18:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWETQme (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 12:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWETQme
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 12:42:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751437AbWETQme (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 12:42:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4KGgVtH031473
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 20 May 2006 09:42:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4KGgUMi000938;
	Sat, 20 May 2006 09:42:31 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17518.24000.952384.563448@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20383>



On Sat, 20 May 2006, Paul Mackerras wrote:
> 
> I just pushed some changes to the "new" branch of the gitk.git
> repository which change the way we do highlighting.  There is now a
> row of controls across the middle of the window, just below the row
> containing the sha1 ID, "Find" button, etc., which controls the
> highlighting.

Ok, this is much nicer, I think this ends up being much closer to what I 
really wanted, even if I didn't know quite how I wanted it.

I think the "Find" field should highlight things too. Right now there's no 
way to get highlighting for somebody having signed-off on a patch, for 
example, even though you can _search_ for it.

Also, right now it says "Author/committer", but it actually only triggers 
on author. Which may be the right thing to do (it's certainly what I'd 
normally want to see), but it doesn't match the description. 

		Linus
