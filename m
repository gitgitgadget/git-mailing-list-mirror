From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Sat, 19 Jan 2008 11:20:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801191119050.5731@racer.site>
References: <4790BCED.4050207@gnu.org> <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 12:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGBlK-0002yD-69
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 12:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbYASLUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 06:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYASLUx
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 06:20:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:32995 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750942AbYASLUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 06:20:52 -0500
Received: (qmail invoked by alias); 19 Jan 2008 11:20:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp035) with SMTP; 19 Jan 2008 12:20:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GzZYiTmrG0c2CbANs6pAFVNANqj5BLytElaBHRy
	tYlApPwSUCgU2B
X-X-Sender: gene099@racer.site
In-Reply-To: <4791C3A8.7000308@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71100>

Hi,

On Sat, 19 Jan 2008, Paolo Bonzini wrote:

> > On the other hand, if you want to always cause an action before 
> > running a git opeation locally, you do not have to have a hook. You 
> > can just prepare such a message based on GNU ChangeLog and then run 
> > git-commit with -F, both inside your wrapper.
> 
> I see two other possibilities:
> 
> 1) [..]
>
> 2) [..]
>
> 3) [..]

Of course, there is a fourth of "two other" possibilities:

Make a script calling git-commit with "-F - -e" and pipe your generated 
template into it.

Use this script whenever you want to create a new commit.

Hth,
Dscho
