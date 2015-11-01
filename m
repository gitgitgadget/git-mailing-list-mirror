From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v7] checkout: add --progress option
Date: Sun, 1 Nov 2015 15:16:41 -0600
Message-ID: <CAOc6etaC+W+qUg8VJOvCGcx2iJxw+DfzPuqxAdrTdBbs+monOw@mail.gmail.com>
References: <1446412364-19377-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cQZN_1f1wDwm7esHBhhrnQSx0eMye38Wc2ZxOjWoqjJvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 22:16:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zszza-0000CT-Hf
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 22:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbbKAVQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 16:16:43 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34494 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbbKAVQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 16:16:42 -0500
Received: by padec8 with SMTP id ec8so17012502pad.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cdr/q0FPZ90W43CUlyVF+6uzSNA6qyL5z8qVarGa+mk=;
        b=oxp+bAWqcjaWMskxWlK3V3ZZehmnPc+sUrhIR/iD1y1svYor+VyiW0kr+CxmwHBak2
         4Ni8fwPP7uc/2Por1NVFjUgKXm2XkBHTwqjylGe5MiJhftVSGiEcwjGWLqO4Okbq3dON
         ygBLSl13p4U1f3itiAdZkPgwxoqWRrEVSGqwI6Y6Ne1WfDkKUxHojzesL4SC35SZ9C+3
         OkUZdu/qogjAHrBLWapTzCbEu+wNphyp3pfrYHkoFKXGicBkShERKaKfYT7UAzmL0fQF
         lGUxlroQjrqExEeGhi2tidyoq4dHhLeL9LQZkgYzHzKQTNr4gEwAzThdQj7tahl2Joen
         QDCg==
X-Received: by 10.67.14.42 with SMTP id fd10mr23158849pad.11.1446412602152;
 Sun, 01 Nov 2015 13:16:42 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Sun, 1 Nov 2015 13:16:41 -0800 (PST)
In-Reply-To: <CAPig+cQZN_1f1wDwm7esHBhhrnQSx0eMye38Wc2ZxOjWoqjJvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280673>

On Sun, Nov 1, 2015 at 3:15 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +--[no-]progress::
>> +       Progress status is reported on the standard error stream
>> +       by default when it is attached to a terminal, unless `--quiet`
>> +       is specified. This flag enables progress reporting even if not
>> +       attached to a terminal, regardless of `--quite`.
>
> s/quite/quiet/

hahaha. So close!!! v8 on the pipeline.
