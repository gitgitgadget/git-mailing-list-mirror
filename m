From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Change feeds from commit to commitdiff output.
Date: Thu, 10 Jan 2008 12:21:21 -0800
Message-ID: <7vtzll5t4u.fsf@gitster.siamese.dyndns.org>
References: <20080110130900.GA9395@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian La Roche <laroche@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 21:22:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD3ua-0007QP-O5
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 21:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbYAJUVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbYAJUVd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 15:21:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbYAJUVc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 15:21:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B90ED4607;
	Thu, 10 Jan 2008 15:21:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F04BE4604;
	Thu, 10 Jan 2008 15:21:26 -0500 (EST)
In-Reply-To: <20080110130900.GA9395@dudweiler.stuttgart.redhat.com> (Florian
	La Roche's message of "Thu, 10 Jan 2008 14:09:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70083>

Florian La Roche <laroche@redhat.com> writes:

> [PATCH] gitweb: Change feeds from commit to commitdiff output.
>
> Change feeds from displaying the commit to displaying the commitdiff
> output. This way the patches are shown directly and code review is
> done more easily via watching feeds.
>
> Signed-off-by: Florian La Roche <laroche@redhat.com>

I can see that easier access to commitdiff output is sometimes
desirable.

If you are making this change unconditional, however, I think
there needs a list discussion between you and the silent
majority of people that have been perfectly happy with the
current "log only" behaviour.

And to have that discussion, you first have to wake them up,
which this patch would serve well as a wake-up call.  But if
that was the purpose of the posting, please (1) mark the patch
as such (commonly done by saying [RFC/PATCH] instead), and (2)
keep me out of the "To:" list, if the patch is not for inclusion
but for discussion ("cc:" is fine but it's redundant as long as
you are sending to the list).

After such a discussion, we may end up finding out that
everybody have been silently unhappy and wanted to have
commitdiff there, and agree on doing this unconditionally.

But we do not know that yet.

Thanks.
