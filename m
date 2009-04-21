From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Minor cleanup and bugfixing in git-notes.sh
Date: Tue, 21 Apr 2009 02:49:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904210248560.10279@pacific.mpi-cbg.de>
References: <200904210239.21974.johan@herland.net> <200904210241.10073.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:49:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4Ai-0003rR-AU
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 02:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbZDUArj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 20:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbZDUAri
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 20:47:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:36725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753867AbZDUAri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 20:47:38 -0400
Received: (qmail invoked by alias); 21 Apr 2009 00:47:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 21 Apr 2009 02:47:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Nlooxp0ENloLGZqRn62v4GbqkkDvcAU+OIcGJi1
	rSMgSmKdBvDOB+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200904210241.10073.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117055>

Hi,

On Tue, 21 Apr 2009, Johan Herland wrote:

> The following changes are made:
> - Rename $MESSAGE to $MSG_FILE which better describes its purpose
> - Make sure not only $MSG_FILE is removed upopn completion, but also
>   $GIT_INDEX_FILE
> - Remove stray "GIT_NOTES_REF=" in front of "git log ..." command

Valid points.  Mind if I squash this into the commit adding git-notes.sh?

Ciao,
Dscho
