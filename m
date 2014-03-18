From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Add grep.fullName config variable
Date: Tue, 18 Mar 2014 11:16:50 +0100
Message-ID: <mvmy507stf1.fsf@hawking.suse.de>
References: <874n2w3abu.fsf@igel.home>
	<xmqq7g7sbh56.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 11:17:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPr4w-0007pF-AV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 11:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbaCRKQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 06:16:57 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39586 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbaCRKQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 06:16:56 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fp9KL5hq1z4KK6C;
	Tue, 18 Mar 2014 11:16:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fp9KL0QQdzbbgs;
	Tue, 18 Mar 2014 11:16:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id QTQttszulLy8; Tue, 18 Mar 2014 11:16:51 +0100 (CET)
X-Auth-Info: an+tAFzj/hzFOEuNgsygHbdkEncexyRSC6ZNIJx9Gfk=
Received: from hawking.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 18 Mar 2014 11:16:50 +0100 (CET)
X-Yow: WHY are we missing KOJAK?
In-Reply-To: <xmqq7g7sbh56.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 17 Mar 2014 15:21:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244348>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> This configuration variable sets the default for the --full-name option.
>>
>> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
>> ---
>
> Would this change break Porcelains (e.g. Emacs modes) and force them
> to be updated to explicitly pass --no-full-name to unbreak them?

Yes, that would be required.  On the other hand, currently it is
impossible to cut-n-paste a file name without --full-name, since the
pager is always started in top-level.  Perhaps it is better to fix the
latter?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
