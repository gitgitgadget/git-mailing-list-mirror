From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] help.c: Add support for htmldir relative to
 git_exec_path()
Date: Fri, 4 Jul 2008 13:35:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807041334010.9925@racer>
References: <394A4A6F-3D31-4E38-A312-B49DE54FBBDD@zib.de> <1215162566-16062-1-git-send-email-prohaska@zib.de> <7vk5g2uhi9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 14:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEkYO-0004XH-6e
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 14:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbYGDMhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 08:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbYGDMhV
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 08:37:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:60021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753572AbYGDMhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 08:37:20 -0400
Received: (qmail invoked by alias); 04 Jul 2008 12:37:18 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp043) with SMTP; 04 Jul 2008 14:37:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aWpgB9bUaKpG+6LZjrq401f4lNmeUUosTuwkSVZ
	wke4vfc+WV5V27
X-X-Sender: gene099@racer
In-Reply-To: <7vk5g2uhi9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87383>

Hi,

On Fri, 4 Jul 2008, Junio C Hamano wrote:

> Could you check if there are copy-and-pasted duplicated code you can 
> factor out before continuing this direction?

Note also that Hannes tried very hard to get rid of those ugly "#ifdef 
__MINGW32__"s by declaring/overriding functions in git-compat-util.h.

I think that is such a good practice that we should not stop here.

Ciao,
Dscho
