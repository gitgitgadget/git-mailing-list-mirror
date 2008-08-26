From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 properly indented] fix start_command() bug when stdin
 is closed
Date: Mon, 25 Aug 2008 17:06:25 -0700
Message-ID: <7v7ia4d4hq.fsf@gitster.siamese.dyndns.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
 <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
 <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
 <E1KXcH3-0000zJ-0m@fencepost.gnu.org>
 <quack.20080825T0900.lth1w0dult2@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Tue Aug 26 02:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXm7Q-0001qd-Iy
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 02:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbYHZAGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 20:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbYHZAGf
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 20:06:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYHZAGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 20:06:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E315668D44;
	Mon, 25 Aug 2008 20:06:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A9DC68D42; Mon, 25 Aug 2008 20:06:28 -0400 (EDT)
In-Reply-To: <quack.20080825T0900.lth1w0dult2@roar.cs.berkeley.edu> (Karl
 Chen's message of "Mon, 25 Aug 2008 09:00:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7D58442-7302-11DD-9FAE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93696>

Karl Chen <quarl@cs.berkeley.edu> writes:

>>>>>> On 2008-08-25 06:37 PDT, Paolo Bonzini writes:
>
>     Paolo> diff --git a/run-command.c b/run-command.c index
>     Paolo> caab374..4619494 100644
>
> Excellent, this also fixes the problem for me.
>
> Acknowledged-by: Karl Chen <quarl@quarl.org>
>
> (I guess that's the protocol...)
>
>
> Wow, turnaround on this list sure is fast.  Thanks, guys!

Thanks.
