From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] t1400-update-ref: set VISUAL=true as well as EDITOR=true
Date: Tue, 11 Jul 2006 02:15:34 -0700
Message-ID: <7vlkr04i4p.fsf@assigned-by-dhcp.cox.net>
References: <11526072802855-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 11:15:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0ELF-00077B-Sp
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 11:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWGKJPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 05:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWGKJPg
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 05:15:36 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43239 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750811AbWGKJPf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 05:15:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711091535.NUXC12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 05:15:35 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11526072802855-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Tue, 11 Jul 2006 01:41:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23699>

Eric Wong <normalperson@yhbt.net> writes:

> I have VISUAL set in my environment, and it caused git-commit to
> spawn my editor during the test.

I think it would be better to remove "EDITOR=: VISUAL=:"
settings from annotate-tests.sh, t1400-update-ref.sh and
t4013-diff-various.sh, and move that to test-lib.sh; there is no
point overriding them differently in each of these automated
tests.
