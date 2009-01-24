From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use time_t for timestamps returned by approxidate()
 instead of unsigned
Date: Sat, 24 Jan 2009 07:27:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901240726070.13232@racer>
References: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 07:28:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQc0L-0000XR-3N
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 07:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbZAXG1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 01:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbZAXG1G
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 01:27:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:54703 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750808AbZAXG1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 01:27:06 -0500
Received: (qmail invoked by alias); 24 Jan 2009 06:27:02 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp023) with SMTP; 24 Jan 2009 07:27:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZRCxxjZRZ9Mp0QMZFMl8qRZFiM9fBvrs3hO1opC
	DjMq6/D5zI1e/i
X-X-Sender: gene099@racer
In-Reply-To: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106956>

Hi,

On Thu, 22 Jan 2009, Tim Henigan wrote:

> Use time_t for timestamps returned by approxidate() instead of unsigned 
> long.  All references to approxidate were checked as well as references 
> to OPT_DATE.

Hmm.  I vaguely remember Linus mentioning recently that unsigned long is 
the appropriate data type for the Unix Epoch...

Ciao,
Dscho
