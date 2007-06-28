From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ignore end-of-line style when computing similarity score
 for rename detection
Date: Thu, 28 Jun 2007 13:41:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706281340090.4438@racer.site>
References: <20070628060416.GA13162@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 14:46:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3tOh-0006SB-HH
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 14:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760856AbXF1Mqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 08:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760761AbXF1Mqy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 08:46:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:57188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760685AbXF1Mqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 08:46:53 -0400
Received: (qmail invoked by alias); 28 Jun 2007 12:46:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 28 Jun 2007 14:46:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18C2iJqFlECilmQHm5oDLMHBsaRUNxuLte48ry2qT
	tcPOwOjsG0/Plm
X-X-Sender: gene099@racer.site
In-Reply-To: <20070628060416.GA13162@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51101>

Hi,

On Wed, 27 Jun 2007, Steven Grimm wrote:

> Junio rightly points out that it would be a mistake to discard \r
> characters from binary files when computing similarity scores.

Somehow I think that this should be triggered by "--ignore-space-at-eol", 
_and_ be accompanied by a test case.

Ciao,
Dscho
