From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Default options
Date: Thu, 10 May 2007 01:07:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705100106250.4167@racer.site>
References: <56b7f5510705091515l7c7090b9rd5599e8746642ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 01:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlvFf-0001XW-4t
	for gcvg-git@gmane.org; Thu, 10 May 2007 01:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbXEIXHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 19:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757791AbXEIXHN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 19:07:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:54577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756687AbXEIXHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 19:07:12 -0400
Received: (qmail invoked by alias); 09 May 2007 23:07:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 10 May 2007 01:07:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VmDpRFalVHOCfTX6tMSBAHjO38s4ODp4x4Y6P90
	UCJEp5sdN/k2uH
X-X-Sender: gene099@racer.site
In-Reply-To: <56b7f5510705091515l7c7090b9rd5599e8746642ef9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46809>

Hi,

On Wed, 9 May 2007, Dana How wrote:

> I notice git supports "alias.*" config variables.
> Would it be useful to also support "options.*" variables?

I would not do it, for the same reason we do not allow to override 
builtins via aliases: it breaks scripts.

Ciao,
Dscho
