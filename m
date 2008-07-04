From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t4127-apply-same-fn: Avoid sed -i
Date: Fri, 4 Jul 2008 19:39:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807041938360.9925@racer>
References: <1215100820-23140-1-git-send-email-dzickus@redhat.com> <486DC687.4070307@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Don Zickus <dzickus@redhat.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 04 20:42:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEqF0-0001kn-77
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 20:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbYGDSlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 14:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbYGDSlT
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 14:41:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:57278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750739AbYGDSlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 14:41:18 -0400
Received: (qmail invoked by alias); 04 Jul 2008 18:41:16 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp039) with SMTP; 04 Jul 2008 20:41:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SmPMoG04SEPqiMg5jJM3NKWhj+DRaKJ/Us9n2nm
	aHU29HQFc81gYJ
X-X-Sender: gene099@racer
In-Reply-To: <486DC687.4070307@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87407>

Hi,

On Fri, 4 Jul 2008, Johannes Sixt wrote:

> > When I created the tests for my git-apply patch, I accidently used the 
> > '-i' flag for sed.

Maybe we should modify our hooks so that this is warned about?  While at 
it, we could warn about quoted "wc -l", too...

Ciao,
Dscho
