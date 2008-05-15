From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 10:06:22 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805151004400.30431@racer>
References: <482B935D.20105@facebook.com> <482BE0EB.6040306@viscovery.net> <482BE238.5020309@facebook.com> <482BF69C.6020604@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 15 11:08:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwZQd-0006hS-FQ
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 11:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbYEOJGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 05:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbYEOJGV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 05:06:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:38508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751756AbYEOJGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 05:06:21 -0400
Received: (qmail invoked by alias); 15 May 2008 09:06:19 -0000
Received: from R33f0.r.pppool.de (EHLO racer.local) [89.54.51.240]
  by mail.gmx.net (mp034) with SMTP; 15 May 2008 11:06:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RVmw1piRRCr5RYVTbbRJWXVXIMWrzpNYIBTh8w1
	ePdti1bs1l6ESg
X-X-Sender: gene099@racer
In-Reply-To: <482BF69C.6020604@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82192>

Hi,

On Thu, 15 May 2008, Johannes Sixt wrote:

> +		do { } while (offset > ceil_offset && cwd[--offset] != '/');

You probably meant to remove the "do { }", and have an own line

			; /* do nothing */

but for the rest, I agree that it is easier on the eye (particularly the 
off-by-one issue, which is always a problem for this developer to get 
right; avoiding it is therefore the better option).

Ciao,
Dscho
