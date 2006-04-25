From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 12:51:08 -0700
Message-ID: <7vodypv3gz.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
	<e2lijt$aco$1@sea.gmane.org>
	<Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
	<BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
	<BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
	<BAYC1-PASMTP03E0B5376ACFF165B29ED1AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251155530.3701@g5.osdl.org>
	<7vslo1v4zw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604251233340.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 21:51:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYTZ9-0002B5-SK
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 21:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWDYTvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 15:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWDYTvL
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 15:51:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:905 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932175AbWDYTvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 15:51:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425195109.BNWG21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 15:51:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604251233340.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 25 Apr 2006 12:34:25 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19174>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 25 Apr 2006, Junio C Hamano wrote:
>> 
>> Then we should drop the author header and make it part of free
>> form text.  The core does not give any meaning to it.
>
> Sure it does. It's an integral part of logging: we not only verify the 
> format, we also have multiple different ways of showing it. So it 
> definitely changes the way we "act", very fundamentally.

Unfair ;-).  I'd consider "git log" semi-Porcelain and consider
rev-list and cat-file the true core level.

But you already made it clear that you are not opposed to 'note'
with a clear semantics "we _ignore_ it", the point was moot.

Sorry for the noise.
