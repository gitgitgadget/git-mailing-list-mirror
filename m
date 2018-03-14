Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165751FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 10:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCNKOj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 06:14:39 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36048 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCNKOi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 06:14:38 -0400
Received: by mail-wm0-f49.google.com with SMTP id i194so2874451wmg.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xlliOLQJ2uXDBhA3naB+JSh1YtY4F9cTjOb6hVjsyLg=;
        b=J6ycxhXlgaBhoI+87LzVP/VdX99ETRAc5ArhuMrm6iLhOoFcUanhb22Yjw36O04Ucg
         qIks7T1vmZgxf994JS2w4X0sDvsaFI4dFEF1KbdP3cG6rLomV5nyXxrq6pfeZFTrkKoC
         RlnLHgYU7fQVJE3SADvEPcz4KVuihLhSHrCm0xTzRUImZxsziSr2bG/GkOMTvzmqFE6K
         qLRjUki4UNUkyhYjf81B599X8H6cEcC4Iog3nWxa0pLaMriAmbtmO2O1b/vqEH6QZicG
         a3KDUouFxxLzVxA5CKChxxBLAZnFYyikjvZM1vugl/fHQp/hXdJ+BwcN3TmdnLP6g6/d
         qa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xlliOLQJ2uXDBhA3naB+JSh1YtY4F9cTjOb6hVjsyLg=;
        b=ew+hUd1fCAnzsnDkzvyUmyILr+KBgkfI4by37MaAzBHpltl+rBID8dIp1up0Ziquz5
         4cPoGVNLh72V+xdSI6KlqcoK83OqCC+IQUyyk4k3ipBoCS2faWwZ+cIZQ6D4y7YmMzAo
         kotDmZkIaNZ9FVlp69j0YxvsL1aB36f2hbCMNm2Jlw/3xoOWBATscAuE7IIosXGJTWEB
         ihU+AbWKkNOIyU5DTHQH+anVaJdEiws98urjlYEhve1/MTVce8zy26Vaj/d1QWzpXCA1
         v4wIJN9cmnN5OaXoOg1d+9fXdOfSZwCvONp5rQnT3ZClvRTgAeyXvCNOzB5ReBvM/N1W
         H9yQ==
X-Gm-Message-State: AElRT7GvIlKh45vkXV309UcSLJz+aT1lUBLtDFYMuDxG9EZXDDXF0aJf
        IrRE8Tfp0p03/HoHYO0xjTsC+kY4
X-Google-Smtp-Source: AG47ELvkW4ea6B4YsEZBh9CciAcfaeDb+rIHrsNiGzmQfASUOaKiNXRWPrg77YkN/Y21MLQRcZvloA==
X-Received: by 10.80.186.81 with SMTP id 17mr4332843eds.107.1521022476372;
        Wed, 14 Mar 2018 03:14:36 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 4sm1798095edx.8.2018.03.14.03.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 03:14:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core binaries to bin/git
References: <20180313203935.5084-1-avarab@gmail.com> <20180313203935.5084-4-avarab@gmail.com> <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org>
Date:   Wed, 14 Mar 2018 11:14:34 +0100
Message-ID: <87y3ivdkvp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 14 2018, Johannes Sixt jotted:

> Am 13.03.2018 um 21:39 schrieb Ævar Arnfjörð Bjarmason:
>> Add a INSTALL_SYMLINKS option which if enabled, changes the default
>> hardlink installation method to one where the relevant binaries in
>> libexec/git-core are symlinked back to ../../bin, instead of being
>> hardlinked.
>>
>> This new option also overrides the behavior of the existing
>> NO_*_HARDLINKS variables which in some cases would produce symlinks
>> within to libexec/, e.g. "git-add" symlinked to "git" which would be
>> copy of the "git" found in bin/, now "git-add" in libexec/ is always
>> going to be symlinked to the "git" found in the bin/ directory.
>
> It is important to leave the default at hard-linking the binaries,
> because on Windows symbolic links are second class citizens (they
> require special privileges and there is a distinction between link
> targets being files or directories). Hard links work well.

Yeah makes sense. I just want to add this as an option, and think if
it's proven to be un-buggy we could probably turn it on by default on
the *nix's if people prefer that, but yeah, we'll definitely need the
uname detection.

