From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 16:41:45 +0700
Message-ID: <CACsJy8AySJdgntW3hv+J9zuGMAKV5H4suLJp2jy_xRuGY=6evQ@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
 <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com> <vpqh9h7f9kz.fsf@anie.imag.fr>
 <CACsJy8D-bHOLGKq0ZELcPYWpKXgct3HBF9Btp3UPw+tqGUR5Bw@mail.gmail.com> <vpq60xl88zk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 19 10:42:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhaL-0006BU-08
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423150AbcBSJmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 04:42:19 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35017 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161050AbcBSJmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 04:42:16 -0500
Received: by mail-lf0-f42.google.com with SMTP id l143so50152968lfe.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 01:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sakiIHxEpCdgv2KVBGPpCJ55g6HjrWC0osb9L2Mr0Bo=;
        b=ICi/zuUrb752VOcvaIfsLrv9Cdv4iJO+tZ3rBUFzd2lNU+AiaWt82s2rTDnl7IcHpj
         Eu81L5xLsy6ifyoJp4bU9+nI8WtTRoC2w4IMSL5+cdzUH2z6WWwz1zN7YgrSCB8bHDgK
         f/2EGFs4brL6VzgXM251U0G/5yHOvnwPO4LddwjYLIv+d/oc9mTEFonOl4s7AhnSAsTQ
         3i8UhmJnjYld990WP7Udmchn31oQ7rEdVb6MJbDqPg7rgL5m4sqZvLXU5Brh9CsxnRKi
         xlZG7Lo0U2R5w3uV4JApclQSDBk/dgmyUBdk5Gq+Q+X+9KpO1cTyIX3XtwKGtACz82o5
         5WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=sakiIHxEpCdgv2KVBGPpCJ55g6HjrWC0osb9L2Mr0Bo=;
        b=mMvnbhk1DmO6qqL/77hhADqlJzU8B5K+zm+1vBj9oL/KnDD79Jbu83eNv5DIK7Ee9H
         a7h6dmvpxDA0McgWCu+DENIQxuv5SJVHcubRQWHAi+G9ASuZH4MstrdR70OGf2uH7veK
         aFjZHqz5c0Vy8SkQJBHp/8UC5J3e15kbSWQrFQRdJ8sWwaqU3pdLjL8tcn82UVnpvBQS
         BmcSeRUcpwu2sDRR+OJkjwsKUOuOaUHYJlsTvngPcAKFoAu6GX19J9k085xVQ86y9Yq8
         P6lW2P+XLmMh4PKe3sMYRNXGnJZWlrToJMSPFZty8/lRL6O0XIZ+xCVNaLuDHhC57h81
         qKsw==
X-Gm-Message-State: AG10YOTRj/NFoplBgXwSYcZsiC4/Lf22a2dmwteqqCUlpgxVit+kmQBKRfSPPjU5OVVbdYTY5sd/XhbzGFN8+Q==
X-Received: by 10.25.212.197 with SMTP id l188mr4997833lfg.118.1455874935250;
 Fri, 19 Feb 2016 01:42:15 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 19 Feb 2016 01:41:45 -0800 (PST)
In-Reply-To: <vpq60xl88zk.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286679>

On Fri, Feb 19, 2016 at 2:17 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> with David's multiple ref backend work, we could have a third,
>> no-dependency backend. We can use index format to store refs.
>
> This sounds like an interesting but ambitious project for a GSoC. There
> are a lot of new stuff to understand for someone potentially new to
> Git's codebase. And it's hard to work incrementally: the result would
> hardly be mergeable before being almost finished.

On the other hand, the actual amount of code they write is roughly
about 1700 lines of refs/lmdb-backend.c. Which I guess can be written
in a month once you know what's going on, basically how refs are
handled (I think documents have been greatly improved), git object
manipulation and optionally index manipulation  (if we store in index
instead of trees). I think it's manageable. But then I haven't
interacted with students for a looong time.

> I think it's interesting to offer the idea, but there should be a
> warning for the student about the difficulties.

Yep.

> Would you be willing to (co-)mentor?

I can't guarantee I will not disappear for a couple months again like
last year. It depends on $DAY_JOB. So maybe co-mentor position, but my
other co-mentor should be ready for that situation.
-- 
Duy
