From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix apply --recount handling of no-EOL line
Date: Fri, 4 Jul 2008 20:34:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807042034040.9925@racer>
References: <1215198614-22148-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 04 21:37:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEr5n-000118-4G
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 21:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbYGDTgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 15:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbYGDTgL
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 15:36:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:56148 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750976AbYGDTgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 15:36:10 -0400
Received: (qmail invoked by alias); 04 Jul 2008 19:36:08 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp002) with SMTP; 04 Jul 2008 21:36:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4fI9Kp/X4YAIytuqk8aMOEr/qtMmmroK62NZHea
	YpGgwTt/olyqXB
X-X-Sender: gene099@racer
In-Reply-To: <1215198614-22148-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87413>

Hi,

On Fri, 4 Jul 2008, Thomas Rast wrote:

> If a patch modifies the last line of a file that previously had no
> terminating '\n', it looks like
> 
> -old text
> \ No newline at end of file
> +new text

Oh!

> Hence, a '\' line does not signal the end of the hunk.  This modifies
> 'git apply --recount' to take this into account.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

ACK!

Ciao,
Dscho
