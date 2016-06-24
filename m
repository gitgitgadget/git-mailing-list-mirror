Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FB42018A
	for <e@80x24.org>; Fri, 24 Jun 2016 18:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbcFXSWZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 14:22:25 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35035 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcFXSWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 14:22:23 -0400
Received: by mail-vk0-f42.google.com with SMTP id j2so161733580vkg.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 11:22:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xxGy5UU9vJs8sa03GECqvv3kApi0O0KwK4KloMs70G4=;
        b=JRzUeQ/8P3bSD9GYCsFr2yOHxl0Bz86gWPXxCDo/HdZ9FZ6ZFzKTcefTSMFe0NIfeH
         ON3akhxAtzzPpYs2Bp7SRXf+v1jB657c9nY7KtkWv1GBJBe7R3KNQ6NPkYM7WTagNB+I
         ZP2DazoDosRwuOZJLkp3otxmtxqLlR1sqsMUr/1pQHVG3QojwV21UvUV+nFlUtIEOt1e
         6sCnRW2yeQ0NRsa887LCLpiPZDShT2Y1HghVGYbcZKyUZucyzR+4JWDH4mb5SujYcWcp
         3E+Rc8ZJAdwbHr1Q4YDbQDffMfJ6OYNEQZgE5eEdjNfqPENgeIf3eOLxzm9H+QapdOmw
         hFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xxGy5UU9vJs8sa03GECqvv3kApi0O0KwK4KloMs70G4=;
        b=EVf1nEwSC3/mlccpKW6PQaH9ve2EySBzw57Brk5D/nhogAhR4VxaCzO6FdH+97X01z
         qx4L67gCXbAfzMc0jAQT3zwVzeAh7gL+8T+0LwKddn0efsgDNtU5sZSoXRB78HTyZsv2
         kXvSVzQDRtLvQxLssQarSvEZ2uHYV/Rxp7fwLyaSZuBrEU3MX5XHdj/VFJdGAaX3WJfF
         kT8CcoyaSjg7O+KRndqSPmrBYJKqzUd+ZvsMyySi5ADPm+ISY+B39wUNxWPDsb5HNvoN
         nwlSB7xtQCaOlIUx4d7HYuLRdKXAK3TJjEp1uyW6ZdthdFWSl4MSEDTJ4oZ85w+v+4lU
         IdNQ==
X-Gm-Message-State: ALyK8tJzkT+V693ko0zgxXB9APP3ezNuaWW/w2y2OjugSjShXkQM8gqaPjC8k+5MrX7EUPs9XbkKDW4ymlRJAQ==
X-Received: by 10.31.199.6 with SMTP id x6mr3393056vkf.17.1466792542677; Fri,
 24 Jun 2016 11:22:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.15.65 with HTTP; Fri, 24 Jun 2016 11:21:43 -0700 (PDT)
In-Reply-To: <xmqqh9ckjuon.fsf@gitster.mtv.corp.google.com>
References: <20160622230024.24034-1-emilyxxie@gmail.com> <xmqqmvmckebv.fsf@gitster.mtv.corp.google.com>
 <CAAin2AQR3yP7X=NLQ=9+0QGJZMCN7=xbpZ=H7r56RvvBfLJSEg@mail.gmail.com> <xmqqh9ckjuon.fsf@gitster.mtv.corp.google.com>
From:	Emily Xie <emilyxxie@gmail.com>
Date:	Fri, 24 Jun 2016 14:21:43 -0400
Message-ID: <CAAin2ASggO1ZUqT_nfokkYL40vSDSdPtAVq4H2Z9A7K633xq3Q@mail.gmail.com>
Subject: Re: [PATCH] pathspec: warn on empty strings as pathspec
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I suppose I got ahead of myself there. :-) Thanks for the
clarification on the process.

On Thu, Jun 23, 2016 at 2:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Emily Xie <emilyxxie@gmail.com> writes:
>
>> Awesome. Thanks, Junio---this is exciting!
>
> No, thank _you_.
>
>> As for step 2: do you have a good sense on the timing? Around how long
>> should I wait to submit the patch for it?
>
> Not so fast.  We'll wait for others to comment first.
>
> I am queuing this change but that does not mean anything more than
> that I am not outright rejecting the idea.
>
> It is possible that others may assess the cost of having to do the
> two-step migration differently, and the list concensus may end up
> being "if it hurts, don't pass an empty string", i.e. we'd better
> without this patch or subsequent second step.  If that happens, the
> first step dies without hitting 'next'.  I'd say we'd wait at least
> for a week.
>
> Otherwise, if the change is received favourably, we'll merge it to
> 'next', do the same waiting for comments.  Repeat the same and then
> merge to 'master'.  After it hits the next feature release (probably
> at around the end of August), the change will be seen by wider
> general public, and at that point we may see strong opposition from
> them with a good argument neither of us thought of why we shouldn't
> do this change, in which case we might have to revise the plan and
> scrap the whole thing.
>
> So, we'll wait and see.
>



-- 
Emily Xie
xie-emily.com
207.399.6370
