From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] pretty.c: add %x00 format specifier.
Date: Fri, 21 Mar 2008 16:47:12 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803211646010.4124@racer.site>
References: <5d46db230803210805j95c6029m19b284836dcb504a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 16:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcjTG-0002jh-8W
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 16:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYCUPrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbYCUPrM
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 11:47:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:49335 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751266AbYCUPrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 11:47:12 -0400
Received: (qmail invoked by alias); 21 Mar 2008 15:47:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp008) with SMTP; 21 Mar 2008 16:47:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hl3ZaQAQhA6WHXjdrSotAgsrZ6boorv8AZSwOxb
	6zKmVGQ6dUWiRw
X-X-Sender: gene099@racer.site
In-Reply-To: <5d46db230803210805j95c6029m19b284836dcb504a@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77745>

Hi,

On Fri, 21 Mar 2008, Govind Salinas wrote:

> This adds a %x00 format which parses the 00 as hex encoding for a byte 
> and prints the resulting byte.  This can be used to add null bytes or 
> other bytes that can make machine parsing easier.  It is also necessary 
> to use fwrite to print out the data since printf will terminate if you 
> feed it a null.
> 
> Junio supplied the hex decoding.

This is all nice and well, but if I understood you correctly, your 
original aim was to have a pretty-formatted list of the revisions, but 
NUL-delimited for easy parsing.

Which you can do with "git log --pretty=format:%s -z" right now.

Ciao,
Dscho
