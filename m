From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git compile with SUNs forte12 compiler
Date: Sun, 13 May 2007 12:39:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705131238420.6410@racer.site>
References: <11790057101792-git-send-email-sithglan@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Sun May 13 12:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnBTx-0007AT-1J
	for gcvg-git@gmane.org; Sun, 13 May 2007 12:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbXEMKjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 06:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754924AbXEMKjL
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 06:39:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:46528 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754173AbXEMKjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 06:39:10 -0400
Received: (qmail invoked by alias); 13 May 2007 10:39:08 -0000
Received: from R4457.r.pppool.de (EHLO noname) [89.54.68.87]
  by mail.gmx.net (mp047) with SMTP; 13 May 2007 12:39:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xJUVYG/oxEdWiQuDHqY25Gq6GjR0f2C2/7TZnkP
	s2b58d1AJpJp8s
X-X-Sender: gene099@racer.site
In-Reply-To: <11790057101792-git-send-email-sithglan@stud.uni-erlangen.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47137>

Hi,

On Sat, 12 May 2007, Thomas Glanzmann wrote:

> This patch moves two inline functions from a header file to the 
> corresponding c file.

I think that it is wrong to move inline functions out of a header file. 
Many C compilers will not be able to inline it then.

A better solution (IMHO) is to make it "static inline".

Ciao,
Dscho
