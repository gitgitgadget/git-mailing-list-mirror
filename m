From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/10] test-lib: Simplify test counting.
Date: Wed, 18 Mar 2009 23:32:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903182331330.10279@pacific.mpi-cbg.de>
References: <cover.1237410682.git.j6t@kdbg.org> <26c0cd245694bed22d98850c8ac0a86f3c930789.1237410682.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4Ib-0002sc-CB
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbZCRWaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbZCRWaO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:30:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:47438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755438AbZCRWaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:30:13 -0400
Received: (qmail invoked by alias); 18 Mar 2009 22:30:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 18 Mar 2009 23:30:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UNrFH+UOUdkq0Zu5sYpudk0BKNgT3LKGL2CAQjA
	brRdMiFWUjZwsR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <26c0cd245694bed22d98850c8ac0a86f3c930789.1237410682.git.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113692>

Hi,

On Wed, 18 Mar 2009, Johannes Sixt wrote:

> Since the test case counter was incremented very late, there were a few
> users of the counter had to do their own incrementing. Now we increment it
> early and simplify these users.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/test-lib.sh |   10 +++-------
>  1 files changed, 3 insertions(+), 7 deletions(-)

Do you not need to adjust t4013 and t5515, too?

Ciao,
Dscho
