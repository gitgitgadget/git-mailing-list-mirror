From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Wed, 13 Nov 2013 07:47:03 +0100 (CET)
Message-ID: <20131113.074703.1555957018827670255.chriscool@tuxfamily.org>
References: <xmqqy54timsm.fsf@gitster.dls.corp.google.com>
	<20131112.214357.1022923291448967795.chriscool@tuxfamily.org>
	<xmqq7gcdgvmf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, ae@op5.se, git@vger.kernel.org, apenwarr@gmail.com,
	Johannes.Schindelin@gmx.de, jrnieder@gmail.com, max@quendi.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 13 07:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgUEi-0003su-TE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 07:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255Ab3KMGrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 01:47:33 -0500
Received: from [194.158.98.45] ([194.158.98.45]:57068 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751926Ab3KMGrc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 01:47:32 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 8BCABA1;
	Wed, 13 Nov 2013 07:47:05 +0100 (CET)
In-Reply-To: <xmqq7gcdgvmf.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237778>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes: 
>>
>> After a look at some languages, Python has "startwith()" and
>> "endswith()", and Java has "startWith()" and "endsWith()".
>>
>> But while we are at it, why not
>> "ends_with()" and "begins_with()"? To me using an underscore seems
>> more consistent with what we are doing in Git.
> 
> Sure.
> 
> I do not think Peff and I were discussing at that level yet to
> debate between camelCase and words_with_underscore.  We were mainly
> talking about what words to be used, which needs to come before the
> final appearance.

Ok.

By the way Ruby has "start_with?" and "end_with?". So the thing we can
discuss, if we go this way are:

	1) with an "s" after the verb or not?
	2) should we use "start" or "begin"?
	3) with an underscore, nothing or camelCase

My preference is:

1) with an "s"
2) "start"
3) underscore

so that gives: starts_with() and ends_with()

Thanks,
Christian.
