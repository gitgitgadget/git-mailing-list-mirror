From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding Reviewed-by/Tested-by tags to other peoples commits
Date: Sat, 11 Oct 2008 12:42:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810111239590.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 12:42:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kobv8-0005ir-Ly
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 12:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbYJKKfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 06:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbYJKKfb
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 06:35:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:34322 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751154AbYJKKfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 06:35:30 -0400
Received: (qmail invoked by alias); 11 Oct 2008 10:35:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 11 Oct 2008 12:35:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7T5kKt9G7D1lk/xNYFsH0Yk4nPn4nxjdJl66xvO
	3w1gKlP0jWmt2w
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97968>

Hi,

On Sat, 11 Oct 2008, Alex Bennee wrote:

> I've just tested/reviewed a patch of someone elses and I want to forward 
> it on the appropriate mailing list. I gather for Linux you just add the 
> appropriate tags to the commit. Does git offer a shortcut for doing this 
> or do you have to do a reset HEAD^ and re-commit with a copy&pasted and 
> modified commit message?

http://thread.gmane.org/gmane.comp.version-control.git/75250/focus=76304

In the end, nothing happened, but I could see that you might want to push 
for this patch.  However, you'll have to replace the strbuf_initf() by 
the ugly strbuf_init() && strbuf_addf() sequence, because strbuf_initf() 
never made it into git.git.

Ciao,
Dscho
