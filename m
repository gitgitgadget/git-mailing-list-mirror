From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix interesting git-rev-list corner case
Date: Sat, 30 Jul 2005 22:32:20 -0700
Message-ID: <7v7jf7y1zv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
	<m31x5gob8k.fsf@telia.com>
	<Pine.LNX.4.58.0507300913000.29650@g5.osdl.org>
	<m3fytwm313.fsf@telia.com>
	<Pine.LNX.4.58.0507301354000.29650@g5.osdl.org>
	<Pine.LNX.4.58.0507302259140.26128@telia.com>
	<Pine.LNX.4.58.0507301428300.29650@g5.osdl.org>
	<Pine.LNX.4.58.0507301507390.29650@g5.osdl.org>
	<m3ack3nb3c.fsf@telia.com>
	<Pine.LNX.4.58.0507302142380.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Osterlund <petero2@telia.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 07:34:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz6TH-0006E4-MZ
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 07:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVGaFeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 01:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVGaFcb
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 01:32:31 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17630 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261718AbVGaFcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 01:32:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731053220.IYWA19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 01:32:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507302142380.29650@g5.osdl.org> (Linus Torvalds's message of "Sat, 30 Jul 2005 21:44:14 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 31 Jul 2005, Peter Osterlund wrote:
>>
>> > I bet there is a smarter way to do this, but this _should_ fix the problem
>> > Peter sees. Peter?
>> 
>> Yes, it does fix the problem. Thanks.
>
> Ok, Junio, can you apply the git-merge-base patch? It's not perfect, but
> it's clearly better than what's there right now.
>
> Add a "Signed-off-by: Linus Torvalds <torvalds@osdl.org>" and edit the 
> description a bit, perhaps.

OK.  It's already sitting at the top of the "pu" branch, so I'll
just advance "master" with your sign off added.
