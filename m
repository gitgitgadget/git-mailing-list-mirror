From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere: Separate libgit and builtin functions
Date: Wed, 9 Jul 2008 13:55:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807091355220.5277@eeepc-johanness>
References: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness> <1215598683-9685-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 13:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGYHx-0003vO-F3
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 13:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579AbYGILzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 07:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758578AbYGILzn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 07:55:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:43944 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758488AbYGILzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 07:55:42 -0400
Received: (qmail invoked by alias); 09 Jul 2008 11:55:40 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp001) with SMTP; 09 Jul 2008 13:55:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aGHEQS3WaNEEmYLi00k1f5qykeRzrHt7mJYpO4a
	naHuqHzOushxmp
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1215598683-9685-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87871>

Hi,

On Wed, 9 Jul 2008, Stephan Beyer wrote:

> This patch moves rerere()-related functions into a newly created 
> rerere.c file.  Also setup_rerere() is moved into rerere.c to decrease 
> code duplications for rerere.c and builtin-rerere.c.

It is not moved to decrease code duplication, but because it is needed by 
rerere().

Ciao,
Dscho
