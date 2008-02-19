From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] Export some email and pretty-printing functions
Date: Tue, 19 Feb 2008 13:06:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191305160.30505@racer.site>
References: <cover.1203392527.git.barkalow@iabervon.org> <alpine.LNX.1.00.0802182254180.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:07:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSC6-0005yb-TY
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbYBSNHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYBSNG7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:06:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:47660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752815AbYBSNG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:06:59 -0500
Received: (qmail invoked by alias); 19 Feb 2008 13:06:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 19 Feb 2008 14:06:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MLdN6xFdMzYem1+M2O8PIi9Kk2pzcziBxQ7c21r
	Rsg5vmgnxZoB5D
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802182254180.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74398>

Hi,

On Mon, 18 Feb 2008, Daniel Barkalow wrote:

> These will be used for generating the cover letter in addition to the 
> patch emails.

I copied the hunks of log_write_email_headers() and used "git diff -w" to 
verify that only one thing changed: "sha1" was renamed to "name".  It 
might make sense to rename it to "from", but then, I do not really care.

Ciao,
Dscho
