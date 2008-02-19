From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/5] Export some email and pretty-printing functions
Date: Tue, 19 Feb 2008 11:19:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802191117540.19024@iabervon.org>
References: <cover.1203392527.git.barkalow@iabervon.org> <alpine.LNX.1.00.0802182254180.5816@iabervon.org> <alpine.LSU.1.00.0802191305160.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:20:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVCR-0005vh-Uo
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYBSQTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbYBSQTc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:19:32 -0500
Received: from iabervon.org ([66.92.72.58]:33520 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbYBSQTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:19:31 -0500
Received: (qmail 8672 invoked by uid 1000); 19 Feb 2008 16:19:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 16:19:30 -0000
In-Reply-To: <alpine.LSU.1.00.0802191305160.30505@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74422>

On Tue, 19 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 18 Feb 2008, Daniel Barkalow wrote:
> 
> > These will be used for generating the cover letter in addition to the 
> > patch emails.
> 
> I copied the hunks of log_write_email_headers() and used "git diff -w" to 
> verify that only one thing changed: "sha1" was renamed to "name".  It 
> might make sense to rename it to "from", but then, I do not really care.

No, it's actually supposed to be the filename, I think. Beats me as to why 
it's used as the envelope from, but I'm not changing the logic there.

	-Daniel
*This .sig left intentionally blank*
