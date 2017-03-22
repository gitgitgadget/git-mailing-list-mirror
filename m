Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104B120323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759852AbdCVSl0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:41:26 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36762 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdCVSlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:41:25 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so111057617pge.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CPxEREpaUxkZt5sTqQPMjKaka8zDdPBDcOFpKGFC8BM=;
        b=OMGJW1sZNTeaHXzQ3RENXynv+bNPLHinR8TwZowAXIzfyaE/5Bwk30ykf+5czYJml/
         lqzib5Ub9kJQcHhyepaz/teKA3nDE6WRDMzrDa/7EIm5qgnwLAbGHg7xD8MDKM5vi91Y
         Js9Q/FYooX7o3TuMQnglKUSpZYB7Gcyx7DWZ8OXdbaRoJPtrnIUlT57f+UgCyvtpIAqN
         AC9jaX1JHjRQKhfiQ+gQkPuTrJPQFZJdTl7fKsTqwSKLsvbwP91pGs7MuesZA+1Y41JI
         ZypqIjJ0wRU3c4FFgy/m+/eViGPXpJiFM3OnP7/iXDhJVsmwKh2MHRqLQIEzI1KUMgz8
         D7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CPxEREpaUxkZt5sTqQPMjKaka8zDdPBDcOFpKGFC8BM=;
        b=CXT+vyMyMrh2jJGGF+74fyzqOI6qijD1Nt7JcHu46BjIlXrMfx0n011KE65F4EW5FJ
         i/BN7vXaP7UKdGBi/8hTL7hqCMvkdonQPzZooxcgonYw+eZxXL0H4+D7rljLw8WcndGH
         XuH78nRH1W3qS1kuaE9bAcrM1spIs6P3vQkTi/lDZcCWWIS1tRERAhzERW7Z6XeDIRL8
         pKiABACkJrOw1WRhirIei+abgvq0E7TtXLMC5hU3MUghBG1UaGVGqNfCp7FtcYXcrhNH
         +KhvQ2zIWEAW91ZjDVPbiMsmDoaKIhmEed/aLOpPDsszupDx3RzB4efMH6LGau7Dj3Oq
         KSew==
X-Gm-Message-State: AFeK/H27d1UOTsjU8SAXzKzl3kHav0WaIVNTwskFL5KT2ywUEOEL8m69Ja/KGNxAgp0DeNEEGrxz6VFhU3F4zSRW
X-Received: by 10.84.241.69 with SMTP id u5mr57402874plm.107.1490208083632;
 Wed, 22 Mar 2017 11:41:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Wed, 22 Mar 2017 11:41:23 -0700 (PDT)
In-Reply-To: <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
References: <20170312200248.3610-1-jn.avila@free.fr> <20170320210225.13046-1-jn.avila@free.fr>
 <20170320210225.13046-3-jn.avila@free.fr> <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
 <5036581a-f989-2db6-06ba-621db05c6de1@free.fr> <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Mar 2017 11:41:23 -0700
