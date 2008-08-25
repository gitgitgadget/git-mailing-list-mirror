From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH v2 properly indented] fix start_command() bug when stdin is closed
Date: Mon, 25 Aug 2008 09:00:25 -0700
Message-ID: <quack.20080825T0900.lth1w0dult2@roar.cs.berkeley.edu>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
	<48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
	<E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
	<E1KXcH3-0000zJ-0m@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 18:02:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXeVW-0004OY-SN
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 18:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYHYQA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 12:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbYHYQA0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 12:00:26 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:47127 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbYHYQA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 12:00:26 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 915BD34401; Mon, 25 Aug 2008 09:00:25 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <E1KXcH3-0000zJ-0m@fencepost.gnu.org> (Paolo Bonzini's message of "Mon\, 25 Aug 2008 15\:37\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93638>


>>>>> On 2008-08-25 06:37 PDT, Paolo Bonzini writes:

    Paolo> diff --git a/run-command.c b/run-command.c index
    Paolo> caab374..4619494 100644

Excellent, this also fixes the problem for me.

Acknowledged-by: Karl Chen <quarl@quarl.org>

(I guess that's the protocol...)


Wow, turnaround on this list sure is fast.  Thanks, guys!
