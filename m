From: Junio C Hamano <junkio@cox.net>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 17:16:42 -0700
Message-ID: <7vfyw98qvp.fsf@assigned-by-dhcp.cox.net>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org>
	<20050526004411.GA12360@vrfy.org>
	<Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org>
	<20050526202712.GA6024@vrfy.org>
	<7vy8a18w1e.fsf@assigned-by-dhcp.cox.net>
	<20050526235944.GB6215@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 02:15:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbSUy-0003Pk-0P
	for gcvg-git@gmane.org; Fri, 27 May 2005 02:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVE0AQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 20:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVE0AQr
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 20:16:47 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6802 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261709AbVE0AQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 20:16:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527001642.NNJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 20:16:42 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050526235944.GB6215@vrfy.org> (Kay Sievers's message of
 "Fri, 27 May 2005 01:59:44 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

KS> On Thu, May 26, 2005 at 03:25:17PM -0700, Junio C Hamano wrote:
>> >>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:
>> 
KS> Nice, thanks. Here is a very first try. It searches the commit messages
KS> and uses pickaxe to search in the file content:
KS> http://ehlo.org/~kay/gitweb.cgi?p=git/git.git;a=search;s=symlink
>> 
>> Nice, thanks for using pickaxe ;-).  One request, knowing well
>> that what you have on ehlo is your first cut.

KS> Yeah, I like it a lot. Nice work.

KS> Any idea, what's the reason, it doesn't find anything here in the
KS> kernel tree:
KS>   git-rev-list HEAD | git-diff-tree -S'TIMEOUT' --stdin

Dies this work for you?  Notice "-r".

git-rev-list HEAD | git-diff-tree -r -S'TIMEOUT' --stdin

