From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3411: Fix ambiguous filename/tagname in setup
Date: Wed, 4 Feb 2009 21:31:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902042131130.10279@pacific.mpi-cbg.de>
References: <1233776556-9047-1-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:32:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUoQQ-0007qx-7r
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbZBDUbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZBDUbL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:31:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:38125 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752491AbZBDUbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:31:11 -0500
Received: (qmail invoked by alias); 04 Feb 2009 20:31:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 04 Feb 2009 21:31:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NuvV7prpNDq8l2h1ifUliUIjIVxyYQC4inRj4GR
	DFHwOsI113BQBW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1233776556-9047-1-git-send-email-arjen@yaph.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108426>

Hi,

On Wed, 4 Feb 2009, Arjen Laarhoven wrote:

> After commit 37e5c8f (Simplify t3411) the test setup fails on
> case-insensitive filesystems because 'git reset' can't disambiguate the
> filenames and tagnames.  An explicit '--' to 'git reset' fixes this.

Wasn't this just fixed by Junio, after a discussion between Brian, Junio 
and me?

Ciao,
Dscho
