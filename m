From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH 1/2] contrib: Add diff viewing capability for
 Microsoft Word documents
Date: Thu, 27 Sep 2007 13:04:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709271258140.28395@racer.site>
References: <11908935593618-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Sep 27 14:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ias7q-0004Ju-0J
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 14:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbXI0MFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 08:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXI0MFm
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 08:05:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:57571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751255AbXI0MFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 08:05:41 -0400
Received: (qmail invoked by alias); 27 Sep 2007 12:05:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 27 Sep 2007 14:05:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sFYF4zs+skbg+3+0p2vmK51xlJ0Pf0c4PwoNuxD
	sc5PDcvoj8KUL9
X-X-Sender: gene099@racer.site
In-Reply-To: <11908935593618-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59292>

Hi,

On Thu, 27 Sep 2007, Johannes Sixt wrote:

> 	Ok, here's something that shows how git helps solve REAL PROBLEMS.

Hehe.

> +WINWORDEXE = C:/Program Files/Microsoft Office/Office/WINWORD.EXE

AFAICT this would be better written as $(PROGRAMFILES) (but you have to 
add proper quoting, I guess).

Or, alternatively, you can get it with a simple Tcl script

	package require registry 1.0
	puts [regsub "\\" [registry get \
		"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Extensions" \
		 "doc"] "/"]

Or something like that.

Ciao,
Dscho
