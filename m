From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: use backticks rather than $() notation to
 support ancient shells
Date: Wed, 6 Aug 2008 02:10:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808060208450.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <K5bb057jTokXyOIU_aDE4vMr3jT4DOgSPRcIktfus6QMVq6dszrgGw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 06 02:06:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQWYC-0000vd-PM
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 02:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208AbYHFAFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 20:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbYHFAFr
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 20:05:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:49928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755817AbYHFAFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 20:05:46 -0400
Received: (qmail invoked by alias); 06 Aug 2008 00:05:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 06 Aug 2008 02:05:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QK5I7l9IQ8xkQsbmqujDcAtS0MBR9tTxFm7YI1G
	U4ZJGxWQUKAId3
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <K5bb057jTokXyOIU_aDE4vMr3jT4DOgSPRcIktfus6QMVq6dszrgGw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91473>

Hi,

On Tue, 5 Aug 2008, Brandon Casey wrote:

> Otherwise, should we set the SHELL variable to the configured SHELL_PATH 
> at some point in the Makefile?

I think that would make more sense, especially since it would catch 
wrong SHELL_PATH early.

Maybe we can even have some sanity check that tests if SHELL_PATH groks 
$()?

Ciao,
Dscho
