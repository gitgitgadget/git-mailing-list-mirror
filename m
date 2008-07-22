From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] git add: do not add files from a submodule
Date: Tue, 22 Jul 2008 22:32:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222230490.8986@racer>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com> <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness> <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPTm-0006P4-Hk
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbYGVVcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYGVVcF
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:32:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:60291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753253AbYGVVcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:32:04 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:32:02 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp046) with SMTP; 22 Jul 2008 23:32:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cPbwIWTmchaMN9qgvd0bAJPusEoRila2eW1cS8I
	NaA9sEuS0WPk+t
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89543>

Hi Junio,

On Mon, 21 Jul 2008, Johannes Schindelin wrote:

> It comes quite as a surprise to an unsuspecting Git user that calling
> "git add submodule/file" (which is a mistake, alright) _removes_
> the submodule in the index, and adds the file.  Instead, complain loudly.
> 
> While at it, be nice when the user said "git add submodule/" which is
> most likely the consequence of tab-completion, and stage the submodule,
> instead of trying to add the contents of that directory.

Do you plan to apply the split-up builtin-add enhancments you did a few 
nights ago, so that this patch can be elegant?  I think this fix should go 
into 1.6.0.

Ciao,
Dscho
