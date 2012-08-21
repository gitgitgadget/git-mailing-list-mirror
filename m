From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: misleading diff-hunk header
Date: Tue, 21 Aug 2012 19:39:33 +0200
Message-ID: <5033C7D5.1030404@kdbg.org>
References: <503385D0.5070605@tim.thechases.com> <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:39:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3sQd-0006BE-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 19:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758234Ab2HURjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 13:39:42 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:11566 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758230Ab2HURjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 13:39:40 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 40121130045;
	Tue, 21 Aug 2012 19:39:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C1D5219F3C6;
	Tue, 21 Aug 2012 19:39:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <5033AC55.8080405@tim.thechases.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203975>

Am 21.08.2012 17:42, schrieb Tim Chase:
> On 08/21/12 10:22, Thomas Rast wrote:
>>> misleadingly suggesting that the change occurred in the call_me()
>>> function, rather than in main()
>>
>> I think that's intentional, and matches what 'diff -p' does...
> 
> Okay...I tested "diff -p" and can't argue (much) with historical
> adherence.  It just makes it hard for me to gather some stats on the
> functions that changed, and requires that I look in more than one
> place (both in the header, and in the leading context) rather than
> having a single authoritative place to grep.

If it's only for stats, why not just remove the context with -U0?

-- Hannes
