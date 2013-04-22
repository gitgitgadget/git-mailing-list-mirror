From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 21:24:35 +0530
Message-ID: <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUJ5O-0006ya-O9
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab3DVPzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:55:16 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:38508 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab3DVPzP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:55:15 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so5420871iay.29
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=z4U6q/UqAtk+Si4HzIqR66AUi7tE5vCMuh5rEswYUTU=;
        b=xP//67Zw0UNq16g/Mu9rNLSDqNWDReFbjSbB5WskASPErzdCNpiMtMm8h0rFnGDNFT
         oW1or+ZgFUWXo0jHwckOqFEt536mjgksFMWWl+jho34Uc2KHtV1KlMQ3c6GXMs7uWFSv
         9lC5Tp0jvHLA0u5xfwoukKLThDVfF2AhG0w+6U2BcHnHOuJrYXZbS7CjHAMzhfLetcC7
         5uLjW0/9Qh337CqvFgZIZSNzCREZPZqajxD14jsCHg0BI6ZmpoYTMQPi5ZdJ7/GDm9Qy
         XRd2B6FhjiO/yLtSw2njTDxpMSmOsFciULM0g4nRz1tI+zD/SymNGQA6XGZ4ZPiPHrDs
         vMWQ==
X-Received: by 10.50.50.71 with SMTP id a7mr21609611igo.14.1366646115321; Mon,
 22 Apr 2013 08:55:15 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 08:54:35 -0700 (PDT)
In-Reply-To: <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222032>

Ramkumar Ramachandra wrote:
> For the 100th time, nothing has been "copied".  There is no need to
> spend time on any analysis.  It's a very straightforward problem that
> requires no computation or heuristics: it just requires you to strip
> the leading "subproject/" when looking for pathspecs in the M^2
> commit^{tree}s.  Done.

And if you're still not convinced, run 'git log HEAD^2 -- README.md'
from the toplevel directory.  You'll get the log of README.md from the
subproject.
