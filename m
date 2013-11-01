From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/5] ref glob exclusion follow-up
Date: Fri, 01 Nov 2013 22:08:14 +0100
Message-ID: <5274183E.5090202@kdbg.org>
References: <52264070.3080909@kdbg.org> <1383334455-18623-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 22:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcLxD-0006qj-JX
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 22:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab3KAVIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 17:08:21 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:9111 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753817Ab3KAVIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 17:08:18 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 850DE13004F;
	Fri,  1 Nov 2013 22:08:15 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 831C519F5CF;
	Fri,  1 Nov 2013 22:08:14 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1383334455-18623-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237224>

Am 01.11.2013 20:34, schrieb Junio C Hamano:
> In $gmane/234730, J6t pointed out that "rev-list --exclude" needs a
> matching updates to the globbing option "rev-parse" supports.
> 
> Here is a follow-up to do just that. They are meant to be applied on
> top of the two patch series that has been cooking in 'pu'.

Thanks a lot! I took a stab at the task the other day. I intended to
weave the exclusion matching into the do_for_each_* functions in refs.c.
But I quickly found that I would take me much more time than I was able
to spend.

-- Hannes
