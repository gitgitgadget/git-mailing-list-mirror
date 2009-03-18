From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase: add options passed to git-am
Date: Wed, 18 Mar 2009 11:41:43 -0700
Message-ID: <7v1vsufzbs.fsf@gitster.siamese.dyndns.org>
References: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
 <1237399558-27289-3-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:43:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk0ja-0002tB-5T
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbZCRSlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbZCRSlw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:41:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbZCRSlw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:41:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E916C7D53;
	Wed, 18 Mar 2009 14:41:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 14BF97D51; Wed,
 18 Mar 2009 14:41:44 -0400 (EDT)
In-Reply-To: <1237399558-27289-3-git-send-email-barra_cuda@katamail.com>
 (Michele Ballabio's message of "Wed, 18 Mar 2009 19:05:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7090ED9A-13EC-11DE-8560-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113651>

Michele Ballabio <barra_cuda@katamail.com> writes:

> Add the options --committer-date-is-author-date and --ignore-date
> to git-rebase. They were introduced in commit a79ec62d0 for git-am.
>
> Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> ---
>
> I'm not sure if force_rebase should be set in this case.

Good thinking.

These are clearly "I want to change these commit" request just like
the "--whitespace=fix" option is, so I think it is probably a good idea.
