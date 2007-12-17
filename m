From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Mon, 17 Dec 2007 15:00:18 -0800
Message-ID: <7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
References: <20071217110322.GH14889@albany.tokkee.org>
	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Harl <sh@tokkee.org>, git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OxL-0003XQ-JJ
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276AbXLQXAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759361AbXLQXAa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:00:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076AbXLQXA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:00:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DA9B451C;
	Mon, 17 Dec 2007 18:00:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A18E0451A;
	Mon, 17 Dec 2007 18:00:20 -0500 (EST)
In-Reply-To: <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> (Benoit
	Sigoure's message of "Mon, 17 Dec 2007 23:32:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68649>

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

> ...  The current behavior of git stash is very
> dangerous as the following frequently happens to new comers:
>   $ git stash
>   $ <hack on something else>
>   $ git commit
>   $ git stash apply
>   $ git stash clean # Oops, typo, I just stashed my changes again
>   $ git stash clear # Oops, I just lost my changed

This is a plain FUD, isn't it?  The first Oops should not happen these
days.
