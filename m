From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Fri, 04 Sep 2015 18:24:34 -0700
Message-ID: <xmqq1tedejzh.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<xmqqd1xxekt8.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwcv+iXnUtMhZrtx9hFrJ_xjfxvoinLmKTyEfLwrDoJvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 03:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY2Dg-0001yn-FH
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 03:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759277AbbIEBYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 21:24:37 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35345 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbbIEBYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 21:24:36 -0400
Received: by pacfv12 with SMTP id fv12so39929813pac.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5yKjxKZPvTZCakuKKJrLCFzbyuikXcUulrzvbQSvUKs=;
        b=ab0T+wjw32YK/UAt3bYNDMO1HjaLM+/OGVqYVO98gborIsR8/JohYfgki5Kieyvdkt
         qsUxz4VjFTUr60eVACxKT0lRDPszqy47NlxThV1u6QTfmVIfMP85tEcjK6yla/O5LYud
         6KJlIwKfKA3JAXDDoLvfJqzfjA32L+XIJB7ykwIgHgCGX+SQkPNrTNPqHXvOcHj5fKEc
         iPYi7pVswIYB6MgdRuWVvI/49oS2aigMwG3USygpKRQLPYIw7LLa4kuALqqMszOefClG
         tkBUJJcPGAne5NSFGq3uPfx3nINuWy+rAy/BvBqoIvips/+1XBWGuFTZHYnmGk9Gw/0l
         cDlQ==
X-Received: by 10.66.161.137 with SMTP id xs9mr14954689pab.117.1441416275618;
        Fri, 04 Sep 2015 18:24:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id wj8sm3921197pab.3.2015.09.04.18.24.34
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 18:24:35 -0700 (PDT)
In-Reply-To: <CA+55aFwcv+iXnUtMhZrtx9hFrJ_xjfxvoinLmKTyEfLwrDoJvQ@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 4 Sep 2015 18:20:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277358>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Sep 4, 2015 at 6:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> that rule would still not think this is a signature block, but at
>> that point, do we really want to consider such a block of text a
>> signature block?
>
> So exactly why are you arguing for these rules that are known to break
> in real life, that I gave actual examples for existing,...

Our mails crossed.  I was working from the [akpm] comment at the
very beginning while you were giving more examples that inserts
comments in the middle which I didn't see.
