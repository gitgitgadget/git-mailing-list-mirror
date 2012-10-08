From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] t/t5400-send-pack: Use POSIX options to cp for portability
Date: Mon, 8 Oct 2012 21:05:05 +0100
Message-ID: <CAP30j147c47y=cWVQNCtOdjp4mqV0kjhrSr7ZEfwDCyfQWthcw@mail.gmail.com>
References: <1349683681-18978-1-git-send-email-bdwalton@gmail.com>
	<7vlifgncq8.fsf@alter.siamese.dyndns.org>
	<7vd30snbtk.fsf@alter.siamese.dyndns.org>
	<7vvcekluwi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 22:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLJZm-0007Ff-62
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 22:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab2JHUFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 16:05:08 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43905 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab2JHUFG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 16:05:06 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so4133050wib.1
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 13:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3NM+Lq7ibf1bDvUg2/SZJJ+JlzKnzUm1B5qa/lmngkM=;
        b=Q8mjpkobwUt9BiTh3Th14XQ6K1EWrvnNWVskbSEuMEQj8UPTJklo23BbNKuSyKAE1H
         6M72XpzxC08VaYRd4mcCqPZMtTJ8PKmcN+J3z2ROEXeWOAB/1HpsjFB1RIvB3PJhkBnd
         PyeebXoEVknOeCgUEvAzyaQwNH6rRc3YpKdhCUQ+lXempYKuiBtn/7H6Nx991FtkrqOD
         eVEy/BsrA165MX+yrfqEpBNrHuxQYKnBNMSHvmNXulVOZ1/FeHhZEBM6BVtxqNTQtEJQ
         w2r8btnrVK4K5xprwc9YtFtnMXey+f28QhVoB5MopbRDOaQF9fcJUMRYupMwnwqp5Pvq
         fQDQ==
Received: by 10.180.87.34 with SMTP id u2mr24417364wiz.4.1349726705138; Mon,
 08 Oct 2012 13:05:05 -0700 (PDT)
Received: by 10.216.231.92 with HTTP; Mon, 8 Oct 2012 13:05:05 -0700 (PDT)
In-Reply-To: <7vvcekluwi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207265>

On Mon, Oct 8, 2012 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Thanks, but is "-p" essential for this test to pass, or can we get
>>> away with just "-R"?
>>
>> Besides, when you spot a potential problem, please ask "git grep"
>> to catch them all.
>
> In other words, how about doing this instead?

This works.  I was responding to a failing test so I didn't look for
other instances.  Clearly I should have...I must not be exercising
those other tests.

Acked-By: Ben Walton <bdwalton@gmail.com>

Thanks
-Ben
-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
