From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] s/pattern/prefix/ in help's list_commands
Date: Wed, 24 Oct 2007 21:41:30 -0700
Message-ID: <7v640v3ix1.fsf@gitster.siamese.dyndns.org>
References: <1193283437-1706-1-git-send-email-srp@srparish.net>
	<1193283437-1706-2-git-send-email-srp@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 06:41:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkuXT-0008LH-TF
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 06:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbXJYElf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 00:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbXJYElf
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 00:41:35 -0400
Received: from rune.pobox.com ([208.210.124.79]:45228 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbXJYElf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 00:41:35 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 95E3B14E33F;
	Thu, 25 Oct 2007 00:41:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1870314E1CD;
	Thu, 25 Oct 2007 00:41:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62270>

Scott R Parish <srp@srparish.net> writes:

> list_commands() currently accepts and ignores a "pattern" argument,
> and then hard codes a prefix as well as some magic numbers.

Correct observation.

Personally, I find this static function should not pretend to be
as flexible --- it is to list git subcommands anyway (and it
even knows about ".exe"), so rather than renaming the pattern
and using it, it might be simpler and cleaner to just drop the
parameter and be done with it.
