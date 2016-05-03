From: Stefan Beller <sbeller@google.com>
Subject: Re: remotes
Date: Tue, 3 May 2016 16:47:47 -0700
Message-ID: <CAGZ79kat4rW7raoXQNF2mb0nS5qF0e7yTCoSkiFe2VFJ=E_VdA@mail.gmail.com>
References: <20160503181624.1504eb0a@laborpc>
	<xmqqshxylvwh.fsf@gitster.mtv.corp.google.com>
	<20160504013624.4c51ce42@wind.levalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kovacs Levente <leventelist@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:48:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axk2n-0006Cr-Aw
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 01:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833AbcECXrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 19:47:49 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38469 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbcECXrs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 19:47:48 -0400
Received: by mail-ig0-f176.google.com with SMTP id m9so34396870ige.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Ju096hWv6nJfDxKD+KqgnIsHl4WWJJQGrg9dDZ1uyE4=;
        b=IB5MX5YoYYJ4R/0MhiAkphAFBpoa6QXGXK6eIDqds4yUqgiTvukuR2jz7Q81sMwEVx
         JsJ3KfrxPFuxCSvgbfINdVsXPkrKH4QVjmxVRLmhY3EDEBsAfdLItpaVKtRPI7rYsLHf
         TdGyp1+4TlBlyo7HNvvyn9ZOg5jhYEd3LfM9x5zO4k+w0Nk0VHGqRbcjYg9Wlnya7WCf
         FBK5c3mt2foZUQ+P/KJQWre41huepLCQ1tammnU3s6IoKVAEBAunxisWwTPDwmxy1bsv
         dsNJUjKu7tqd/45A8NzTfBwkW9Ax+MeMtYyU251cVn+yI8Yrr9nRuXATJdUET6cZry4O
         3rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ju096hWv6nJfDxKD+KqgnIsHl4WWJJQGrg9dDZ1uyE4=;
        b=Uynb9M9NFpE2M8yIz96aPQ4BOrNVXunzgZhnzXD44n6OyidfyLGoyBEOA9WrldAopF
         EWzH/nbcKqWz/JzY6A0Mg842wFfXQ/84nzv+XLPxOPlmq2QBmpqAVe6sFXS8PgrGzqGE
         lJUcWOcUc56y3R8BDXbh7RwvL/k22sOupUKEPpvftA3RpcBtJWHan31649G5eF4JM4F8
         MfRAZdZzFAx+JYtRJPLPqFmb4SeZZ01tiDijm4bd7AA2KUUEiWKGkzfcMiaIPq8gHDoo
         ZTQ7Z5N14WvsGGAW2KW46XF8+xqVilFCV614D4XT9QtdV8UBNIiaMaLijll52JRS8L21
         6kGQ==
X-Gm-Message-State: AOPr4FUtRFY1d3z2WiimDtzCOfMjMNktZUOXxsQKTiRc19IzE/OpMa97wBwFnWCuGe+mheZ0e5xd+/exkxJ4T9PL
X-Received: by 10.50.98.195 with SMTP id ek3mr30852098igb.85.1462319267568;
 Tue, 03 May 2016 16:47:47 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 16:47:47 -0700 (PDT)
In-Reply-To: <20160504013624.4c51ce42@wind.levalinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293480>

On Tue, May 3, 2016 at 4:36 PM, Kovacs Levente <leventelist@gmail.com> wrote:
> On Tue, 03 May 2016 13:38:22 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Lev <leventelist@gmail.com> writes:
>>
>> > I accidentally added a remote of another repository to my config
>> > file. And so I merged two different repositories together. Is there
>> > any real user case for this?
>>
>> Using multiple remotes is a perfectly normal way in which you are
>> expected to interact with a single project with other participants.
>> Perhaps there is one single authoritative and canonical repository
>> where everybody initially clones from, and it is likely that that
>> repository is your "origin".  Often there are cases where another
>> participant has a topic that is not yet ready for the mainline but
>> is worth considering for early adopters and/or is solid enough for
>> other project participants to build their work on.  In such cases,
>> you can add the repository of that other participant as the second
>> remote and fetch from her.
>
> Yes, I use that feature.
>
>> It makes no sense if the two repositories hold histories of totally
>> unrelated projects, of course.
>
> Would it make sense to implement some protection against these kind of
> accidents? At least a question "are you sure you want to merge two
> independent repositories/branches?"

A recent addition is the check for unrelated histories via checking for added
root commits (i.e. commits with no parent) and refusing to merge them
by default.
you need to pass --allow-unrelated-histories to merge.

see
https://kernel.googlesource.com/pub/scm/git/git/+/e379fdf34fee96cd205be83ff4e71699bdc32b18

>
> Thanks,
> Lev
>
>
> --
> 73 de HA5OGL
> Op.: Levente
