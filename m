From: Junio C Hamano <junkio@cox.net>
Subject: Re: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 22:43:32 -0700
Message-ID: <7vacng3jln.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>, Edgar Toernig <froese@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 07:37:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRkfo-00067o-Ag
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 07:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVD3Fni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 01:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVD3Fni
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 01:43:38 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:60371 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262520AbVD3Fng (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 01:43:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050430054332.HGGJ23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Apr 2005 01:43:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 29 Apr 2005 21:22:27 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Fri, 29 Apr 2005, Linus Torvalds wrote:
>> 
>> I'll happily depend on libcurl, but I put my foot down on that tool of the 
>> devil called "autoconf".

LT> Btw, looking at curl's "getdate.c", it doesn't seem to be _that_ much more 
LT> different from the date parsing we used to have. In particular, it 
LT> actually uses "mktime()" twice and subtracts out the difference.

If we are going to lift code from somewhere, why don't we steal
from a pro who knows what he is doing?  

One careful implementation of my-mktime() I know of is the one
by Paul Eggert, found in patch (maketime.c::tm2time).

