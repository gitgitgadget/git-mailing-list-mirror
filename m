From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 8/9] gitweb: Convert output to using indirect file
 handle
Date: Sun, 24 Jan 2010 23:14:44 +0100
Organization: 
Message-ID: <20100124221444.GB9553@machine.or.cz>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
 <m3ljfydgmt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 23:14:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZAjL-0002On-K6
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 23:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab0AXWOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 17:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062Ab0AXWOr
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 17:14:47 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56246 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005Ab0AXWOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 17:14:46 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 340DD125A0EC; Sun, 24 Jan 2010 23:14:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3ljfydgmt.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137923>

On Fri, Jan 15, 2010 at 04:43:32PM -0800, Jakub Narebski wrote:
> Third, wouldn't it be better to use shorter variable name, e.g. $out
> or $oh, instead of $output_handle?  We would be able to align print(f)
> statements without making lines much longer.

I totally agree, I was going to comment on this too. Please use
something very short, I think even the three characters might be pushing
it a bit. Having long idiom will make it real pain to both read and
write gitweb code.

It would still be nice if we could have some way to avoid this hack
entirely. Couldn't we layer PerlIO::via over STDOUT and continue to use
argument-less print as before?

I think we (well, in practice, "you" nowadays :) should be less
perfectionist when accepting gitweb contributions, so if the answer is
"it's too hard for me to do right now", that's fine I guess; I know I
can't contribute the code currently. :(

				Petr "Pasky" Baudis
