From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Add grep.fullName config variable
Date: Tue, 18 Mar 2014 21:01:47 +0100
Message-ID: <878us79syc.fsf@igel.home>
References: <874n2w3abu.fsf@igel.home>
	<xmqq7g7sbh56.fsf@gitster.dls.corp.google.com>
	<mvmy507stf1.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 21:01:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ0Cz-0003Lw-8e
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 21:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbaCRUBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 16:01:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59102 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbaCRUBu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 16:01:50 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fpQJF4YbFz4KK3s;
	Tue, 18 Mar 2014 21:01:48 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fpQJD60VHzbbh2;
	Tue, 18 Mar 2014 21:01:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Wz3MYHJnWLoD; Tue, 18 Mar 2014 21:01:48 +0100 (CET)
X-Auth-Info: qv1TmTyW0z6Pu/UJUQcXMmzmMmd0oGoTcK1s2pKp66Q=
Received: from igel.home (ppp-88-217-55-80.dynamic.mnet-online.de [88.217.55.80])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 18 Mar 2014 21:01:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id BBFA62C1AC7; Tue, 18 Mar 2014 21:01:47 +0100 (CET)
X-Yow: Sometime in 1993 NANCY SINATRA will lead a BLOODLESS COUP on GUAM!!
In-Reply-To: <mvmy507stf1.fsf@hawking.suse.de> (Andreas Schwab's message of
	"Tue, 18 Mar 2014 11:16:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244378>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>
>>> This configuration variable sets the default for the --full-name option.
>>>
>>> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
>>> ---
>>
>> Would this change break Porcelains (e.g. Emacs modes) and force them
>> to be updated to explicitly pass --no-full-name to unbreak them?
>
> Yes, that would be required.  On the other hand, currently it is
> impossible to cut-n-paste a file name without --full-name, since the
> pager is always started in top-level.  Perhaps it is better to fix the
> latter?

On the third hand, git grep isn't plumbing, so variation of output is to
be expected?  We already have grep.lineNumber and grep.patternType /
grep.extendedRegexp (vc-git-grep uses -n itself, but does not protect
against grep.patternType).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
