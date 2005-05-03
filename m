From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 15:44:41 -0700
Message-ID: <7v8y2wszdy.fsf@assigned-by-dhcp.cox.net>
References: <1115145234.21105.111.camel@localhost.localdomain>
	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
	<Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
	<Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>
	<7vr7got2tz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505031446220.31626@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 00:41:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT64H-0005E0-Sf
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVECWqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 18:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVECWpM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 18:45:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14257 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261891AbVECWoq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 18:44:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503224443.MWRZ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 18:44:43 -0400
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0505031446220.31626@sam.ics.uci.edu> (Andreas
 Gal's message of "Tue, 3 May 2005 14:51:18 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "AG" == Andreas Gal <gal@uci.edu> writes:

AG> Whether you use an explicit "dev" type or an implicit "dev"
AG> type that calls itself "blob" and uses a magic mode flag to
AG> tell checkout that it needs special treatment doesn't make a
AG> difference.

True.  The use of word "wrong" in my message was _wrong_.  But
my gut feeling is that the code that has to deal with the dev
and symlink stuff would be simpler if we just stick to the blob
type.

AG> When was the last time you tried to version control /dev? ;)

Tried?  Never.  Wished?  Number of times.  It's just that there
is no such SCM that does this natively, so I keep "ls -l /dev"
output under CVS control as a rough approximation.

