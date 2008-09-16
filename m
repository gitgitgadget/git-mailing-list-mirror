From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Tue, 16 Sep 2008 13:32:08 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809161326380.19665@iabervon.org>
References: <16219.81556.qm@web95005.mail.in2.yahoo.com> <20080915063521.GA1533@linode.davidb.org> <7vy71tetvt.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809151354040.19665@iabervon.org> <20080916041201.GA25033@linode.davidb.org>
 <alpine.LNX.1.00.0809161211440.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, dhruva <dhruva@ymail.com>,
	GIT SCM <git@vger.kernel.org>, Simon Hausmann <simon@lst.de>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 19:33:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfeQT-0003uy-Ku
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 19:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbYIPRcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 13:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYIPRcK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 13:32:10 -0400
Received: from iabervon.org ([66.92.72.58]:43187 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272AbYIPRcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 13:32:09 -0400
Received: (qmail 4973 invoked by uid 1000); 16 Sep 2008 17:32:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2008 17:32:08 -0000
In-Reply-To: <alpine.LNX.1.00.0809161211440.19665@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96021>

On Tue, 16 Sep 2008, Daniel Barkalow wrote:

> p4 keeps track of which revision of each file you have synced to in your 
> client (so that it can fail to update it sometimes, as you mention above), 
> and will complain if the synced-to version isn't the latest when you try 
> to submit. That's how it avoids having people accidentally back out each 
> other's changes in ordinary operation. As long as we can be sure that the 
> client hasn't been synced to a later version than what the parent of the 
> commit we're submitting is an import of, which should be done with "p4 
> sync <changenumber>", rather than trying to spot check for having 
> accidentally acknowledged more p4 history than we've accounted for.

That is, "p4 sync <path>@<change>", of course.

	-Daniel
*This .sig left intentionally blank*
