From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Move push logic to transport.c
Date: Mon, 9 Mar 2009 10:35:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903091033330.10279@pacific.mpi-cbg.de>
References: <alpine.LNX.1.00.0903082046280.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 10:35:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgbth-0003dC-5c
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 10:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbZCIJeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 05:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZCIJeM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 05:34:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:44080 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752834AbZCIJeL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 05:34:11 -0400
Received: (qmail invoked by alias); 09 Mar 2009 09:34:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 09 Mar 2009 10:34:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cVm8K+locukjsYQSvhOeXfQ61Zh7FS40TDXGQ0V
	vEbxVHExGMFFTf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.1.00.0903082046280.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112680>

Hi,

On Sun, 8 Mar 2009, Daniel Barkalow wrote:

> It doesn't convert http-push or the rsync transports, largely because I 
> don't have test setups for rsync or webdav to make sure that they're 
> still working.

$ ls t/*http-push*
t/t5540-http-push.sh

$ git grep -n test.*rsync t/
t/t5510-fetch.sh:195:test_expect_success 'fetch via rsync' '
t/t5510-fetch.sh:206:test_expect_success 'push via rsync' '
t/t5510-fetch.sh:217:test_expect_success 'push via rsync' '

It should be just a matter of installing an apache and rsync.

BTW thanks for the patch, I guess it will help Peff to complete "push 
--track" properly ;-)

Ciao,
Dscho
