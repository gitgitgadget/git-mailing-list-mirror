From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: print usage when no options specified
Date: Tue, 6 Jan 2009 20:28:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901062023100.30769@pacific.mpi-cbg.de>
References: <1230955152-23646-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, jidanni@jidanni.org,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:29:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKHce-0002if-Du
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 20:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbZAFT23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 14:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbZAFT23
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 14:28:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:55930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751092AbZAFT22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 14:28:28 -0500
Received: (qmail invoked by alias); 06 Jan 2009 19:28:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 06 Jan 2009 20:28:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZudBJ4hNZmUvIhh/+s7eRVXhfRxUiodvrvjt+7Q
	ZT/9GyFuhNEdrd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1230955152-23646-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104710>

Hi,

On Sat, 3 Jan 2009, Miklos Vajna wrote:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> I found that behaviour surprising as well when I saw it the first time.
> git rev-list outputs some usage info in that case, git log just logs
> HEAD. Given that unconditionally exporting HEAD with no arguments is
> probably not something most users want, here is a patch to make the
> behaviour like what git rev-list already has.

Maybe this should be part of the commit message?

-- snip --
Some people find it surprising that fast-export does not output a usage 
when called without parameters, as rev-list does.

This assumes that a user usually does not want to export HEAD by default.
-- snap --

However, I have to say that I would find exporting HEAD a rather sensible 
default.

But I am not _that_ strongly opposed to the patch.  Just would like to 
hear some opinions first.

Ciao,
Dscho
