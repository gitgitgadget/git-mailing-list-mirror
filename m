From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] autoconf: Check for working mmap
Date: Fri, 04 Aug 2006 11:56:14 -0700
Message-ID: <7vodv0jpo1.fsf@assigned-by-dhcp.cox.net>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
	<11547069592652-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 20:56:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G94qU-0003Hp-Gx
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 20:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWHDS4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 14:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWHDS4Q
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 14:56:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:19350 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751452AbWHDS4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 14:56:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804185615.ZDQQ554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 14:56:15 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24820>

Jakub Narebski <jnareb@gmail.com> writes:

> Use AC_FUNC_MMAP check to check if the `mmap' function exists and
> works correctly.  (It only checks private fixed mapping of
> already-mapped memory.)

This tests something we do not really care about (we do not
mmap MAP_FIXED, and not over an already allocated space).
