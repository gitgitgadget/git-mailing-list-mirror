From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 04:18:06 +0530
Message-ID: <CAFZEwPMYSGe0k0eAZCQFtBOHw2yZp0w+HL6iN9YPDX5EvJcg-w@mail.gmail.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atNOP-0000VB-5S
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 00:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbcDUWsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 18:48:08 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36130 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbcDUWsH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 18:48:07 -0400
Received: by mail-yw0-f196.google.com with SMTP id u62so12168310ywe.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 15:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=fvtxnkaBZ0UaW1rm3yNz/DIyE8Ww2iqCNxxlyIYzga8=;
        b=J5BzIGiSHZ0SfUGzMWVpMFLJTqYl4gpJcuHO7dsgfqJDwk2waIS8WTVPKvjJ8+1/he
         OksbDlMuJciYu1t4CZEDc0CfMx9LQSydFAMF/ocN7NH/xMFcg1kquxh+Q1Yxt8Oo/X5D
         aFZsuGwafrQf45XMZ4xgbGyPNvKdA/LeWBROw6HwlvXFuYWSX2TUFcnxhlkJ6MFlhVDo
         iE6JiokV9vCexo8y+YBSjkkAluL9mijJk0lG7VPG9+xSMgq2ACePJmROgPNrkAsqMqaY
         /JiA6aoZiiuTnClPhVBUW12nZVXdvEy63/dp+QDTMo+35+VhlnzX8ig/IT2Xzq+oo+0L
         ozRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fvtxnkaBZ0UaW1rm3yNz/DIyE8Ww2iqCNxxlyIYzga8=;
        b=ivwHG/8YGHmKmKxyf2nufskaiAKCjOBb3ojbk65qyOWmcJ4TAyFLdVNzGjk2Om5ykU
         Z/zpkwLFMuzExOj7V6iE6YcHkYpwxwjkJ54pO5j1F4DvoEAPYM6pjbR4IgANqFFuxKbK
         S0oykcYzDEk3e2lUuS5nqf1CKetIIF935GyydT8Co0MhA39RAPNzzpiNP+N///3ejVAq
         kvLEW5NOkFcyczUtqJHEP0yza6xMl5gk+w7PpjjC4vLYSMJg9BEIXjBsghvb6cUl3L12
         D+IYIGFBiRuoPEdHnOYbC3vdxznVNnTxbAdg/wrUAW3XS+laHI+BnNQJAKpBa2gn6mI3
         jm5A==
X-Gm-Message-State: AOPr4FUoLNHoAD8wqt46j7VXBSRzw3UP/F99Ekswj6sq+sCuG3NqCYa6KoazBxNGbqMuOfC/x9avx0u4UfmmGg==
X-Received: by 10.37.208.199 with SMTP id h190mr10643968ybg.154.1461278886101;
 Thu, 21 Apr 2016 15:48:06 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 21 Apr 2016 15:48:06 -0700 (PDT)
In-Reply-To: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292160>

On Fri, Apr 22, 2016 at 3:50 AM, Junio C Hamano <gitster@pobox.com> wrote:

> [Cooking]
>
> * pb/commit-verbose-config (2016-04-19) 6 commits
>  - commit: add a commit.verbose config variable
>  - t7507-commit-verbose: improve test coverage by testing number of diffs
>  - parse-options.c: make OPTION_COUNTUP respect "unspecified" values
>  - t0040-parse-options: improve test coverage
>  - test-parse-options: print quiet as integer
>  - t0040-test-parse-options.sh: fix style issues
>
>  "git commit" learned to pay attention to "commit.verbose"
>  configuration variable and act as if "--verbose" option was
>  given from the command line.
>
>  Is this going to be rerolled?
>  ($gmane/291382)

The changes weren't that big enough and I had my end semester exams
coming so I decided not to re-roll it.
If you think contrary, I can do a re-roll with the changes suggested
by Eric Sunshine.

Regards,
Pranit Bauva