Message-ID: <CAGZ79kZBq+dL7hEj108DPU5KbVeJX2nYEw88jS0Eq78GxzCabA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 11:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
>
>>> I am wondering if Documentation/po part should be a separate
>>> repository, with a dedicated i18n/l10n coordinator.  Would it make
>>> it easier for (1) those who write code and doc without knowing other
>>> languages, (2) those who update .pot and coordinate the l10n effort
>>> for the documentation and (3) those who translate them if we keep
>>> them in a single repository?
>>
>> This is one of the points raised in the first RFC mail. Splitting this
>> part would help a lot manage the translations with their own workflow,
>> would not clutter the main repo with files not really needed for
>> packaging and would simplify dealing with the interaction with crowd
>> translation websites which can directly push translation content to a
>> git repo.
>
> As I was in favor of splitting it out, I was trying to gauge what
> the downside of doing so would be, especially for those who are
> doing the translation work (it is obvious that it would help
> developers who are not translators, as nothing will change for them
> if we keep this new thing as a separate project).
>
> We may still want to fill in the details (and by doing so we may
> discover it is not as easy as I make it sound to be here), but a
> rough outline of what I think we could do is:
>
>  * What you added to Documentation/po/ in these two patches becomes
>    a separate project (let's call it "gitman-l10n") and they will be
>    at the root level of the project, i.e. documentation.pot and
>    documentation.$LANG.po will sit at the top level of the working
>    tree of that project, without Documentation/po/ prefix.
>
>    The idea is for some of us to have a checkout of "gitman-l10n"
>    project inside Documentation/po of the checkout of git.git
>    project and achieve a layout similar to what these two patches
>    from you create, but keep that optional.
>
>  * In git.git, teach Documentation/Makefile to enable "make
>    doc-l10n" and "make install-l10n" targets in "Documentation/" if
>    and only if Documentation/po/Makefile exists, and delegate these
>    two targets to it, i.e. something like:
>
>    (in Documentation/Makefile)
>    ifeq ($(wildcard po/Makefile),po/Makefile)
>    doc-l10n install-l10n::
>         $(MAKE) -C po $@
>    endif
>
>    Certain Makefile macros Documentation/Makefile knows aboute
>    (e.g. location to install, list of pages in the man1 section) may
>    have to be exported down to Documentation/po/Makefile.
>
>  * Some other Makefile targets to help i18n coordinator, e.g.
>    updating Documentation/po/documentation.pot by using the latest
>    set of Documentation/*.txt files, may also have to be added to
>    Documentation/Makefile and conditionally enabled the same way
>    (i.e. keying off of the presence of po/Makefile).
>
>  * Those who work on the documentation translation and those who
>    want to build and install localized documentation will have a
>    checkout of the "gitman-l10n" project at "Documentation/po".
>    This will _eventually_ be done by making "gitman-l10n" a
>    submodule that git.git project uses, but it can start as a manual
>    "clone and checkout" without making it a submodule.  Those who do
>    not deal with localized manpages can just work with git.git
>    proper without even knowing anything about the gitman-l10n
>    project.

I wonder if we could have partial functionality for these "clone and checko=
ut"
fake submodules, by having e.g. the .gitmodules file telling you the URL
and path, but no recorded gitlink in the tree.

> I'd prefer to start with the "optional gitman-l10n repository is
> checked out at Documentation/po only by convention" approach, before
> committing to bind it as a submodule.  Once we got comfortable with
> cooperating between these two projects, we do want to bind them
> using the submodule mechanism, but not before.

Yay, submodules in git.git!  Another aspect besides the git-archive
command supporting submodules is the URL management.

The URL for the canonical git.git ought to not change in the near future,
but for proper support we'd need to have a mechanism to have the URL
default and configuration outside the tracked content. The configuration
is already outside the tracked content, but the default is not.

IIUC Jonathan Nieder has a proposal for that (though not in written
form, easy to point at), which consists of having an additional" .gitmodule=
s"
file stored in another ref, e.g. "refs/superproject/master" (Maybe we do no=
t
need it to be branch specific? then a refs/meta/superproject would do).

That branch can be changed
* over time
  This is useful when the canonical URL where to obtain the submodules
  changes. Also when going back in history and then getting the submodules
  would be covered with this as the new ref would not go back in history.
* across people
  Some people prefer the submodules to be fetched from an internal mirror
  (in a company). Or in a fork of an open source project the submodules are=
 also
  forked, hence need a different URL. for that such a branch would also hel=
p.

> Once git.git starts binding the "gitman-l10n" project as its
> submodule at "Documentation/po", we may want to start using "git
> archive --recurse-submodules" when cutting a release tarball, when
> that option becomes usable
>
> I'd prefer to start with the "main tarball" with "optional language
> pack tarball" approach for releases, which is more flexible to the
> end users (and less change to the workflow).  Once we gain more
> experience, we may want to produce a single ball of wax tarball as
> well (or "only a single one").

This may hint at git-archive to need more options in its
--recurse-submodules switch. We had the same discussion
for "git push --recurse-submodules" which needs an easy
mechanism to select from the powerset of
(superproject, submoduleA, submoduleB).

So we'd want to be able to say:
  "get a tarball including all submodules except the superproject"
  (This would produce the "optional language pack tarball")
  "get a tarball including the superproject and only one submodule"
  (This would produce the "I can distribute this in locally as everyone
  speaks the same language in the organisation" tarball)

Thanks,
Stefan
