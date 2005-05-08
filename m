From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] core-git documentation update
Date: Sun, 08 May 2005 16:35:55 -0700
Message-ID: <7v3bsx2sv8.fsf@assigned-by-dhcp.cox.net>
References: <427E4AE1.2040105@dgreaves.com>
	<7vd5s15up8.fsf@assigned-by-dhcp.cox.net>
	<427E83EA.2000104@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 01:29:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUvCj-0001LL-86
	for gcvg-git@gmane.org; Mon, 09 May 2005 01:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbVEHXgC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 19:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVEHXgC
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 19:36:02 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:25279 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S263008AbVEHXf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 19:35:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508233556.JJXT26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 19:35:56 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <427E83EA.2000104@dgreaves.com> (David Greaves's message of
 "Sun, 08 May 2005 22:26:02 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

DG> The intention now was for me to go through Linus' HEAD and verify the
DG> docs actually documented the HEAD.
DG> Then I think comparing the HEAD to jit-jc and preparing patches for that?

That one is up to you, but if your patches are against git-jc,
it would make _my_ life simpler and hopefully would make merge
easier for Linus when he returns.

After he returns, it would probably not make much sense sending
patch against git-jc, unless all of the following conditions
hold true: (1) what is already merged to git-jc conflicts with
what you are modifying, (2) all changes in git-jc are trivially
correct and veriy likely to hit Linus tree without being
rejected, and (3) Linus is too busy and lags behind git-jc.

