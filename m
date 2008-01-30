From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: assume HEAD if no revision supplied
Date: Wed, 30 Jan 2008 20:35:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801302034310.23907@racer.site>
References: <47A0D0F0.1020800@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKJfP-0000hc-Vt
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 21:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759718AbYA3Ufc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 15:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762436AbYA3Ufb
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 15:35:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:48017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762263AbYA3Uf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 15:35:28 -0500
Received: (qmail invoked by alias); 30 Jan 2008 20:35:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 30 Jan 2008 21:35:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EvAwXRX9EmORrg7atQEgmOd5ZDqX2eDey32tG0j
	RWd4B3oLEn5pVY
X-X-Sender: gene099@racer.site
In-Reply-To: <47A0D0F0.1020800@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72065>

Hi,

On Wed, 30 Jan 2008, Brandon Casey wrote:

> filter-branch previously took the first non-option argument as the name 
> for a new branch. Since dfd05e38, it now takes a revision or a revision 
> range and modifies the current branch. Update to operate on HEAD by 
> default to conform with standard git interface practice.

FWIW I think the code wanted to let "git filter-branch" without options 
print the usage.

Ciao,
Dscho
