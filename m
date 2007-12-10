From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git-help -i (info): finishing touches
Date: Mon, 10 Dec 2007 02:06:51 -0800
Message-ID: <7v8x42n9s4.fsf@gitster.siamese.dyndns.org>
References: <1197279969-10613-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 11:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1fY0-0002SV-7n
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 11:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbXLJKHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 05:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbXLJKHO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 05:07:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXLJKHN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 05:07:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C12061849;
	Mon, 10 Dec 2007 05:07:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3871F1820;
	Mon, 10 Dec 2007 05:07:03 -0500 (EST)
In-Reply-To: <1197279969-10613-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 10 Dec 2007 01:46:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67698>

Junio C Hamano <gitster@pobox.com> writes:

> This series attempts to add finishing touches to "git help -i" (info)
> support.

Side note.  The patches I sent out are queued for 'next', and I'll push
it out shortly.  I am hoping, after this series graduates to 'master',
to be able to tag v1.5.4-rc0 and declare 'master' as feature complete
for now, and see everybody move to bugfix-only mode.

Currently, the man pages are sorted in $(wildcard) order in the main
menu, but I think:

 * make git(7) the first node after Top;

 * order the commands in the main @menu to follow the command-list.txt
   categorization, and show Porcelains and then Plumbings, just like
   git(7) does;

would make the organization better, but I did not do that tonight.  I'd
leave that as an exercise to interested readers.

I also briefly considered rolling the manual pages into git.info which
is built from the user manual, but I decided against it for now.  I
think the current organization of the user manual is good as a
standalone document, and making the manual set as its appendix is
possible but not necessary.  I can be persuaded differently, though.
