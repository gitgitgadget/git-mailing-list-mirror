From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as shortcut
 to the tracked branch
Date: Fri, 20 Mar 2009 01:38:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Andreas Gruenbacher <agruen@suse.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSkc-0001CN-V5
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760555AbZCTAgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760321AbZCTAgo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:36:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:39006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759169AbZCTAgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:36:43 -0400
Received: (qmail invoked by alias); 20 Mar 2009 00:36:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 20 Mar 2009 01:36:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FMp8l18HFylEcZGCaYqHCEStrWncVqG/9231Ocy
	TD06erS/KkKEMD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113875>

Hi,

On Fri, 20 Mar 2009, Johannes Schindelin wrote:

> Just try this:
> 
> 	$ git checkout -b %helloworld

It gets worse.  Much worse.

Try this (triggered by a comment by Ilari on IRC):

	$ git checkout -b '@{1}'

That _works_! WTH?

Ciao,
Dscho
