From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --color-words -U0: fix the location of hunk
 headers
Date: Sat, 31 Oct 2009 12:48:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910311247590.4985@pacific.mpi-cbg.de>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de> <200910291222.42598.markus.heidelberg@web.de> <alpine.DEB.1.00.0910291425010.3687@felix-maschine> <200910291729.23562.markus.heidelberg@web.de> <7v3a50n6hw.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910301831190.5383@felix-maschine> <7vr5sklo7c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 12:45:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4CP3-0001Yv-H9
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 12:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583AbZJaLpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 07:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757575AbZJaLpk
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 07:45:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:45829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757570AbZJaLpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 07:45:40 -0400
Received: (qmail invoked by alias); 31 Oct 2009 11:45:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 31 Oct 2009 12:45:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Dw+QfstND0+z7od641c8Ihz8ESbzFKv23KMmsQC
	Veg3EMrhOn880Q
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vr5sklo7c.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131840>

Hi,

On Fri, 30 Oct 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The reason I did not do that was to avoid a full subroutine call, as I 
> > expected this code path to be very expensive.
> 
> This is only done for the "word diff" mode, and my gut feeling is that it
> is not such a big issue.

Yeah, sorry, I should have stated explicitely that I no longer think that 
there is a performance issue.

Ciao,
Dscho
