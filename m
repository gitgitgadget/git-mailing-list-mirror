From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Fri, 25 Mar 2016 18:41:42 +0700
Message-ID: <CACsJy8AyMUn_AAF-DNGvjS8D+qdFLNuVBYvAjide6wA-ZnHJ5w@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
 <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
 <CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
 <CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
 <CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com>
 <CAPig+cS2qMZyUkf9Nekp+QaVkjc1oHXb4QF3wFDnBdF3WMU3iQ@mail.gmail.com>
 <CACsJy8Bs0WFJxGnVOBUnzipZYty-K4D9NkAQdODYqPUw2VAAiw@mail.gmail.com> <CABEEbiDRPsL6XJrnyFv43u26hXNbBVmMhbJeZmp+zjS+-jNZ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Zhang Lei <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 12:42:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajQ8A-0008Nn-Ee
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 12:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbcCYLmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 07:42:14 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33027 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbcCYLmN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 07:42:13 -0400
Received: by mail-lf0-f50.google.com with SMTP id o73so53707145lfe.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5N5nUfDX7HOK24TnVz8t+Ax57kQdzb1y0nq6lTcmJZQ=;
        b=tUGJXpTZmC4Bh7ypo9jdhOl3rBHc/WhTdH+eIiMx5kIHAcShCQvh+XPM4GkvWmy332
         dlvhOzQdSWv/NjNZ73sRUnDNDRy0ZKyJoIBpwtwCKrXRfqot3f7et4f2dNyHv13jSDrY
         HhjBzqp7ODBa4cxMihByRgGSsgwTz0CqVDdihzL+ly20guba/wypwrdqT4CiN1jA4vV5
         8NYhDJ6E92XOEqbsr1SQvN3rqlUzWlSMdtrn6k1EWE/XsEzLEvVfjXmejfaDk8QbISfl
         Y5sTKycQ2aLPTZSUY0hsBnuLD9cIZ7TqNRxgHLeuGddHYYYkaitm7W/o0YErqe0YRXxb
         pLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5N5nUfDX7HOK24TnVz8t+Ax57kQdzb1y0nq6lTcmJZQ=;
        b=H3H7eqkQVczcfpM8Tb0TT+VkCdlkKuIc6eT5APh7RxHr0E66G9pdHKEpSde+4ANuYf
         uCWaiWn3HLqwV02uKKjzsjk7SqehtosygG9b/h1aGE6Wwcpq0UfhY17/tr23iOHmH+R/
         +u62L77Am3xK9jRVpYvr1wLgSDiPwvLT2qZ2u9LlvTdaYPsyylm99ke5a+YAjG7EATub
         A2qRMzYM2X/zDMk1S18+JFjkNHqNUGxAV93xyJN8r2rh/xY1HxfsYKw6w+UuYsv4voZ2
         qcBsM1Khl/7N8yJlHL2J/xjtUFmkc5nqiSFdkOdnfPCufB6x5bE84IQ4uG8v12xFulm5
         J5Lg==
X-Gm-Message-State: AD7BkJJYN9wbbSy+vBt0YLGd6U5N+RrSZASxFp/aCnyv2MG06b/3ocK1Msfg5doIKb5apoLA0gLoCNtTujPVBA==
X-Received: by 10.25.212.213 with SMTP id l204mr5584231lfg.118.1458906132047;
 Fri, 25 Mar 2016 04:42:12 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 25 Mar 2016 04:41:42 -0700 (PDT)
In-Reply-To: <CABEEbiDRPsL6XJrnyFv43u26hXNbBVmMhbJeZmp+zjS+-jNZ=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289879>

On Fri, Mar 25, 2016 at 6:31 PM, Zhang Lei <zhanglei002@gmail.com> wrote:
> By the way, Duy, another unrelated question: why worktree name under
> .git/worktrees is being named
> after the working tree path basename? I think branch name is more
> reasonable since we don't allow checking out
> the same branch twice.

Because branch name is not always available (e.g. detached HEAD) and
checkout branch can be switched later on. And normally you'll get
branch name there anyway with "git worktree add something" because the
branch "something" is automatically created. I've been wondering if
it's worth supporting "git worktree -b abc ./" where we create
worktree "./abc" based on branch name too.
-- 
Duy
