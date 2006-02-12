From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.2.0
Date: Sun, 12 Feb 2006 14:29:35 -0800
Message-ID: <7vzmkw6wj4.fsf@assigned-by-dhcp.cox.net>
References: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net>
	<43EFADD9.7010909@zytor.com> <7vpsls8cs6.fsf@assigned-by-dhcp.cox.net>
	<20060212220406.GY31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 23:29:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Piv-00072G-2i
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 23:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWBLW3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 17:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWBLW3g
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 17:29:36 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47020 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751034AbWBLW3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 17:29:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212222941.VWML25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 17:29:41 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060212220406.GY31278@pasky.or.cz> (Petr Baudis's message of
	"Sun, 12 Feb 2006 23:04:06 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16025>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sun, Feb 12, 2006 at 10:53:13PM CET, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> By the way, did I screw up the original announce?  I do not see
>> the message come back to me from vger...
>
> I didn't receive it either, and neither my git-bisect patch.

Hmph, maybe there is a hiccup at the majordomo?  I did not hear
much about that from HPA either but hopefully mine I now know
how to work it around.  Earlier I had git on To: and kernel on CC:
but this time I felt the announcement was important enough that
I had both on To: which I did not see come back.  A later resend
in my usual way made it through, so I'll stick to it as a
workaround for now.

Your patch e-mail, I _did_ get two copies, one direct and one
via vger, so it might be something else.

Anyhow, I am done for the day (it turned out to be a loooong
one), and I'll reopen "master" and "maint" after I get some
rest.

    X-From-Line: git-owner@vger.kernel.org Sun Feb 12 16:27:05 2006
    Received: from pop.west.cox.net (68.6.19.2) by osiris with POP3 for
      <postmaster@osiris>; 12 Feb 2006 16:27:05 -0000
    Return-Path: <git-owner@vger.kernel.org>
    Received: from fed1rmimpi03.cox.net ([70.169.32.70])
              by fed1rmmtai06.cox.net
              (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
              id <20060212160519.RZSC2846.fed1rmmtai06.cox.net@fed1rmimpi03.cox.net>;
              Sun, 12 Feb 2006 11:05:19 -0500
    Received: from vger.kernel.org ([209.132.176.167])
            by fed1rmimpi03.cox.net with IMP
            id wg5C1T01W3d4pq90000000
            for nrsolis@cox.net; Sun, 12 Feb 2006 11:05:17 -0500
    Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
            id S1751138AbWBLQFj (ORCPT <rfc822;junkio@cox.net> + 2 others);
            Sun, 12 Feb 2006 11:05:39 -0500
    Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBLQFj
            (ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 11:05:39 -0500
    Received: from w241.dkm.cz ([62.24.88.241]:40140 "EHLO machine.or.cz")
            by vger.kernel.org with ESMTP id S1751138AbWBLQFi (ORCPT
            <rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 11:05:38 -0500
    Received: (qmail 512 invoked by uid 2001); 12 Feb 2006 17:06:14 +0100
    Date:	Sun, 12 Feb 2006 17:06:14 +0100
    From:	Petr Baudis <pasky@suse.cz>
    To:	junkio@cox.net
    Cc:	git@vger.kernel.org
    Subject: [PATCH] Properly git-bisect reset after bisecting from non-master head
    Message-ID: <20060212160614.GV31278@pasky.or.cz>
