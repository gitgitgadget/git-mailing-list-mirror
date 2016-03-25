From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Fri, 25 Mar 2016 09:02:11 -0400
Message-ID: <CANoM8SXF2=+tObJaSAziGa_9W2CcwLMTW_mWoueq7Chm-yRqqw@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
 <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
 <CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
 <CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
 <CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com>
 <CAPig+cS2qMZyUkf9Nekp+QaVkjc1oHXb4QF3wFDnBdF3WMU3iQ@mail.gmail.com>
 <CACsJy8Bs0WFJxGnVOBUnzipZYty-K4D9NkAQdODYqPUw2VAAiw@mail.gmail.com>
 <CABEEbiDRPsL6XJrnyFv43u26hXNbBVmMhbJeZmp+zjS+-jNZ=w@mail.gmail.com> <CACsJy8AyMUn_AAF-DNGvjS8D+qdFLNuVBYvAjide6wA-ZnHJ5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Zhang Lei <zhanglei002@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 14:02:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajRNt-0000bR-LN
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 14:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbcCYNCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 09:02:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36143 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcCYNCb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 09:02:31 -0400
Received: by mail-oi0-f66.google.com with SMTP id k128so112536oig.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZCcb9BNslDL/UCbxee2nJHV5aBxCLgvyyEQzIAudHec=;
        b=fE6M08F/lRcqVdH97bo00F/xZk8aDjdfLCbZrN8pNiAoyceJkzMjIcvNKL6WhzXVeK
         8strRJX+m8yD0Zy2GBTjwV3KuZwImMFjAVyLYq6DE9mvwzT0I01GIFrzrYEL0QRjwKgK
         aiqlqf7bJEhSW5/QojpLt6n1JiOwql8ZKhsOEEZP7RNSc3MkwaG2z5sfx+1KmzmTqB7T
         i6XDHGPICNFFOKOdfsiz5FLdjDur6+W5iLoj401892YBZenhUqxxY5XHgSBcYP9BMY4O
         w+UenJ6LnTXoFKR6DbAtWNzs9Qyx/cok5iSCwtmWZJaT17nBHPmTtT4Rk/2yUEf7ToiK
         /8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZCcb9BNslDL/UCbxee2nJHV5aBxCLgvyyEQzIAudHec=;
        b=ABFvZX+mkLgil7UEmAysO7CJoktR3p5SXGsodx9rXod/44q79NFNl68gw+UydS5INK
         7B3kkRplwqzEE5vs968PSsBmsPHu4JzpLhA4OuOqc6WFFgul0qMrhDauxIVvmvaPX3ca
         R8YRKBc9rc4ZjLY/WeJLFD4xcONbtvCLm4M0xwKYxcODEU0Y28isgn1nIgOUODTTryvf
         ER24s5IhzZXA2bZc6hR67QB2n6Eh3o3UztWNJSYmUKgVC+cQvKPAvU1PKfJK9/QD245i
         PidTbz9QCOApuZ6Tw8cHMjZDLCDTGySbkvZFUzHXS4CaYpAvXBI+O5dMLITPadlEDf8I
         rOcw==
X-Gm-Message-State: AD7BkJJ1iJRwr0lpx/wfYe0ZWJHxpUPnw+Vn6PzWjUN47wzGvrKoS/hb6Q8nL0htMmeKlRIXQEfaEFDNiH8fTA==
X-Received: by 10.202.206.205 with SMTP id e196mr6481888oig.88.1458910950753;
 Fri, 25 Mar 2016 06:02:30 -0700 (PDT)
Received: by 10.76.87.163 with HTTP; Fri, 25 Mar 2016 06:02:11 -0700 (PDT)
In-Reply-To: <CACsJy8AyMUn_AAF-DNGvjS8D+qdFLNuVBYvAjide6wA-ZnHJ5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289886>

On Fri, Mar 25, 2016 at 7:41 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Mar 25, 2016 at 6:31 PM, Zhang Lei <zhanglei002@gmail.com> wrote:
>> By the way, Duy, another unrelated question: why worktree name under
>> .git/worktrees is being named
>> after the working tree path basename? I think branch name is more
>> reasonable since we don't allow checking out
>> the same branch twice.
>
> Because branch name is not always available (e.g. detached HEAD) and
> checkout branch can be switched later on. And normally you'll get
> branch name there anyway with "git worktree add something" because the
> branch "something" is automatically created. I've been wondering if
> it's worth supporting "git worktree -b abc ./" where we create
> worktree "./abc" based on branch name too.

You can switch to any other branch in a worktree.  Consider that you
could switch branches in
worktrees such that you could eventually end up having the branches
swapped from original
worktree setup.
