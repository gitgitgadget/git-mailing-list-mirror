From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] Use start_command() to run the filter instead of
 explicit fork/exec.
Date: Sun, 30 Sep 2007 22:07:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302206330.28395@racer.site>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-3-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-4-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic61X-0001Qh-88
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbXI3VIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbXI3VIO
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:08:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:46620 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752184AbXI3VIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:08:13 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:08:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 30 Sep 2007 23:08:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HexomS7JH0yfPIYDyiKfpaqJ/oB0lEnBq3a6Rlm
	9iwsXvscjUITH3
X-X-Sender: gene099@racer.site
In-Reply-To: <1191183001-5368-4-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59564>

Hi,

On Sun, 30 Sep 2007, Johannes Sixt wrote:

> -	struct child_process child_process;
> +	struct child_process chld;

Why?  This patch is less readable because of that rename.

Ciao,
Dscho
