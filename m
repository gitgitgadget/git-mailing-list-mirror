From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] document --force-rebase
Date: Wed, 18 Mar 2009 11:38:59 -0700
Message-ID: <7v63i6fzgc.fsf@gitster.siamese.dyndns.org>
References: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
 <1237399558-27289-2-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk0h2-0001en-GT
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbZCRSjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756163AbZCRSjH
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:39:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657AbZCRSjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:39:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F1EAA2926;
	Wed, 18 Mar 2009 14:39:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1E2ADA2924; Wed,
 18 Mar 2009 14:39:00 -0400 (EDT)
In-Reply-To: <1237399558-27289-2-git-send-email-barra_cuda@katamail.com>
 (Michele Ballabio's message of "Wed, 18 Mar 2009 19:05:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F10E4A8-13EC-11DE-A01A-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113650>

Michele Ballabio <barra_cuda@katamail.com> writes:

> +-f::
> +--force-rebase::
> +	Force the rebase even if the current branch is up to date.
> +	Normally, if the current branch is up to date, the rebase is
> +	aborted.
> +

For the sake of brevity we say "up to date" in the error message from the
command, but for people who look up the manual to figure out why their
rebase is not rebasing with that error message, we may want to explain
what the phrase means in this context.  E.g.

	... even if the branch is a descendant of the commit you are
	rebasing onto.  Normally the command will exit with a message
	"Current branch is up to date" in such a situation.
