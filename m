From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git log --check to return an appropriate error
 code
Date: Sat, 9 Aug 2008 14:05:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808091404230.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de> <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2033251867-1218283501=:24820"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Peter_Valdemar_M=F8rch?= <4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 14:03:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRnAq-00053k-PI
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 14:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYHIMA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 08:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbYHIMA1
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 08:00:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:47640 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751338AbYHIMA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 08:00:26 -0400
Received: (qmail invoked by alias); 09 Aug 2008 12:00:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 09 Aug 2008 14:00:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jGIFTlx7jhA06fPNlll9KjlrAr6eH0CzCmy/2gR
	ccjyDKTNHC6SMS
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91766>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2033251867-1218283501=:24820
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 9 Aug 2008, Peter Valdemar Mørch wrote:

> 	Whether or not a check fails is stored in the
> 	DIFF_OPT_CHECK_FAILED field of flags in struct diff_options.
> 	This flag-field is only set (diff.c:1644), never cleared.

That is a side effect.  How wise is it to rely on that?

Ciao,
Dscho
--8323329-2033251867-1218283501=:24820--
