From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Tue, 5 Feb 2008 01:40:53 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050139470.8543@racer.site>
References: <alpine.LNX.1.00.0802041336030.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCp5-0006Ue-Nn
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603AbYBEBle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757590AbYBEBld
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:41:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:46372 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756716AbYBEBld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:41:33 -0500
Received: (qmail invoked by alias); 05 Feb 2008 01:41:30 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp055) with SMTP; 05 Feb 2008 02:41:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cCZEMsWRcqaLPHlePENz1xHI5Qm19sQJVRwFL9c
	yIOIfTn2SwOiKN
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041336030.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72612>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

> If the test failed, it was giving really unclear ed script
> output. Instead, give a diff that sort of suggests the problem.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  t/t7201-co.sh |    4 ++--

This is not really a part of the series leading to builtin checkout.  But 
as a standalone patch, I like it (obviously... I tried to push for more 
--no-index uses in the test suite).

Ciao,
Dscho
