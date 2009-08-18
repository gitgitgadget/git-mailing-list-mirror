From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remove ARM and Mozilla SHA1 implementations
Date: Tue, 18 Aug 2009 02:09:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908180208160.8306@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0908171940540.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCFU-0006rz-W6
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbZHRAIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 20:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbZHRAIP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:08:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:42096 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751011AbZHRAIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 20:08:14 -0400
Received: (qmail invoked by alias); 18 Aug 2009 00:08:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 18 Aug 2009 02:08:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+w748jJUiwS1v0otHOZZopbxab5xqyHglxhkpuzn
	ulRPFE1qEC8eGs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0908171940540.6044@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126323>

Hi,

On Mon, 17 Aug 2009, Nicolas Pitre wrote:

> They are both slower than the new BLK_SHA1 implementation, so it is
> pointless to keep them around.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
> 
> Someone else would need to make the call for the PPC version.

If I don't forget, I can test tomorrow on 2 different 32-bit PPCs and 
possibly one 64-bit PPC.

Ciao,
Dscho
