From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Make it scream by minimizing temp files
Date: Sun, 10 Aug 2008 00:47:42 -0700
Message-ID: <20080810074742.GB31438@hand.yhbt.net>
References: <1218235313-19480-1-git-send-email-marcus@griep.us> <20080809062521.GA10480@untitled> <489DBB8A.2060207@griep.us> <20080810014625.GA31438@hand.yhbt.net> <7v8wv54jar.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 09:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS5fg-00058U-78
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 09:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660AbYHJHrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 03:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757649AbYHJHro
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 03:47:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59129 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757640AbYHJHrn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 03:47:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 04C6F2DC01B;
	Sun, 10 Aug 2008 00:47:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8wv54jar.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91806>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Junio (or anybody else), any thoughts on what the submodule should be
> > named?  I'm not good at naming things :x
> 
> I'd say putting it in Git.pm itself is fine.  Git.pm is to give common
> services to Porcelains, and we already have things like command_*_pipe()
> family of functions that do not have to be git specific.

OK.

> I'd be a bit surprised if there isn't any existing CPAN module for things
> like this, though...

Wow, I am surprised.  I couldn't find anything in a few minutes of
searching...

-- 
Eric Wong
