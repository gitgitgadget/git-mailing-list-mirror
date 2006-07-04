From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Beautifulise git-show output
Date: Tue, 04 Jul 2006 15:51:44 -0700
Message-ID: <7vejx1f0fz.fsf@assigned-by-dhcp.cox.net>
References: <11520525682686-git-send-email-beber.mailing@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 00:51:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxtkD-000416-E5
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 00:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWGDWvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 18:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWGDWvq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 18:51:46 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60094 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932322AbWGDWvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 18:51:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704225145.WIBB554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 18:51:45 -0400
To: beber.mailing@gmail.com
In-Reply-To: <11520525682686-git-send-email-beber.mailing@gmail.com> (beber
	mailing's message of "Tue, 4 Jul 2006 22:34:50 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23325>

Why?

A patch like this needs to be justified with a bit more
explanation; the word "beautiful" is subjective.

(current)
	Change this and that file

        Signed-off-by: A U Thor <a.u.thor@example.com>
	---
         this-file |   20 +++++++----
	 that-file |    4 ++++
	 2 files changed, 20 insertions(+), 4 deletions(-)

        diff --git a/this-file b/this-file
	...
 
(yours -- and I think 1.3.0 did it like this)
	Change this and that file

        Signed-off-by: A U Thor <a.u.thor@example.com>

	---
         this-file |   20 +++++++----
	 that-file |    4 ++++
	 2 files changed, 20 insertions(+), 4 deletions(-)

        diff --git a/this-file b/this-file
	...
 
It _might_ be easier to read if it were like this, though:
 
	Change this and that file

        Signed-off-by: A U Thor <a.u.thor@example.com>
	---

         this-file |   20 +++++++----
	 that-file |    4 ++++
	 2 files changed, 20 insertions(+), 4 deletions(-)

        diff --git a/this-file b/this-file
	...

However, the screen real estate, especially in the vertical
direction, is a scarce resource; I do not think the three-dash
is a too weak visual separator that needs to be helped by an
extra newline.
