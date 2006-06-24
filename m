From: Junio C Hamano <junkio@cox.net>
Subject: Re: From b65bc21e7d8dc8cafc70dfa6354cb66b8874b2d9 Mon Sep 17 00:00:00 2001 [PATCH] Makefile: add framework to verify and bench sha1 implementations.
Date: Sat, 24 Jun 2006 12:47:12 -0700
Message-ID: <7virmquyin.fsf@assigned-by-dhcp.cox.net>
References: <20060624092921.32165.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Jun 24 21:47:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuE69-0001qo-DV
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWFXTrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 15:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWFXTrO
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 15:47:14 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46242 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751077AbWFXTrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 15:47:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624194713.BKGV1341.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 15:47:13 -0400
To: linux@horizon.com
In-Reply-To: <20060624092921.32165.qmail@science.horizon.com>
	(linux@horizon.com's message of "24 Jun 2006 05:29:21 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22540>

linux@horizon.com writes:

> Nice work, but I might point out that the original PPC SHA bug was hashing
> more than 0.5G of contiguous data in a *single* call to SHA1_Update,
> while your test program works with 8K buffers.

Blush.  I realized it and updated the version in "pu" after I
sen the message.
