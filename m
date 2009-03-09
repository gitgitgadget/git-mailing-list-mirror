From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Move push logic to transport.c
Date: Mon, 9 Mar 2009 17:12:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903091711180.6358@intel-tinevez-2-302>
References: <alpine.LNX.1.00.0903082046280.19665@iabervon.org> <alpine.DEB.1.00.0903091033330.10279@pacific.mpi-cbg.de> <alpine.LNX.1.00.0903091200150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:14:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgi6v-0007jS-Ay
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 17:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbZCIQMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 12:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbZCIQMV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:12:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:44225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751416AbZCIQMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 12:12:20 -0400
Received: (qmail invoked by alias); 09 Mar 2009 16:12:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 09 Mar 2009 17:12:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ulPJmqUpuEB63wFHdQTg/m3hzI6wvFqpsk2W9c3
	rZr24YN35r2i/3
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.1.00.0903091200150.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112714>

Hi,

On Mon, 9 Mar 2009, Daniel Barkalow wrote:

> On Mon, 9 Mar 2009, Johannes Schindelin wrote:
> 
> > On Sun, 8 Mar 2009, Daniel Barkalow wrote:
> > 
> > > It doesn't convert http-push or the rsync transports, largely 
> > > because I don't have test setups for rsync or webdav to make sure 
> > > that they're still working.
> > 
> > $ ls t/*http-push*
> > t/t5540-http-push.sh
> > 
> > $ git grep -n test.*rsync t/
> > t/t5510-fetch.sh:195:test_expect_success 'fetch via rsync' '
> > t/t5510-fetch.sh:206:test_expect_success 'push via rsync' '
> > t/t5510-fetch.sh:217:test_expect_success 'push via rsync' '
> > 
> > It should be just a matter of installing an apache and rsync.
> 
> And configuring them suitably, yes. That's the part I haven't previously 
> done.

If you have to configure apache (or rsync) for the test to run properly, 
we have a serious bug in our test suite.  Please share the output in that 
case.

Ciao,
Dscho
