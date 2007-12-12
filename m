From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Don't cache DESTDIR in perl/perl.mak.
Date: Wed, 12 Dec 2007 10:01:48 -0800
Message-ID: <20071212180050.GA18980@untitled>
References: <20071210093102.3050.qmail@06e91d20307a62.315fe32.mid.smarden.org> <7vodcyl5dy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:02:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2VuO-0008K5-7k
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXLLSBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbXLLSBu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:01:50 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57732 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbXLLSBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:01:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A8AB67DC025;
	Wed, 12 Dec 2007 10:01:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vodcyl5dy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68077>

Junio C Hamano <gitster@pobox.com> wrote:
> Hmph.  That's reverting this:
> 
> commit 4c5cf8c44ce06a79da5bafd4a92e6d6f598cea2e
> Author: Eric Wong <normalperson@yhbt.net>
> Date:   Sun Aug 13 04:13:25 2006 -0700
> 
>     pass DESTDIR to the generated perl/Makefile
>     
>     Makes life for binary packagers easier, as the Perl modules will
>     be installed inside DESTDIR.
>     
>     Signed-off-by: Eric Wong <normalperson@yhbt.net>
>     Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> Eric, care to comment?

I used to make a statically linked binary package for working on an
ancient box that didn't have a lot of libraries I wanted, and I probably
just called `make install' into DESTDIR as a single step without calling
`make' alone without DESTDIR argument, or I had DESTDIR set in
config.mak

-- 
Eric Wong
