From: David Kastrup <dak@gnu.org>
Subject: Re: Git performance on OS X
Date: Sun, 20 Apr 2008 18:22:59 +0200
Message-ID: <85prskv6l8.fsf@lola.goethe.zz>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
	<alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
	<FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
	<m3od85qxcl.fsf@localhost.localdomain>
	<alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
	<alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org>
	<0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl>
	<alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org>
	<2F8F3BF2-66F9-473C-BE82-8F784E1FF9A4@ai.rug.nl>
	<alpine.LFD.1.10.0804191727270.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:24:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JncKa-0002ai-VJ
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 18:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbYDTQXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 12:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYDTQXK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 12:23:10 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:57125 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751768AbYDTQXJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 12:23:09 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 5C0821E51E6;
	Sun, 20 Apr 2008 18:23:07 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 4601F25411B;
	Sun, 20 Apr 2008 18:23:07 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-002-239.pools.arcor-ip.net [84.61.2.239])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 09064285428;
	Sun, 20 Apr 2008 18:23:07 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 5B97E1C39587; Sun, 20 Apr 2008 18:22:59 +0200 (CEST)
In-Reply-To: <alpine.LFD.1.10.0804191727270.2779@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 19 Apr 2008 17:31:41 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6848/Sun Apr 20 16:54:16 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79964>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Taking three seconds for the warm-cache case for just 50,000 files is 
> ludicrous. That's about an order-and-a-half slower than what I see.
>
> Maybe my CPU is faster too (2.66GHz Core 2), but the thing is, Linux 
> really does tend to outperform others at a lot of these kinds of loads. 
> System calls are fast to begin with, and the Linux directory cache kicks 
> ass, if I do say so myself.
>
> OS X doth suck. 

Oh, but OS X does utf8 unification and case folding: so it is actually
doing quite a bit more than Linux.

Of course, doing that sucks for even more reasons, but it is not an
accident.  It is intentional brain damage.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
