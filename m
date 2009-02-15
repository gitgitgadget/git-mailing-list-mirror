From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use "git <command>" instead of dashed form in sample
 hooks
Date: Sun, 15 Feb 2009 18:10:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902151807010.10279@pacific.mpi-cbg.de>
References: <1234717348-20228-1-git-send-email-tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Feb 15 18:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYkWR-00038G-Vh
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 18:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbZBORJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 12:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbZBORJp
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 12:09:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:55967 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753561AbZBORJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 12:09:44 -0500
Received: (qmail invoked by alias); 15 Feb 2009 17:09:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 15 Feb 2009 18:09:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/re5ZrUi/zdSjbrt7Dy2VAmiybOeXuJKQE/wLA6
	phYIvpWyiCDwdY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234717348-20228-1-git-send-email-tlikonen@iki.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110024>

Hi,

On Sun, 15 Feb 2009, Teemu Likonen wrote:

> Sample hook files used deprecated dashed form "git-<command>" which are
> not installed in PATH anymore. This fixes them to use "git <command>"
> form instead.

AFAIR, GIT_EXEC_PATH will be added to the PATH before calling the hook.  
So this is not the fix you claim it to be.

But I agree that it is a nice cleanup to use undashed commands in the 
hooks (if only to make testing easier).

Also, I see that only 9 of your fixes touch code, the rest touches 
comments.

Ciao,
Dscho
