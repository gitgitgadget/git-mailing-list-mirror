Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D351FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbdBNVqM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:46:12 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:38359 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbdBNVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:46:11 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so50719919itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HYGiqFc38lS2V/YG++e+VYwgl19DC1m6RDRLgSWTTKk=;
        b=fF7JBb6NbTB8YZ/Lv4dA0fgMLOm7oMqiH0VuXCKOBZ6SFf46RoG41xFx2JSKqLG0ny
         dYr/QrImjIACPHX7RrY0CtIHU/pXxXDHG+F0Dn36Zf0ZaAB83uOQ7av7FUsuay3kihH+
         Frf9XHAfkoFlq0AFTHcETTo1waOhZni4PYQOJCiSBOHaoc07yAKOwio94xEqU2pdrinx
         3z54OobYUWG0rj+ItNtL1EKZh8TmapQyZAsXeaHzHVHFhIIbeMcvZpmXddMkV9CDrRrZ
         QqMFJiFPnbDuJ36xDcFPSZaPoLDrp38m0aulCW7OaWQHqvK+0wU9g4PAe9SrtvZPrWjl
         qXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HYGiqFc38lS2V/YG++e+VYwgl19DC1m6RDRLgSWTTKk=;
        b=C4Ax2by2dJFrHuyKo2HwqcsirHycFPPpi0WiSYGC80blmF57qhvaiJWYUl0uxtSXMX
         Lv+gsrQFNSpb6vkw5y6pTyjnfNaoMUIZ4t035oiGp8AoxEzY1RJHNZlNgv8UxFZ6kHbp
         tU4GliknULtfXKDJ5hRpJkdrel4+4H5GBFYrdDyYI4BpHIS5F7n3h/m6cyMUrQtob28F
         Hs4HijIve71XWRyRbATe174Y6sjZ8lqCJaTFJdsYgVAJAE3mG4T0gXLjC5v5LjTRCLHV
         YbEwxjV1WGXxWzgsetRnYh6Ik+KqhnbyCsWE9oRYlTAw+ixCXPX2JevmTQKqHx33uU3b
         NVmQ==
X-Gm-Message-State: AMke39n2KGAjpOh3zR8XoS9EeCbmqvfEek0QYs8QChL92Kh+804qCMezjj5HOq5EIvv216DIHXWO0rGX9GfLnVw9
X-Received: by 10.107.37.148 with SMTP id l142mr27317048iol.159.1487108769654;
 Tue, 14 Feb 2017 13:46:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 14 Feb 2017 13:46:09 -0800 (PST)
In-Reply-To: <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
References: <20170209020855.23486-1-sbeller@google.com> <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Feb 2017 13:46:09 -0800
Message-ID: <CAGZ79kb2jZ9fgct6gncDqmWFsbY4MRiboFXPvw7AMcU2KanyfQ@mail.gmail.com>
Subject: Re: [RFC-PATCHv2] submodules: add a background story
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for dropping the ball here, I was stressed out a bit.

On Thu, Feb 9, 2017 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>   Do we need
>>
>>   * an opinionated way to check for a specific state of a submodule
>>   * (submodule helper to be plumbing?)
>>   * expose the design mistake of having the (name->path) mapping inside the
>>     working tree, i.e. never remove a name from the submodule config even when
>>     the submodule doesn't exist any more.
>
> I am not sure about the last item.
>
> Are you talking about a case where submodule comes and goes (think:
> "git checkout v1.0" that would make submodules added since that
> version disappar)?  .gitmodules that is checked out would not have
> any entry, but .git/config needs to record the end-user preference
> for the module, so that the user can do "git checkout -" to come
> back, no?

That is perfectly legit and I agree that is good design.

>  IOW .git/config that mentions all the submodule the user
> ever showed interests in is not a design mistake, so you must be
> talking about something else, but I do not know what it is.

I mean that we
(1) have a gitmodules file tracked in git that includes the name.
The "tracking some information inside the version control to
help the very version control system" is also not bad. The bad part
is that the name *must not be changed* and
 * we do not tell people about it in the docs
 * we happily make commits that change the name of a submodule
(2) name the submodule by path be default

See
https://public-inbox.org/git/7e54658a-dcb2-64a7-3c67-0c4fa221b2fb@gmail.com/

    > Oh, I see. You did not just rename the path, but also the name
    > in the .gitmodules?

    I wasn't even aware that the submodule name was something different from
    the path because the name is by default set to be the path to it.

