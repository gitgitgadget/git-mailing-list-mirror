From: Petr Baudis <pasky@suse.cz>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 14:52:25 +0200
Message-ID: <20070509125225.GP4489@pasky.or.cz>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705061851411.4015@racer.site> <vpqk5vlamav.fsf@bauges.imag.fr> <7vvef5c0fw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 14:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hllej-0005Cj-4s
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbXEIMw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756604AbXEIMw2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:52:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60047 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbXEIMw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:52:27 -0400
Received: (qmail 18306 invoked by uid 2001); 9 May 2007 14:52:25 +0200
Content-Disposition: inline
In-Reply-To: <7vvef5c0fw.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46708>

On Sun, May 06, 2007 at 07:43:31PM CEST, Junio C Hamano wrote:
> A single liner "-m" is handy for "Oops, typofix in foo.c" kind
> of commit, but in such a case you literally would be changing
> only the typofix and won't have "edit foo.c; git add foo.c; edit
> foo.c; git commit" sequence anyway.

I don't get this argument - I frequently write quite long descriptions
inside the -m argument(s), since I just find it more convenient than
having to edit it in an editor, for various reasons. So there is really
no reason why the "-m is only for short single-liner commit messages"
hypothesis could hold true.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
