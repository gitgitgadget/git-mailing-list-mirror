From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 12:55:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704181253350.12094@racer.site>
References: <11768880622402-git-send-email-junkio@cox.net>
 <1176888062865-git-send-email-junkio@cox.net> <4625F4AD.5CDDC502@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He7or-0003lp-Tk
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 12:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbXDRKzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 06:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbXDRKzW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 06:55:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:46290 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422829AbXDRKzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 06:55:21 -0400
Received: (qmail invoked by alias); 18 Apr 2007 10:55:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 18 Apr 2007 12:55:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+C3wkK1+WCw2afyTFa0LLPi66d+jsA/BR1tz1PlH
	mHh44a09rxRdbk
X-X-Sender: gene099@racer.site
In-Reply-To: <4625F4AD.5CDDC502@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44885>

Hi,

On Wed, 18 Apr 2007, Johannes Sixt wrote:

> Junio C Hamano wrote:
> > +       interpolate(cmdbuf, sizeof(cmdbuf), cmd, table, 3);
> > +
> > +       memset(&child, 0, sizeof(child));
> > +       child.argv = args;
> > +       args[0] = "sh";
> > +       args[1] = "-c";
> > +       args[2] = cmdbuf;
> > +       args[3] = NULL;
> 
> If I read the code correctly, there does not happen any shell quoting
> anywhere; hence, this shell invocation is dangerous.

AFAICT the files used are all temporary files named ".merge_file_xxxx" in 
the current directory, so there should not be a chance to have spaces or 
other weird characters in the files.

Ciao,
Dscho
