From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] "git" calls help_unknown_cmd(""); "git help" and "git help -a" return 0
Date: Fri, 26 Oct 2007 16:03:48 -0700
Message-ID: <7v640twka3.fsf@gitster.siamese.dyndns.org>
References: <1193283437-1706-1-git-send-email-srp@srparish.net>
	<7vd4v33iy0.fsf@gitster.siamese.dyndns.org>
	<20071025045228.GE759@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlYDn-0004Dw-1U
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbXJZXDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbXJZXDy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:03:54 -0400
Received: from rune.pobox.com ([208.210.124.79]:54545 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbXJZXDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 19:03:53 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 461CF150156;
	Fri, 26 Oct 2007 19:04:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B79B314EC56;
	Fri, 26 Oct 2007 19:04:11 -0400 (EDT)
In-Reply-To: <20071025045228.GE759@srparish.net> (Scott Parish's message of
	"Wed, 24 Oct 2007 21:52:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62449>

Scott Parish <sRp@srparish.net> writes:

> That's what i was hoping this patch did. I'm not entirely sure how
> its wrong as it seems to work for me.

I misread the patch.  My mistake.

> Regarding "git: '' is not a git-command" the way i was seeing that
> is that git is usually only called with commands, and '' isn't a
> valid command, hence the reason to exit 1, the help is just a nice
> user experience.

But think who would type "git<Enter>".  They are either people
who (1) do not even know that "git" alone is not useful and that
it always wants a subcommand, or (2) know "git<Enter>" is the
same as "git help" and wants to get the "common command list"
quickly.  Technically, "'' is not a git-command" is correct, but
the message does not help either audience, does it?
