From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] format-patch: Produce better output with --inline or
 --attach
Date: Wed, 30 Jul 2008 16:29:39 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807301624410.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080730052401.GC4034@sigill.intra.peff.net> <1217396973-82246-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, peff@peff.net,
	Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:31:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOChV-0003fm-Gi
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbYG3O3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757049AbYG3O3n
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:29:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:51295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753621AbYG3O3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 10:29:43 -0400
Received: (qmail invoked by alias); 30 Jul 2008 14:29:41 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 30 Jul 2008 16:29:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gMfcKeGxgifkFSFuW/0eB23wYcxmwOEk3A3fuP7
	0ujtzQSxxCzBjC
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1217396973-82246-1-git-send-email-kevin@sb.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90796>

Hi,

On Tue, 29 Jul 2008, Kevin Ballard wrote:

> MIME defines the encapsulation boundary as including the preceding CRLF (or in

This line will still be too long in git log's output, as well as in git 
shortlog's output.  I thought we had a suggestion to use at most 76 
characters per line in SubmittingPatches, but apparently we don't.

> The second change is to always write the line termination character 
> (default: newline) even when using --inline or --attach. This is simply 
> to improve the aesthetics of the resulting message. When using --inline 
> an email client should render the resulting message identically to the 
> non-inline version. And when using --attach this adds a blank line 
> preceding the attachment in the email, which is visually attractive.

It appears that your patch has one uncontroversial and one controversial 
part, then.

Ciao,
Dscho