You could blame this specific instance on the user, but I rather blame it on Git
as such questions come up once in a while on the mailing list.

If we were to redesign the .gitmodules file, we might have it as

    [submodule "path"]
        url = git://example.org
        branch = .
        ...

and the "path -> name/UID" mapping would be inside $GIT_DIR.

>
> Are they both in section (1)?  I think the former (concepts) belongs
> to section 7 and the latter (file formats) belongs to section 5.

oops. Will fix.

>
>> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
>> new file mode 100644
>> index 0000000000..3369d55ae9
>> --- /dev/null
>> +++ b/Documentation/gitsubmodules.txt
>> @@ -0,0 +1,194 @@
>> +gitsubmodules(7)
>> +================
>> +
>> +NAME
>> +----
>> +gitsubmodules - information about submodules
>> +
>> +SYNOPSIS
>> +--------
>> +$GIT_DIR/config, .gitmodules
>> +
>> +------------------
>> +git submodule
>> +------------------
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +A submodule allows you to keep another Git repository in a subdirectory
>> +...
>> +When cloning or pulling a repository containing submodules however,
>> +the submodules will not be checked out by default; You need to instruct
>> +'clone' to recurse into submodules. The 'init' and 'update' subcommands
>
> I think this is not "You need to", but rather "You can, if you want
> to have each and every submodules."

ok. In this  man page for submodules I assumed an implicit
"[if you want these submodules to be there, then] you have to/need to ...

But I'll tone it down as it doesn't carry internal assumptions.

>> +
>> +** When you want to use a (third party) library tied to a specific version.
>> +   Using submodules for a library allows you to have a clean history for
>> +   your own project and only updating the library in the submodule when needed.
>
> I somehow do not see this as decoupling; it is keeping what is
> originally separate separate, isn't it?

ok I'll reword that to say keeping separate things separate.

>
>> +** In its current form Git scales up poorly for very large repositories that
>> +   change a lot, as the history grows very large. For that you may want to look
>> +   at shallow clone, sparse checkout or git-lfs.
>> +   However you can also use submodules to e.g. hold large binary assets
>> +   and these repositories are then shallowly cloned such that you do not
>> +   have a large history locally.
>
> In other words, a better way to list these may be
>
>  1. using another project that stands on its own.
>
>  2. artificially split a (logically single) project into multiple
>     repositories and tying them back together.
>
> The access control and performance reasons are subclasses of 2.
> IOW, if Git had per-path ACL and infinite scaling, you wouldn't be
> splitting your project into submodules for 2.  You would still want
> to use somebody else's project by binding it as a subproject, instead
> of merging its history into yours.

Looking at the big picture with a logical view is better indeed.

>
>> +When working with submodules, you can think of them as in a state machine.
>> +So each submodule can be in a different state, the following indicators are used:
>> +
>> +* the existence of the setting of 'submodule.<name>.url' in the
>> +  superprojects configuration
>> +* the existence of the submodules working tree within the
>> +  working tree of the superproject
>> +* the existence of the submodules git directory within the superprojects
>> +  git directory at $GIT_DIR/modules/<name> or within the submodules working
>> +  tree
>> +
>> +      State      URL config        working tree     git dir
>> +      -----------------------------------------------------
>> +      uninitialized    no               no           no
>> +      initialized     yes               no           no
>> +      populated       yes              yes          yes
>> +      depopulated     yes               no          yes
>> +      deinitialized    no               no          yes
>> +      uninteresting    no              yes          yes
>> +
>> +      invalid          no              yes           no
>> +      invalid         yes              yes           no
>
> I do not have strong opinions on these labels; are submodule folks
> happy with the above vocabulary?

Brandon suggested (in)active instead of (un)initialized, which is better as
it decouples the current process from the actual states. Once we reintroduce
[1], then the user would not need to run "init" (whether it is 'git
submodule init'
or implicit as e.g. 'git submodule update --init') any more, but the selection
of active submodules would be done via config.

[1] https://public-inbox.org/git/20161110203428.30512-35-sbeller@google.com/

>
> "uninteresting" is not explained in the below?

will fix.

>
>> ...
>> +SEE ALSO
>> +--------
>> +linkgit:git-submodule[1], linkgit:gitmodules[1].
>
> Ditto.
