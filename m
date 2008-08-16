From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: document the pager.* configuration setting
Date: Fri, 15 Aug 2008 20:17:52 -0700
Message-ID: <7v63q1lkbj.fsf@gitster.siamese.dyndns.org>
References: <1218852584-10523-1-git-send-email-vmiklos@frugalware.org>
 <1218852873-10588-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 05:19:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUCJi-000311-T8
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 05:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYHPDR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 23:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYHPDR6
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 23:17:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbYHPDR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 23:17:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 743B85BCF0;
	Fri, 15 Aug 2008 23:17:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BDFDA5BCEF; Fri, 15 Aug 2008 23:17:54 -0400 (EDT)
In-Reply-To: <1218852873-10588-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 16 Aug 2008 04:14:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC6E0DAC-6B41-11DD-9E27-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92530>

Miklos Vajna <vmiklos@frugalware.org> writes:

> It was already documented in RelNotes-1.6.0, but not in the git-config
> manual page.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> Ugh, I just noticed that the example was wrong, because paging for
> status is disabled by default. Here is a corrected version.

Honestly, I do not think the distinction between your two versions matter.
Do we need a new example there?

The patch to Documentation/config.txt looks Ok, but I do not think you
need to say "allows to set your preference".  "Sets your preference" would
be enough.
