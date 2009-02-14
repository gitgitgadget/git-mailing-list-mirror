From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Sat, 14 Feb 2009 22:26:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142226200.10279@pacific.mpi-cbg.de>
References: <200902142056.42198.trast@student.ethz.ch> <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:27:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYS2m-0007AP-29
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbZBNVZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZBNVZ4
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:25:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:45800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751870AbZBNVZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:25:56 -0500
Received: (qmail invoked by alias); 14 Feb 2009 21:25:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 14 Feb 2009 22:25:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YGxky9DAYB/L/7Xc/BxZzsBpRR+BQ8OwOLa4kG9
	/yWqP/Y+98Be1g
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109934>

Hi,

On Sat, 14 Feb 2009, Thomas Rast wrote:

> We should use test_must_fail to negate output status, so that
> segfaults can be caught.  One instance of ! negation remains, but that
> actually tests the return code of 'grep'.

ACK.

Ciao,
Dscho
