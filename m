From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/2] git submodule: normalize paths before adding
Date: Tue, 03 Mar 2009 08:32:02 -0800
Message-ID: <7vbpsid0u5.fsf@gitster.siamese.dyndns.org>
References: <49AD3A29.10404@drmicha.warpmail.net>
 <1236092901-28500-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXYt-0007Xb-Ht
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbZCCQcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbZCCQcO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:32:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126AbZCCQcN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:32:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C5DC49E930;
	Tue,  3 Mar 2009 11:32:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 31C529E92D; Tue,
  3 Mar 2009 11:32:03 -0500 (EST)
In-Reply-To: <1236092901-28500-1-git-send-email-git@drmicha.warpmail.net>
 (Michael J. Gruber's message of "Tue, 3 Mar 2009 16:08:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7A167EA-0810-11DE-8DA9-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112113>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This is a rewrite taking into account the advice given by Junio and J6t.
> In particular, the tests are good citizens w.r.t. cd'ing around now, the
> sed expressions work at least on AIX 4.3.3, and iterations of .. are
> tested for and handled correctly.
>
> Sorry I didn't get around to finishing this earlier. Hope this doesn't
> mess up any schedules.

No worries.

Other than obvious documentation fixes, anything sent after -rc0 will not
hit 'master' unless it is a fix, and after -rc1 nothing will hit 'master'
unless it is a regression fix.  Even if some future version of your patch
is queued to 'pu' or 'next, it won't affect the schedule for 1.6.2.

Traditionally, those patches that are irrelevant to the upcoming release
during the -rc period have been discussed on the list and then discarded,
with a request to be resubmit after the release.  Even though I have been
queuing them to 'pu' or 'next' as an experiment during this cycle, it has
not changed that during the -rc period, any new topic will not disrupt the
upcoming release.
