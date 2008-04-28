From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git push --mirror" update mirrors
Date: Mon, 28 Apr 2008 08:08:10 +0200
Message-ID: <20080428060810.GA11858@cuci.nl>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org> <20080428033237.GN29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 08:09:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqMXw-0000iy-7n
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 08:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYD1GIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 02:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbYD1GIQ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 02:08:16 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:33506 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbYD1GIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 02:08:15 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0536C545E; Mon, 28 Apr 2008 08:08:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080428033237.GN29771@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80503>

Shawn O. Pearce wrote:
>It also clearly harms people who have only origin and want to grab
>updates from there with just `git fetch` or `git pull`.  Such a
>change would be asking these users to enter a longer command line.

Maybe this can be accomodated by having git fetch/git pull reference
all targets specified in the config file if none are specified on the
command line?

>On the other hand, I think it would teach those users how to better
>make use of git, and may cause less questions when they have to
>step slightly outside of their normal use case and specify a refspec.

I've been using git since november, and I found the magic "origin"
default one of the most confusing aspects (to figure out when it applies
and when not, and why (or why not)).
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
