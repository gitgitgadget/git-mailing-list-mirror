From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Use a common function to get the pretty name of
 refs
Date: Mon, 9 Mar 2009 10:38:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903091036420.10279@pacific.mpi-cbg.de>
References: <alpine.LNX.1.00.0903082104410.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 10:38:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgbvt-0004KB-Da
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 10:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbZCIJgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 05:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbZCIJgd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 05:36:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:33998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbZCIJgd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 05:36:33 -0400
Received: (qmail invoked by alias); 09 Mar 2009 09:36:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 09 Mar 2009 10:36:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YpMJmFcRYgP84fN4E1dAR6FUG4Bqz4lgElUEXKk
	8Lw28rabVIOGQn
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.1.00.0903082104410.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112681>

Hi,

On Sun, 8 Mar 2009, Daniel Barkalow wrote:

> The result should be consistent between fetch and push, so we ought to 
> use the same code in both cases, even though it's short.

You might want to mention that we cannot use skip_prefix() here, as that 
function does not give us any clue if something was skipped at all, and we 
must _not_ skip multiple prefixes.

Ciao,
Dscho
