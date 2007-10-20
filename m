From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help
 option.
Date: Sat, 20 Oct 2007 21:28:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710202126430.25221@racer.site>
References: <bqaujirk.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 03:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjQ3N-0001qc-70
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXJUBzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbXJUBzu
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:55:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:33952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750851AbXJUBzu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 21:55:50 -0400
Received: (qmail invoked by alias); 20 Oct 2007 20:29:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 20 Oct 2007 22:29:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uCboLTpIuKcWJJwzpYdiuZtZBfij3A+kAahdCsm
	TY6AsqzZqlCynl
X-X-Sender: gene099@racer.site
In-Reply-To: <bqaujirk.fsf@blue.sea.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61861>

Hi,

On Sat, 20 Oct 2007, Jari Aalto wrote:

> - commented out call to list_common_cmds_help()

If you're really sure that this is desired, do not comment it out.  Delete 
it.

But am not at all sure that this is the way to go.  Rather, I like it that 
the most common commands are listed.  It would be better to find out what 
commands are really the most helpful to users who are likely to benefit 
from the list, and to present them better (such as showing them in 
categories).

Ciao,
Dscho
