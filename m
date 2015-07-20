From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/5] mh: worktree-related doc fixes
Date: Mon, 20 Jul 2015 08:31:57 -0700
Message-ID: <55AD146D.3080509@alum.mit.edu>
References: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 17:32:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHD3d-0007Ts-5P
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 17:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbbGTPcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 11:32:32 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61055 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932484AbbGTPca (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 11:32:30 -0400
X-AuditID: 1207440f-f79df6d000007c0f-fb-55ad14899ec7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F8.AF.31759.9841DA55; Mon, 20 Jul 2015 11:32:25 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6KFWNP5007754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 20 Jul 2015 11:32:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqNspsjbU4N9sXouuK91MFg29V5gt
	uqe8ZbQ486aR0YHFY+esu+weFy8peyx+4OXxeZNcAEsUt01SYklZcGZ6nr5dAnfG2ZZ7bAU3
	WCtmHz3M1sB4nKWLkYNDQsBEYtEazS5GTiBTTOLCvfVsXYxcHEIClxkl3u+awwThbGKSmNF2
	iB2kildAW+LSjAeMIDaLgKrEqrU7weJsAroSi3qamUCGigoESbx+mQtRLihxcuYTFhBbRMBB
	Yu2RnWwgNrOAm8ThjuVgtrCAlcTvE81gI4WA4n8Pv2MFsTkF3CUOnjnAClGvLvFn3iVmCFte
	onnrbOYJjAKzkKyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNK
	NzFCQpl/B2PXeplDjAIcjEo8vAJ/V4cKsSaWFVfmHmKU5GBSEuV9wrc2VIgvKT+lMiOxOCO+
	qDQntfgQowQHs5IIr8zHNaFCvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkO
	DiUJXnFhoKGCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoDiNLwZGKkiKB2ivDkg7
	b3FBYi5QFKL1FKMux4Ift9cyCbHk5eelSonz6oEUCYAUZZTmwa2AJa5XjOJAHwvzhoBU8QCT
	HtykV0BLmICW3JoF8lxxSSJCSqqBUXorf28/6xsJweQpuZaqP22Pr2XlvZ/hdqpMYJFM8u3E
	XaylPXrP4k8Wb5xn3OD3vPIk04UOpr0nb6mlal5Mv7tUNVz51f4Gqf2n+lfXVl07 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274325>

On 07/19/2015 10:29 PM, Eric Sunshine wrote:
> This re-roll of Michael Haggerty's worktree-related documentation
> tweaks[1] takes my review comments into account and adds one new patch.

Eric,

Thanks for separating the wheat from the chaff. I'm still traveling,
which I'll claim as an excuse for my poor responsiveness.

All of your changes look good.

I was wondering one thing: is there a value like "never" or "false" to
which "gc.worktreepruneexpire" can be set to turn off pruning entirely?
If so, it might be nice to mention it in the config manpage. Similarly
for the other expiration grace time settings.

But it's definitely not a blocker.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
