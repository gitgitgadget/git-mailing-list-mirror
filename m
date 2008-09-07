From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] Teach how to discard changes in the working
 directory
Date: Sun, 07 Sep 2008 16:32:16 -0700
Message-ID: <7vprnfjzwf.fsf@gitster.siamese.dyndns.org>
References: <1220825103-19599-1-git-send-email-mail@cup.kalibalik.dk>
 <7vtzcrk1wt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcTmX-0007AE-9D
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbYIGXcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYIGXcY
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:32:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbYIGXcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:32:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3077D78969;
	Sun,  7 Sep 2008 19:32:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5BA9E78965; Sun,  7 Sep 2008 19:32:19 -0400 (EDT)
In-Reply-To: <7vtzcrk1wt.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Sep 2008 15:48:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 38434F3A-7D35-11DD-90D1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95192>

Junio C Hamano <gitster@pobox.com> writes:

> I would agree that "hint is often given in #git" is an indication that
> people do not know "git checkout" to check out the path from the index to
> get rid of the change.  I further suspect that "I modified my file and git
> status says 'Changed but not updated'; what should I do" may not be asked
> often anymore, which might owe the hint we have in status output.  Even
> then, I do not necessarily agree that the status output (yes, I am also
> questioning the existing hints as well) is the best place to teach these
> people.
>
> The approach would lead to insanely long output that reproduces the user
> manual, and we should draw the line somewhere.  As I said, I suspect that
> what we say is already too chatty.

Having said all that, I'll queue them to see what other people think.
