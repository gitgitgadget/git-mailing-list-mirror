From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/11] Provide API access to init_db()
Date: Sun, 9 Mar 2008 00:27:31 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803090026170.3975@racer.site>
References: <alpine.LNX.1.00.0803081804200.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8ST-0006bt-4S
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbYCHX11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbYCHX11
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:27:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:44543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751952AbYCHX10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:27:26 -0500
Received: (qmail invoked by alias); 08 Mar 2008 23:27:25 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp007) with SMTP; 09 Mar 2008 00:27:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VT2QNILBVByLXkhSLrN0FuUJ0ZNjPraSXlCTosn
	EDGtxFHmXdvi9Z
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803081804200.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76621>

Hi,

On Sat, 8 Mar 2008, Daniel Barkalow wrote:

> The caller first calls set_git_dir() to specify the GIT_DIR, and then 
> calls init_db() to initialize it. This also cleans up various parts of 
> the code to account for the fact that everything is done with GIT_DIR 
> set, so it's unnecessary to pass the specified directory around.

I think the most controversial part is that you change the way it is 
determined if the repository is a bare one.  It might have the same 
result (I do not have time to check it...), but the computation is 
performed differently.

Ciao,
Dscho
