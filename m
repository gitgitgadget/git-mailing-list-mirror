From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] War on whitespace: first, a bit of retreat.
Date: Fri, 02 Nov 2007 19:45:44 -0700
Message-ID: <7v7il0yrl3.fsf@gitster.siamese.dyndns.org>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
	<20071102174552.GE15595@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 03:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io91S-0004wi-TO
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 03:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbXKCCpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 22:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbXKCCpw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 22:45:52 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:57914 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973AbXKCCpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 22:45:51 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E4E0C2F2;
	Fri,  2 Nov 2007 22:46:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 66AB891A3B;
	Fri,  2 Nov 2007 22:46:08 -0400 (EDT)
In-Reply-To: <20071102174552.GE15595@fieldses.org> (J. Bruce Fields's message
	of "Fri, 2 Nov 2007 13:45:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63201>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> The whitespace policy varies based on the project (and in some cases,
> based on the file within that project).  It shouldn't vary from user to
> user or repo to repo.  So the configuration variable mechanism seems a
> poor match.  Would it be possible to use something like gitattributes
> instead?  Then the whitespace policy would be associated with the
> project itself, would automatically be propagated on clone, etc.

The use of gitattributes certainly sounds like a good way to
go.  A project like git may say "HT indent for C sources, SP
only for Python parts".

Having said that, I've added a few tests and merged the result
to 'next' already.  We can improve it to use attributes instead
while on 'next'.

And the git-apply side needs a matching adjustment.
