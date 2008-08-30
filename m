From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/12] xdl_fill_merge_buffer(): separate out a too deeply
 nested function
Date: Sat, 30 Aug 2008 11:14:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808301112420.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com> <1220056963-2352-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMTA-0000e1-2U
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbYH3JJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 05:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbYH3JJA
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:09:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:51877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751507AbYH3JI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:08:59 -0400
Received: (qmail invoked by alias); 30 Aug 2008 09:08:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 30 Aug 2008 11:08:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19G5hhd3EZGYpzXyRTKXt9eIdU2Anerhz5TAQsfoi
	gPlrmCI+b1IOUg
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1220056963-2352-2-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94361>

Hi,

On Fri, 29 Aug 2008, Junio C Hamano wrote:

> This simply moves code around to make a separate function that prepares 
> a single conflicted hunk with markers into the buffer.

Apart from renaming "i1" to "i", inverting the order of the if clauses, 
and making it more obvious that the calculation of size without dest is 
correct, this is a straight forward refactoring.

Ciao,
Dscho
