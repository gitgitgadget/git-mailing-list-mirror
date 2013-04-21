From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 21:02:12 +0200
Message-ID: <m2a9or907f.fsf@igel.home>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
	<m2fvyk8fb8.fsf@igel.home> <7vli8cuv5j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 21:02:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTzWv-00060s-RM
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 21:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab3DUTCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 15:02:25 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39221 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab3DUTCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 15:02:25 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Zv0fG66yBz4KKJg;
	Sun, 21 Apr 2013 21:02:14 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3Zv0fG5mJkzbc5t;
	Sun, 21 Apr 2013 21:02:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id DH1GGzI3DU7l; Sun, 21 Apr 2013 21:02:13 +0200 (CEST)
X-Auth-Info: K0g+owQ8Mhi/8zQWxlDWjZRvENVAM3Ca8e9EsMcYMmw=
Received: from igel.home (ppp-88-217-114-237.dynamic.mnet-online.de [88.217.114.237])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 21 Apr 2013 21:02:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C780BCA2B6; Sun, 21 Apr 2013 21:02:12 +0200 (CEST)
X-Yow: ..  I wonder if I ought to tell them about my PREVIOUS LIFE
 as a COMPLETE STRANGER?
In-Reply-To: <7vli8cuv5j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 21 Apr 2013 01:48:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221965>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> +				if [ -n "${ZSH_VERSION-}" ]; then
>>> +					u="%%"
>>> +				else
>>> +					u="%"
>>> +				fi
>>
>> aka u="%${ZSH_VERSION:+%}"
>
> Do you need/want a colon there?  Even if it is empty, as long as it
> is defined we would want this, no?

The original wouldn't.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
