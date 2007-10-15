From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 13:24:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710151321560.6887@woody.linux-foundation.org>
References: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> 
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> 
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> 
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> 
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
  <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
  <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site>
 <4713BA89.633B86F2@dessent.net>
 <Pine.LNX.4.64.0710152026260.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Eli Zaretskii <eliz@gnu.org>, ae@op5.se, tsuna@lrde.epita.fr
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:20:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhWVj-0000zF-CV
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 22:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934520AbXJOUZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 16:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932878AbXJOUZr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 16:25:47 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47968 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759431AbXJOUZq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 16:25:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9FKOIjS028163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Oct 2007 13:24:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9FKOHwO023410;
	Mon, 15 Oct 2007 13:24:18 -0700
In-Reply-To: <Pine.LNX.4.64.0710152026260.25221@racer.site>
X-Spam-Status: No, hits=-2.718 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61039>



On Mon, 15 Oct 2007, Johannes Schindelin wrote:
> 
> Bash we can fix in the long run (this goes under the keyword 
> "builtinification" on the git list)

I thought busybox was being used for the core commands? Is ash not 
complete/usable enough (with all the fixes git has had for broken shells) 
to be used? 

I do agree that perl looks unavoidable, but I thought the windows port 
already avoided at least bash. Not true?

(or is it just that even with ash, you end up hitting all the same issues 
with cygwin/msys?)

		Linus
