From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] merge-file fails to output anything for a degenerate
 merge
Date: Mon, 25 May 2009 09:52:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905250951120.26154@pacific.mpi-cbg.de>
References: <1243210874-18451-1-git-send-email-charles@hashpling.org> <1243210874-18451-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon May 25 09:51:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8UyR-0003qv-GN
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbZEYHvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 03:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZEYHvf
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:51:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:40643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752242AbZEYHvf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 03:51:35 -0400
Received: (qmail invoked by alias); 25 May 2009 07:51:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 25 May 2009 09:51:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VEjgW0nZV9vNr33nagmk+1PISpjoS5wL+fOLVpw
	OFJEqt1NB8h0/g
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1243210874-18451-2-git-send-email-charles@hashpling.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119898>

Hi,

On Mon, 25 May 2009, Charles Bailey wrote:

> In the case that merge-file is passed three files with identical
> contents it wipes the contents of the output file instead of
> leaving it unchanged.
> 
> Althought merge-file is porcelain and this will never happen in
> normal usage, it is still wrong.
> 
> Signed-off-by: Charles Bailey <charles@hashpling.org>

Your patch is good, but I'd like to have it mention in the commit subject 
that this is not a fix, but a patch to the test suite.  A prefix "t6023:" 
would suffice, methinks.

Thanks,
Dscho
