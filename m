From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] whitespace: reorganize initial-indent check
Date: Sun, 16 Dec 2007 13:06:53 -0800
Message-ID: <7vfxy2jqmq.fsf@gitster.siamese.dyndns.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
	<1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-2-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
	<B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 22:07:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J40hx-0006pa-P8
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 22:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382AbXLPVHL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2007 16:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757003AbXLPVHK
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 16:07:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953AbXLPVHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Dec 2007 16:07:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 165C2487C;
	Sun, 16 Dec 2007 16:07:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5CA4876;
	Sun, 16 Dec 2007 16:06:56 -0500 (EST)
In-Reply-To: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com> (Wincent
	Colaiuta's message of "Sun, 16 Dec 2007 11:02:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68488>

Wincent Colaiuta <win@wincent.com> writes:

> El 16/12/2007, a las 4:48, J. Bruce Fields escribi=F3=BA=8A=8A> Reorg=
anize to emphasize the most complicated part of the code (the tab
>> case).
>
> Any chance of either squashing this series into one patch seeing as =20
> its all churning over the same part of the code, or resending it with=
 =20
> numbering? The patches seemed to arrive out of order in my mailbox an=
d =20
> I don't really know what order they're supposed to be applied in and =
=20
> it's a bit hard to review.

I do not think squashing is necessary or a good idea in this case.  As
far as I can tell, the series does not have "oops, this fixes the
earlier problem I introduced in the series", but it is purely a logical
progression.  The first one fixes a bug introduced by the 0-base
conversion which can and should stand on its own.

The mails were properly threaded with in-reply-to so numbering is not
strictly necessary either, but would have helped readers with MUA that
do not pay attention to that header.

I already see JBF resent the series, which is very nice of him.
