From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach fsck and prune about the new location of temporary
 objects
Date: Fri, 25 Jul 2008 02:33:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807250233031.4140@eeepc-johanness>
References: <6ruv3Y98_kSSVnJFTkV0PNdiNcQ3g-a3M4BhGoT7S1PorElp5tJAkw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBFs-00025D-Os
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbYGYAc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbYGYAc4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:32:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:46351 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752193AbYGYAcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:32:55 -0400
Received: (qmail invoked by alias); 25 Jul 2008 00:32:53 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp054) with SMTP; 25 Jul 2008 02:32:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DpykeWCTDX8JpgdhutE6Niz7O/7om3UgLAHgRJD
	LATBfKnl/P+I1t
X-X-Sender: user@eeepc-johanness
In-Reply-To: <6ruv3Y98_kSSVnJFTkV0PNdiNcQ3g-a3M4BhGoT7S1PorElp5tJAkw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89982>

Hi,

On Thu, 24 Jul 2008, Brandon Casey wrote:

> Since 5723fe7e, temporary objects are now created in their final destination
> directories, rather than in .git/objects/. Teach fsck to recognize and
> ignore the temporary objects it encounters,

It somehow feels wrong for fsck to ignore anything that could be used.

Ciao,
Dscho
