From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention the fact that 'git annotate' is only for
 backward compatibility.
Date: Thu, 04 Sep 2008 12:17:05 -0700
Message-ID: <7v63pb3emm.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
 <1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
 <20080904123046.GX10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbKLU-0000TM-T0
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbYIDTRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbYIDTRO
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:17:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbYIDTRO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:17:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B539074E95;
	Thu,  4 Sep 2008 15:17:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C449874E94; Thu,  4 Sep 2008 15:17:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 134B6EA0-7AB6-11DD-873B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94951>

Petr Baudis <pasky@suse.cz> writes:

> Can you please also mark it deprecated in the bash completion and
> command-list.txt?

I am hesitant to use the word "deprecated" in git(7) manual page, as the
word has much stronger connotation than merely "because a more often used
equivalent exists, there is no reason to encourage this for new people,
but on the other hand there is no reason to remove or phase it out to hurt
existing users", which is what "git annotate" is.

"Deprecated" is more like "it is still supported but its use is actively
discouraged".  I do not think we actively discourage it, nor need to phase
it out.

People coming from different background may look for annotate and get
frustrated until they find out blame is the equivalent (or vice versa).

While I do not mind marking annotate as ": infrequently used ;;" in the
completion script, I am skeptical about the value of such a change.
Dropping annotate from the completion is a _slight_ improvement in that
when people type "git a<TAB>" they will see one less candidates, but it is
not a great deal of improvement: four down from five.

Mentioning that we support both names for findability in both annotate and
blame manual pages (not just annotate page) might be a better thing to do.
