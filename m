From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Git.pm: Always set Repository to absolute path if
 autodetecting
Date: Sat, 18 Apr 2009 20:13:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904182012330.10279@pacific.mpi-cbg.de>
References: <1240070330-31446-1-git-send-email-frank@lichtenheld.de> <1240070330-31446-2-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat Apr 18 20:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvF10-0008AC-Oz
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 20:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZDRSKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 14:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbZDRSKN
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 14:10:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:57723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751932AbZDRSKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 14:10:12 -0400
Received: (qmail invoked by alias); 18 Apr 2009 18:10:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 18 Apr 2009 20:10:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EHR1GyT5ETf49qSGvpvrEVwQJhHMFqemBCYJ5QW
	xNDxPoMHhjJebU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1240070330-31446-2-git-send-email-frank@lichtenheld.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116859>

Hi,

On Sat, 18 Apr 2009, Frank Lichtenheld wrote:

> So far we only set it to absolute paths in some cases which lead to 
> problems like wc_chdir not working.

We had something similar in setup.c until Linus pointed out that it 
deteriorates performance.

Ciao,
Dscho
