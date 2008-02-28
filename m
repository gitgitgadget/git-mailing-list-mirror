From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 36/40] Avoid the "dup dance" in wt_status_print_verbose()
 when possible.
Date: Thu, 28 Feb 2008 15:48:58 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281547560.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-37-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:50:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUl1L-0000rc-Hm
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683AbYB1Ptb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758515AbYB1Pta
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:49:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:51603 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755304AbYB1Pta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:49:30 -0500
Received: (qmail invoked by alias); 28 Feb 2008 15:49:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp022) with SMTP; 28 Feb 2008 16:49:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ovc06h8Uo6aGkKTRPPgh7CjWjBhQyILwGaHi+io
	9NytdZ8Jp3lCCn
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-37-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75413>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> If the status output already goes to stdout, then it is not necessary to 
> redirect stdout for the diff machinery. (This case hangs on Windows for 
> unknown reasons.)

Just in case people like a diff machinery that can output somewhere else 
than stdout, I have a patch to do that, and also a corresponding patch to 
avoid the dup dance.

Ciao,
Dscho

