From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Remove unecessary hard-coding of EDITOR=':' VISUAL=':' in some test suites.
Date: Fri, 02 Nov 2007 13:09:56 -0700
Message-ID: <7vtzo41ka3.fsf@gitster.siamese.dyndns.org>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
	<1194017589-4669-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:10:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io2qn-00050k-BF
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603AbXKBUKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 16:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757158AbXKBUKE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:10:04 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:46497 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbXKBUKC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 16:10:02 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7CA202EF;
	Fri,  2 Nov 2007 16:10:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1787A90593;
	Fri,  2 Nov 2007 16:10:20 -0400 (EDT)
In-Reply-To: <1194017589-4669-2-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 2 Nov 2007 11:33:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63166>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> ---
>  t/t3501-revert-cherry-pick.sh |    4 ++--
>  t/t3901-i18n-patch.sh         |    8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

This is a good patch, but a real commit message that says why
they are unnecessary is lacking.  Something like...

        Sourcing of ./test-lib.sh at the very beginning of test scripts
        already define and export them.
