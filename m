From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] color-words: refactor to allow for 0-character word
 boundaries
Date: Mon, 12 Jan 2009 00:38:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901120037460.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de> <7viqolo2z9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 00:38:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM9tB-0002Xn-9S
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 00:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbZAKXhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 18:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbZAKXhQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 18:37:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:51232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751249AbZAKXhP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 18:37:15 -0500
Received: (qmail invoked by alias); 11 Jan 2009 23:37:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 12 Jan 2009 00:37:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LX/BdXKXLE+uZaOjeXVa1aCvNO2r1e6ZRawyCIs
	GjeJv0Uo7Acsa/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7viqolo2z9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105253>

Hi,

On Sun, 11 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This code was ugly, for a number of reasons:
> > ...
> > Fix all of these issues by processing the text such that
> 
> Looks much cleaner than the original.  I didn't compare it with 
> Thomas's, but it seems he found some breakages, so I'd expect a second 
> round sometime in the future.

Certainly,
Dscho
