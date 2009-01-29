From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Thu, 29 Jan 2009 17:13:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291713140.3586@pacific.mpi-cbg.de>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 17:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZXR-0003q3-KL
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 17:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbZA2QNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 11:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZA2QNT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 11:13:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:59799 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751320AbZA2QNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 11:13:18 -0500
Received: (qmail invoked by alias); 29 Jan 2009 16:13:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 29 Jan 2009 17:13:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oEvY17VLoQuytNaBw4L6BDJB+8yA7KtLs3i/dP9
	9t506v9K5uit1V
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1233244816-67565-1-git-send-email-benji@silverinsanity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107700>

Hi,

On Thu, 29 Jan 2009, Brian Gernhardt wrote:

> The call to "git reset --hard B1" failed on case-insensitive file
> systems (such as the default settings for HFS+) because there was both
> a tag "B1" and a file "b1".  Adding "--" to the command makes it
> clear that we mean commit B1.
> 
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>

Sigh.

ACK and thanks,
Dscho
