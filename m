From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] preparatory patches for the submodule groups
Date: Tue, 3 May 2016 14:57:00 -0700
Message-ID: <CAGZ79kZK_EtwBps3hcYVkRat2XbpXXXdXkQDrB281rxkedjaGA@mail.gmail.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<xmqqwpnalwf8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kakayOhPkCK4hbRkj-h2Bt+PqD69EgHk-chbu4xCA8_pA@mail.gmail.com>
	<xmqqoa8mlutg.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbm5y+LeyA_dwQWKFNaa42280cOvwQYZTP=-aRnySsB1A@mail.gmail.com>
	<xmqqfutylte1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 23:57:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axiJY-0000ns-Jw
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbcECV5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:57:03 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34439 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbcECV5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:57:01 -0400
Received: by mail-io0-f175.google.com with SMTP id 190so36815093iow.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JG4Oc6qrKqI+c059SZOn8pCo6rPfiSly2Bj1llbrkq8=;
        b=KR/mcZxWwrmaIz8DxUxPAxKnNEEEokvsDsCV4GxrIjmsASAz97Lo9aEFI1OK0/KyPj
         0Esp48hxd5XNU453Isj/4YxkO9MYYkHo3Bbb0fnYxFESTZwtpi4ydiJIb+w+1Xv1ic5r
         2S2q43asLgqPoNCwywai2gwe4WMRMlrP9tb+20270TyPNnjWGixw9bsnVD7b19PR6u8w
         0grjYnHzVRVWy4aRmI0+AXFatCuGeueOjUUWozM8ZKWMtNw8J6tBVNhtEXwix8Gc//4L
         qfp/uB++RSYRRu8rSRs/DucHlYAQLUZN86rSGB8K4kOMOoaNepVlB9uRRO56G5x4ydRY
         GVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JG4Oc6qrKqI+c059SZOn8pCo6rPfiSly2Bj1llbrkq8=;
        b=g7wDyoc3WEVun/gmEntwwWthugcX3xtALsF/0VvXmOpONyncZK/NNpFyOUJEgDdPc6
         CrwRQnLfnywF1iJlGE7CWjC/SnHMyvCwMJzmyN2H8pdphO6Ia5Jm6xUsVLL7GaDgvT6Q
         lvENWnaCYHMVNc5lHx3bnngsbRCLA7kBnJsHi88HQPwglfqyHFgVQlYxg/xyFlGPniph
         eLL9vBpHm0I4zvt6pTvuZO8kdhRCbWImNCIpncmaoVJAbtEdQ9Sie+3OlQ+l5NoxPt38
         ofFXJ+v9NljeFYSGmuwJ2ZrrBaTlQdKBq4GOie+K07yxeGzN0i5pNIEtNS/X4J8XQO6a
         sCag==
X-Gm-Message-State: AOPr4FX7vTDMkkiQKO5kb8OC398qPAfxgSt0S8iQnyWfQ3vR5zDHbHZMcr7LeF9iMp76R8l+qp/Q7aSuYkjhR57u
X-Received: by 10.107.53.204 with SMTP id k73mr6102923ioo.174.1462312620796;
 Tue, 03 May 2016 14:57:00 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 14:57:00 -0700 (PDT)
In-Reply-To: <xmqqfutylte1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293463>

On Tue, May 3, 2016 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>> * I think we want to head for consistency, eventually.
>>>>    e.g. commands with no arguments such as tag, branch
>>>>    give a list of their respective domain.
>>>
>>> Isn't that a historical mistake we are regretting, though?  Only
>>> after many other operation modes were invented and "create X" proves
>>> not to be the only primary modes we had to invent "tag -l" and
>>> "branch -l".  Aren't we better off not having "no option means list"
>>> kind of default?
>>
>> listing is not destructive, and I really like to not type a single dash
>> for some commands.
>
> Actually, listing is destructive to the user's cognitive state.

Oh! I see.

>
> I wouldn't be surprised if many people wished that "git branch" did
> not list (and required "git branch -l" to list) to scroll everything
> they are looking away but instead showed what the current branch is.

Isn't that yet another more specialized mode of operation?

The difference being that showing the current branch is less lines of output
than showing all branches. (listing the branches could also be done similar
as `ls` lists files instead of `ls -1`)

>
>>>>    Subcommands do not give lists by default, e.g.
>>>>    `git stash clear`, `git remote prune`
>>>>    which are the moral equivalent to
>>>>    `git submodule deinit` just work as they were told, no --switch needed.
>>>
>>> I wouldn't say "git rm" should remove everything by extending that
>>> logic, but I can certainly buy if somebody argues "git submodule
>>> deinit" is not destructive enough to warrant extra safety.
>>
>> `git rm` is a command, not a subcommand though.
>
> Yes, it is a command, just like branch and tag you brought up.
>
> "git branch -d" is not a command, but a mode of operation.  If we
> did the "mode word" UI [*1*], it would have been a subcommand.  And
> I certainly would not say it should remove everything if there is no
> argument on the command line.

Right.

Another point of confusion is that the `submodule deinit` case
expects a path spec unlike all the other examples and path specs
have the notion for specifying "all of them" in different contexts, i.e.
'*' or '.' are valid "all path specs" in other programs.

We do not have a strong history for such "all of them" specifiers for
branches. (Well we could do a git branch -d refs/heads/* but these
are files actually, so we'd think of * as a natural character to do so)

There are no notions for "all of the stashes" (i.e.  `git stash clear`
would be weird if it expected a '*'.

I think '--all' is the right thing to do here then.

>
> I am not sure where you are going with that though anyway.

I am trying to asses the users expectations on when you expect
a "safety" feature and when to expect the operation to perform.

>
> I think the "safety" is about forcing user to be more explicit when
> triggering mass destruction, and I do not think it matters if that
> destruction is done by a first-class subcommand of "git", or
> subsubcommand.

Ok. I thought it mattered a bit as a subsubcommand is already more
explicit than a command. Compare `git stash clear` to the
fictional `git clear` command. I would expect a `git clear`
to not delete critical things without arguments. Maybe some minor things
or internal things like garbage collection.

`clear` sounding similar to `clean`, we could have a "submodule.requireForce"
similar to clean.requireForce which would change the behavior of
submodule deinit and defaults to the safe version. (I do not know the
history of clean.requireForce but that sounds like it is a safety measure
added once people complained about having no safety default.)

But this discussion strengthens my opinion that we should just have a switch
for deinit.

Thanks,
Stefan

>
>
> [References]
>
> *1* http://thread.gmane.org/gmane.comp.version-control.git/231376/focus=231478
