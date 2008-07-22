From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] parse-options: fix parsing of "--foobar=" with no
 value
Date: Tue, 22 Jul 2008 21:05:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222104100.8986@racer>
References: <1216752267-12138-1-git-send-email-dkr+ml.git@free.fr> <20080722185427.GA10453@artemis.madism.org> <48863436.50309@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:06:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLO7Y-0005ac-JY
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbYGVUFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYGVUFE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:05:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:59530 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751323AbYGVUFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:05:03 -0400
Received: (qmail invoked by alias); 22 Jul 2008 20:05:01 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp050) with SMTP; 22 Jul 2008 22:05:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CYdNy8KFCATOo7Rquy8aimPiroynQQqmpIlFdww
	T4WSEtsAaqIOF9
X-X-Sender: gene099@racer
In-Reply-To: <48863436.50309@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89518>

Hi,

On Tue, 22 Jul 2008, Olivier Marin wrote:

> I would have find it convenient for things like --foobar=$var where foobar
> fallback to default when $var is empty.

--foobar=${var:-default} will expand to --foobar=default when $var is 
empty.

Hth,
Dscho
