From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk patch collection pull request
Date: Tue, 23 Oct 2007 12:17:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710231214150.30120@woody.linux-foundation.org>
References: <20071019052823.GI14735@spearce.org>
 <alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
 <18201.34779.27836.531742@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710192149020.3794@woody.linux-foundation.org>
 <18205.15967.792413.775786@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 21:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkPGk-0002za-Uo
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 21:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbXJWTSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbXJWTSP
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 15:18:15 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54203 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752127AbXJWTSO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 15:18:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NJHa5N001508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2007 12:17:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9NJHaEw002277;
	Tue, 23 Oct 2007 12:17:36 -0700
In-Reply-To: <18205.15967.792413.775786@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-2.42 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_12
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62150>



On Tue, 23 Oct 2007, Paul Mackerras wrote:
> 
> OK, done.  The checkbox is in the Edit/Preferences window.  It's
> called "Limit diffs to listed paths" and it's on by default.

Ok, the diff looks fine, but now the "list of files" pane on the right is 
empty. 

Even when you limit the diff output, you often have lots of files. At 
least I do, because I often limit by subdirectory. So I'd still like to 
see the file list on the right, so that I can jump to a particular part of 
the diff.

(It would also be nice if it showed the *size* of the changes a'la 
diffstat or something, but that's another and independent issue).

		Linus
