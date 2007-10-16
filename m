From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/25] Port builtin-add.c to use the new option parser.
Date: Tue, 16 Oct 2007 14:17:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161417150.25221@racer.site>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-2-git-send-email-madcoder@debian.org>
 <1192523998-19474-3-git-send-email-madcoder@debian.org>
 <1192523998-19474-4-git-send-email-madcoder@debian.org>
 <1192523998-19474-5-git-send-email-madcoder@debian.org>
 <1192523998-19474-6-git-send-email-madcoder@debian.org>
 <1192523998-19474-7-git-send-email-madcoder@debian.org>
 <1192523998-19474-8-git-send-email-madcoder@debian.org>
 <1192523998-19474-9-git-send-email-madcoder@debian.org>
 <2209D123-A245-43C4-8DD9-A83386852556@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:17:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmIt-0004gB-T0
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbXJPNRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbXJPNRi
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:17:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:33720 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756466AbXJPNRh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:17:37 -0400
Received: (qmail invoked by alias); 16 Oct 2007 13:17:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 16 Oct 2007 15:17:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/q0kkl2iHqam/gg9MoyttAhGUghHr8XqZ33Mm8WI
	0hB4oSYVivex74
X-X-Sender: gene099@racer.site
In-Reply-To: <2209D123-A245-43C4-8DD9-A83386852556@mit.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61167>

Hi,

On Tue, 16 Oct 2007, Michael Witten wrote:

> On 16 Oct 2007, at 4:39:42 AM, Pierre Habouzit wrote:
> 
> > +	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update only files
> > that git already knows about"),
> 
> "update only files in the current directory that git already knows about"

"update tracked files"

Ciao,
Dscho
