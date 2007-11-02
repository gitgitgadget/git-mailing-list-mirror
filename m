From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New features in gitk
Date: Fri, 2 Nov 2007 11:16:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> 
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> 
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> 
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io15E-0000Qu-Lp
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 19:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbXKBSRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 14:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbXKBSRO
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 14:17:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42126 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751005AbXKBSRN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 14:17:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2IGbFO017728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 11:16:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2IGbOc004928;
	Fri, 2 Nov 2007 11:16:37 -0700
In-Reply-To: <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.731 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63148>



On Fri, 2 Nov 2007, Linus Torvalds wrote:
> 
> The thing is, I'm pretty sure I can feed you commits really quickly if I 
> don't sort them, and if I don't do the full and careful "oops, this commit 
> was reachable from a commit that was marked uninteresting", but while the 
> fast-and-stupid approach will work well enough for most things, it will 
> occasionally get the wrong answer.

Ok, I have a trial patch that doesn't do the replay yet, but at least 
notices when it outputs a parent that has already been shown.

In the whole git archive, it happens three times.

In the kernel archive, it happens twelve times.

I'll try to get it into some kind of usable shape, and send out 
experimental patches for people to play with.

		Linus
