From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 20:16:42 +0530
Message-ID: <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-5-git-send-email-artagnon@gmail.com> <7vmws2529j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 16:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaobb-0006Lb-Ur
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476Ab3EJOr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:47:26 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:51051 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371Ab3EJOrX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:47:23 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so8182219iec.36
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ogxD+mex6iijjAf/t4jZRJUAzIbGMxq6YwFRXRz65J8=;
        b=l0WqyKb4LJrRikY3fXaDbfF9HpnmrnP4ntrMOInMlY8xMJ901oZP9yVsprMJlslvHy
         0r3uodY32TfoXJPno24ZQ4K0m0pCrb7Is2HcRPL8XM/ZG11hwhWzWDAKlFxOOHLk6MNS
         W8qclrzZLgTdFCsTlI3rJD5oyeQG5c2DmZeTeYJztyyYS1rde724Av1+3aM75EhU7RJ/
         b2UM14mKnzn+PjmELRHaQ2T6/nYf6p0+sjyQIg3ht8b4bPPJFQNE0mcd9ea6uN/lAIFO
         M/MRtqo5MeDPrMi2RbmbEJmNzCDE0py6RQMTeXXIXA9lon7qhogozQMcvMg9smfd5Qn2
         +MZQ==
X-Received: by 10.50.73.65 with SMTP id j1mr2265706igv.49.1368197242889; Fri,
 10 May 2013 07:47:22 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 07:46:42 -0700 (PDT)
In-Reply-To: <7vmws2529j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223858>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> A couple of tests execute 'git rebase' with GIT_TRACE set to 1, but
>> this trace output is not used anywhere.
>
> Isn't it shown in "t4300-*.sh -v" output to help the debugger?

Um, but why the GIT_TRACE in just these two places?  Can't I set
GIT_TRACE=1 when executing the shell script if I really wanted that?
