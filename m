From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn: Protect against "diff.color = true".
Date: Fri, 31 Aug 2007 22:38:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312237340.28586@racer.site>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
 <7vveav21uv.fsf@gitster.siamese.dyndns.org> <20070831152153.GA30745@muzzle>
 <7v4pifzawc.fsf@gitster.siamese.dyndns.org> <7v4pifxuia.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>,
	Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRECR-0006Tx-0m
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761184AbXHaVik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761173AbXHaVij
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:38:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:35050 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759609AbXHaVij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:38:39 -0400
Received: (qmail invoked by alias); 31 Aug 2007 21:38:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 31 Aug 2007 23:38:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jC5tUoEcj03QpGgmPkeRFtGNVwc9GeHr5XIHXg0
	jL9OusneSLvHZr
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pifxuia.fsf_-_@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57221>

Hi,

On Fri, 31 Aug 2007, Junio C Hamano wrote:

>   I do not have an easy access to SVN repo
>   to interoperate with, so a testing by real-world users and an
>   Ack is appreciated.

I just tested on a busybox clone: Works as expected.  Without your patch, 
I get the uninitialised values, with your patch it is fine.

ACK.

Ciao,
Dscho
