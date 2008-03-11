From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/10] Completely move out worktree setup from
 setup_git_directory_gently()
Date: Tue, 11 Mar 2008 17:21:29 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111720501.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com>  <20080302103433.GA8970@laptop>  <alpine.LSU.1.00.0803111429380.3873@racer.site> <fcaeb9bf0803110828u3087ccdeqead5f2c433e08597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 17:22:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ7Ey-0005Wm-3B
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 17:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYCKQV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 12:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYCKQVZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 12:21:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:41555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751381AbYCKQVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 12:21:25 -0400
Received: (qmail invoked by alias); 11 Mar 2008 16:21:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 11 Mar 2008 17:21:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iZRJtft0iSV/DwbxHdY+IeMvv8jtLScKKg044Fd
	qSamMBLsiUKg/O
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0803110828u3087ccdeqead5f2c433e08597@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76876>

Hi,

On Tue, 11 Mar 2008, Nguyen Thai Ngoc Duy wrote:

> On Tue, Mar 11, 2008 at 8:31 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >  Particularly since working tree has a bad reputation already, as 
> >  Junio pointed out: whenever we touch it, we get burnt.
> 
> I'd rather get burnt now than later (which might be probably worse) :) 
> In case we are to be burnt, we should not have it in 1.5.5 :D

I'd rather be not burnt at all.  That's why I am opposed to this huge 
(relative to what it accomplishes) patch series.

Ciao,
Dscho
