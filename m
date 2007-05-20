From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/3] Added generic string handling code.
Date: Sun, 20 May 2007 12:01:55 +0200
Message-ID: <20070520100155.GB3106@steel.home>
References: <1179627869.32181.1284.camel@hurina>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Sun May 20 12:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpiFP-0002Zu-KF
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762011AbXETKCD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764550AbXETKCC
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:02:02 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:39426 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762011AbXETKCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:02:01 -0400
Received: from tigra.home (Fc9f0.f.strato-dslnet.de [195.4.201.240])
	by post.webmailer.de (klopstock mo36) (RZmta 6.5)
	with ESMTP id F04727j4K8nYNA ; Sun, 20 May 2007 12:01:59 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 04FF6277BD;
	Sun, 20 May 2007 12:01:55 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CFDFFD195; Sun, 20 May 2007 12:01:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1179627869.32181.1284.camel@hurina>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAcjYFg=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47810>

Timo Sirainen, Sun, May 20, 2007 04:24:29 +0200:
> So here's my try on starting with something simple. Unlike almost all
> other string handling libraries, it doesn't allocate the memory
> dynamically.

Sometimes you _need_ dinamic memory allocation.

> This makes it really easy to convert existing code to use it. I'm
> including some example changes in the other patches. Besides making
> the code safer, it can also make it faster, especially those
> strcat() replacements.

It is also bigger, heavier on stack and sometimes slower because of
more function calls involved.

Aside from that, I like it. I wouldn't use it universally, but
there were times when I wished it has been be done this way.
