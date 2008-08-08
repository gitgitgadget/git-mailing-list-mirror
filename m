From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Enable parallelized tests
Date: Fri, 8 Aug 2008 18:30:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081829160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <20080808153624.GA28716@neumann> <20080808160252.GA8541@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:27:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRUnr-0004dy-Fc
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbYHHQZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbYHHQZ5
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:25:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:48600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752821AbYHHQZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:25:57 -0400
Received: (qmail invoked by alias); 08 Aug 2008 16:25:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 08 Aug 2008 18:25:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ITWpIztJI0fCGrHrzAcMxAqFah8LNAcs1G5z60g
	/9wLdIi7b1sYc8
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080808160252.GA8541@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91688>

Hi,

On Fri, 8 Aug 2008, Stephan Beyer wrote:

> Hm, another simple(?) solution could be to make the tests that try to 
> access the same port/directory/whatever depend on each other.

No.  Because then you cannot run them independently anymore.

Ciao,
Dscho
