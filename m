From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] git-submodule: allow submodule name and path to
 differ
Date: Sun, 10 Jun 2007 08:25:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100820560.4059@racer.site>
References: <1181425132239-git-send-email-hjemli@gmail.com>
 <1181425132294-git-send-email-hjemli@gmail.com> <7vbqfod57b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:29:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxHr9-00053j-JP
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760901AbXFJH25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760819AbXFJH25
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:28:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:42271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760203AbXFJH24 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:28:56 -0400
Received: (qmail invoked by alias); 10 Jun 2007 07:28:54 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp003) with SMTP; 10 Jun 2007 09:28:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Hg70NDb4Ho43h3qYg1XFpNNAqTz2zjRpwrKQYT/
	r0fcUfCz1mXbvc
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqfod57b.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49660>

Hi,

On Sat, 9 Jun 2007, Junio C Hamano wrote:

> Lars Hjemli <hjemli@gmail.com> writes:
> 
> > This teaches git-submodule to check module.*.path when looking for the 
> > config for a submodule path. If no match is found it falls back to the 
> > current behaviour (module.$path).
> 
> I have a feeling that it might be much less troublesome in the longer 
> term to admit that module.$path was a mistake and support only one 
> format; wouldn't trying to support both leave ambiguity and confusion?

Just my 2cents: git-submodule is not yet in any released version. So let's 
fix things early. In our world, it's not like you lose face when you have 
to admit mistakes. (Instead, you lose face when you refuse to fix them.) 
Ah, if only politics learnt from our world...

Ciao,
Dscho
