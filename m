From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 11:49:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101146230.30769@pacific.mpi-cbg.de>
References: <87wsd48wam.fsf@iki.fi> <1231549039-5236-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 10 11:50:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLbQM-0007AE-AQ
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbZAJKtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 05:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbZAJKtN
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:49:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:54110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752042AbZAJKtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 05:49:12 -0500
Received: (qmail invoked by alias); 10 Jan 2009 10:49:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 10 Jan 2009 11:49:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fHG9XUxJfZNnuIasGo4z63pNYAalet26E9CZB6r
	7Ir31JDR7kLEjK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231549039-5236-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105089>

Hi,

On Sat, 10 Jan 2009, Thomas Rast wrote:

>  diff.c                          |  199 +++++++++++++++++++++++++++++++++++----

!!!

BTW I did not really think about the issue you raised about the newlines, 
as I seemed to remember that the idea was to substitute all non-word 
characters with newlines, so that the offsets in the substituted text are 
the same as in the original text.

So I still find your patch way too large, and it keeps growing, 
unfortunately.

Ciao,
Dscho
