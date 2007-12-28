From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reflog weirdness
Date: Fri, 28 Dec 2007 13:20:16 -0800
Message-ID: <7vhci2ectr.fsf@gitster.siamese.dyndns.org>
References: <87ve6iegny.fsf@ambire.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thien-Thi Nguyen <ttn@gnuvola.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 22:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8MdP-00015N-55
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 22:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXL1VUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 16:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbXL1VUY
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 16:20:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbXL1VUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 16:20:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DB3103E24;
	Fri, 28 Dec 2007 16:20:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E5593E23;
	Fri, 28 Dec 2007 16:20:18 -0500 (EST)
In-Reply-To: <87ve6iegny.fsf@ambire.localdomain> (Thien-Thi Nguyen's message
	of "Fri, 28 Dec 2007 20:57:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69296>

Thien-Thi Nguyen <ttn@gnuvola.org> writes:

> i'd like to get rid of (or somehow get git to hide) the {21} line.
> any hints?

$ vi .git/logs/HEAD

and truncate that line after "commit: " to remove the part that
would normally show the one-line commit log message.

It would be more interesting to know why garbage follows
"commit: " on that one entry, though.  How does commit 20d9d23
look like (the tracked contents are not interesting --- the
commit log message is)?
