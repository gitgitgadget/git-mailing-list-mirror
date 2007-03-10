From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] Teach run_command how to setup a stdin pipe
Date: Sat, 10 Mar 2007 17:54:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703101753440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070310082808.GE4133@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 17:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ4qK-0000sW-3N
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 17:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933490AbXCJQyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 11:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933493AbXCJQyp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 11:54:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:42660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933490AbXCJQyo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 11:54:44 -0500
Received: (qmail invoked by alias); 10 Mar 2007 16:54:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 10 Mar 2007 17:54:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Y05E7DntYu3D4JsyFbEJ5UGc1/TibBEvpcYnaAB
	sjiLBb9eiQ+2hY
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070310082808.GE4133@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41869>

Hi,

On Sat, 10 Mar 2007, Shawn O. Pearce wrote:

> Sometimes callers trying to use run_command to execute a child process 
> will want to setup a pipe or file descriptor to redirect into the 
> child's stdin.
> 
> This idea is completely stolen from builtin-bundle's fork_with_pipe, 
> written by Johannes Schindelin.  All credit (and blame) should lie with 
> Dscho.  ;-)

;-)

Thank you for starting this thread. I think it makes a lot of sense in the 
face of the MinGW port. (I am not interested in the hook stuff personally, 
so I'll not comment on that.)

Ciao,
Dscho
