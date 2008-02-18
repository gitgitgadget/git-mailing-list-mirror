From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test cases: optionally setup branch.*.merge from upstream
 local branches
Date: Mon, 18 Feb 2008 18:23:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181822130.30505@racer.site>
References: 1203342817-19653-1-git-send-email-jaysoffian@gmail.com <1203347245-23533-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRAen-0007Gc-Dy
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 19:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbYBRSX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 13:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYBRSX0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 13:23:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:44538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751859AbYBRSXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 13:23:25 -0500
Received: (qmail invoked by alias); 18 Feb 2008 18:23:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 18 Feb 2008 19:23:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wJsZH9v8wdolf21CTWsjWOAqcUNWvvjEZyhxRlz
	21ncGVikO+wM+F
X-X-Sender: gene099@racer.site
In-Reply-To: <1203347245-23533-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74325>

Hi,

On Mon, 18 Feb 2008, Jay Soffian wrote:

> Added test cases for new "optionally setup branch.*.merge from upstream 
> local branches" functionality.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
>  t/t3200-branch.sh |   21 +++++++++++++++++++--

You might want to add another patch, this time to t7201-co.sh, which 
demonstrates that even a "branch.autosetupmerge false" does not prevent 
"git checkout --track -b <name>" from working.

Ciao,
Dscho