>>
>> This option is being added because:
>>
>>   1) I think it makes what we're doing a lot more obvious. E.g. I'd
>>      never noticed that the libexec binaries were really just hardlinks
>>      since e.g. ls(1) won't show that in any obvious way. You need to
>>      start stat(1)-ing things and look at the inodes to see what's
>>      going on.
>>
>>   2) Some tools have very crappy support for hardlinks, e.g. the Git
>>      shipped with GitLab is much bigger than it should be because
>>      they're using a chef module that doesn't know about hardlinks, see
>>      https://github.com/chef/omnibus/issues/827
>>
>>      I've also ran into other related issues that I think are explained
>
> s/ran/run/
>
>>      by this, e.g. compiling git with debugging and rpm refusing to
>>      install a ~200MB git package with 2GB left on the FS, I think that
>>      was because it doesn't consider hardlinks, just the sum of the
>>      byte size of everything in the package.
>>
>> As for the implementation, the "../../bin" noted above will vary given
>> some given some values of "../.." and "bin" depending on the depth of
>
> s/given some//
>
>> the gitexecdir relative to the destdir, and the "bindir" target,
>> e.g. setting "bindir=/tmp/git/binaries gitexecdir=foo/bar/baz" will do
>> the right thing and produce this result:
>>
>>      $ file /tmp/git/foo/bar/baz/git-add
>>      /tmp/git/foo/bar/baz/git-add: symbolic link to ../../../binaries/git
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>   Makefile | 46 +++++++++++++++++++++++++++++++---------------
>>   1 file changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index ee0b6c8940..ac7616422d 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -329,6 +329,13 @@ all::
>>   # when hardlinking a file to another name and unlinking the original file right
>>   # away (some NTFS drivers seem to zero the contents in that scenario).
>>   #
>> +# Define INSTALL_SYMLINKS if you prefer to have everything that can be
>> +# symlinked between bin/ and libexec/ to use relative symlinks between
>> +# the two. This option overrides NO_CROSS_DIRECTORY_HARDLINKS and
>
> s/ between the two//

Thanks. Will fix the above in a subsequent submission.

>> +# NO_INSTALL_HARDLINKS which will also use symlinking by indirection
>> +# within the same directory in some cases, INSTALL_SYMLINKS will
>> +# always symlink to the final target directly.
>
> "the final target"? Do you mean "the git executable installed in
> $bindir" or something like this?

I'm not explaining this well, but what I mean is that right now if you
supply NO_INSTALL_HARDLINKS you end up with this:

    bin/git
    libexec/git
    libexec/git-add -> git

I.e. we make two copies of the "git" binary, and then just symlink
within the libexec dir, whereas with this change:

    bin/git
    libexec/git -> ../bin/git
    libexec/git-add -> ../bin/git

I.e. we'll only install one "git" and never copy it, and to the extent
that we need symlinking we're always going to symlink directly to the
binary, i.e. not:

    bin/git
    libexec/git -> ../bin/git
    libexec/git-add -> git

Even though that would also work, I just don't think it makes sense.

>> +#
>>   # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
>>   # programs as a tar, where bin/ and libexec/ might be on different file systems.
>>   #
>> @@ -2594,35 +2601,44 @@ endif
>>     	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
>>   	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
>> +	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
>>   	{ test "$$bindir/" = "$$execdir/" || \
>>   	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
>>   		$(RM) "$$execdir/$$p" && \
>> -		test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
>> -		ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
>> -		cp "$$bindir/$$p" "$$execdir/$$p" || exit; \
>> +		test -n "$(INSTALL_SYMLINKS)" && \
>> +		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \
>> +		{ test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
>> +		  ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
>> +		  cp "$$bindir/$$p" "$$execdir/$$p" || exit; } \
>
> I think that it is unnecessary to place the later options in {}
> brackets because && and || have equal precedence in shell
> scripts. That is:
>
> 	want symlinks? &&
> 	make symlinks ||
> 	want hard links? &&
> 	make hard links ||
> 	make copies ||
> 	exit
>
> Of course, it means that when symlinking fails, it falls back to hard
> links (if permitted) or copies, whichever works. But that also happens
> with your version.
>
> (Ditto in the rest of the hunk, which I don't repeat here.)

Yes. This is shitty, I'll change it. I'm going to inject a patch series
earlier in this series so we'll do:

 	want symlinks? &&
 	make symlinks ||
 	want hard links? &&
 	make hard links ||
 	want copy fallback? &&
 	make copies ||
 	exit

And then turn on the copy fallback by default. Right now we'll silently
hide errors during "make install", which isn't nice. I'll leave the
fallback on by default (for now), but I'd like to declare that I want to
install symlinks, and if that fails I should get an error, not a silent
fallback to copy.
