Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED471F406
	for <e@80x24.org>; Thu,  4 Jan 2018 01:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeADB3W convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 3 Jan 2018 20:29:22 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp ([133.41.12.55]:60258 "HELO
        huc12-ckmail02.hiroshima-u.ac.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751401AbeADB3U (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Jan 2018 20:29:20 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp (localhost [127.0.0.1])
        by dummy.hiroshima-u.ac.jp (Postfix) with ESMTP id 088ADB1A4F2;
        Thu,  4 Jan 2018 10:29:19 +0900 (JST)
Received: from huc12-smtp01.hiroshima-u.ac.jp (huc12-smtp01.hiroshima-u.ac.jp [133.41.12.52])
        by huc12-ckmail02.hiroshima-u.ac.jp (Postfix) with ESMTP id F1D71A891D0;
        Thu,  4 Jan 2018 10:29:18 +0900 (JST)
Received: from [133.41.46.194] (46-194.cup.hiroshima-u.ac.jp [133.41.46.194])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by huc12-smtp01.hiroshima-u.ac.jp (Postfix) with ESMTPSA id E9183D3471;
        Thu,  4 Jan 2018 10:29:18 +0900 (JST)
Message-ID: <5A4D836D.2010409@hiroshima-u.ac.jp>
Date:   Thu, 04 Jan 2018 10:29:17 +0900
From:   suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp> <df39f62558314cf6a9d9df3e23f31dd8@OS2PR01MB1147.jpnprd01.prod.outlook.com> <5A4B2DA5.907@hiroshima-u.ac.jp> <59a1fc058278463996ed68c970a5e08a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
In-Reply-To: <59a1fc058278463996ed68c970a5e08a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1808-8.1.0.1062-23572.003
X-TM-AS-Result: No--24.670-10.0-31-10
X-imss-scan-details: No--24.670-10.0-31-10
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-MatchedRID: 6i9BTbUAHf1ITndh1lLRAe5i6weAmSDKp/xyq10Na6cg6wAQlDW40KP5
        4oORNNkAoY6wvmZijTlQ0dgkyLN5bgCSsXin6jZTRnmgWPGIUuMk227IvqakhUuNdcZDLqeU3+a
        Cpx4R3RBS+SrniqEHSQv4P74JKColFzVT4QVLabKjrlYm3WTU7ywB2jqVCX61nOgRWqQqf8+zLU
        2oe8ho5jPL2ORr4+vFENqS6iccp+UASjkq7mEl+dcjCbPZgQnFU3wEIur3jmFEv26FkhjLXWwqS
        TpOVkRPNVkPczHZM87S1TYOYs0v6clBBl8WJYU/fuyIS1Zjfrv/47w7C7wdzNJgDNnoqapas4RZ
        M0nNCvDFuIzzlRYeoATqfG8+r3FKRM4Ai/xKf9TkKCFOKwAEzFPgO2JKQydYjU56jjASCeEP8eE
        jBnoc0+6XCtUL2aEBq+l1u/TUA3nx3YzTiJbL8uLdprnA5EQRydxpQiOYbHhDrHyMlGot+Imb/f
        mBoxCiMzYb2XHrUTmAc4Dx1Qcvcy4UUq9htJ32HcQQBuf4ZFsr3O90UD+tORHfiujuTbedti4Ra
        HpoZC50LZ8dB7RAtlMvZhtp0LoGx25lXUKnIFfIOn6NK8S1a/NapaqLSkEBu/jTz8Y/keppV1Cx
        FK6KOxX4ZxlM1NZqXbqNn1OdWHjrGP22mXF7WhuZoNKc6pl+BxLRKWJ1bsJJJReS9JUB3HyvADB
        Z6sGYR9xeSbKd3xUlkSDvNC1GnAg0O37rJ/VcY6Gjtu6/t31Ds3Mkq3UbyDASEdbkpUDPiYjfDK
        4dEvoPLHJPYbkUU6hLoX1Nt0SsvQD12XFqHNOeAiCmPx4NwFkMvWAuahr8trNGq+WQEvSWM1/NB
        yeF10RwZjp2iRLvxEHRux+uk8jpP8tMOyYmaA==
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear René ,

By overlooking your response, I was writing a patch to add
uid/gid into zip archive X-D (not finished yet)
https://github.com/mpsuzuki/git/tree/add-zip-uid-gid
However, I found that most unix platforms use infozip's
extension to store uid/gid instead of pkzip's extension...

> So this is in the context of generating release tarballs that contain
> untracked files as well.  That's done in Git's own Makefile, too:

Oh, I should check other software's tarball :-)

> The generated archive leaks the IDs of the user preparing the archive in
> the appended entries for untracked files.  I think that's more of a
> concern.  Publishing a valid non-root username on your build system may
> invite attackers.

Hmm, I was not aware of such security concern about the
tarball including the developers username.

> So how about making it possible to append untracked files using git
> archive?  This could simplify the dist target for Git as well.  It's
> orthogonal to adding the ability to explicitly specify owner and group,
> but might suffice in most (all?) cases.

Hmm, it could be reasonable to assume that --append-file
would serve more cases than --uid --gid options. There
might be many people who don't care multiple UID/GID in
the source tarball, but want to append some files to the
archive generated by git-archive. I would take a look how
to do that. A point I'm afraid is that some people may
request to pass the file listing the pathnames instead of
giving many --append-file options (and a few people could
want to have a built-in default list specified by GNU
convention :-)).

I want to hear other experts' comment; no need for me to
work "--uid" "--gid" anymore, and should I switch to
"--append-file" options?

Regards,
mpsuzuki

René Scharfe wrote:
> Am 02.01.2018 um 07:58 schrieb suzuki toshiya:
>> Dear René ,
>>
>> René Scharfe wrote:
>>> Am 29.12.2017 um 15:05 schrieb suzuki toshiya:
>>>> The ownership of files created by git-archive is always
>>>> root:root. Add --owner and --group options which work
>>>> like the GNU tar equivalent to allow overriding these
>>>> defaults.
>>> In which situations do you use the new options?
>>>
>>> (The sender would need to know the names and/or IDs on the receiving
>>> end.  And the receiver would need to be root to set both IDs, or be a
>>> group member to set the group ID; I guess the latter is more common.)
>> Thank you for asking the background.
>>
>> In the case that additional contents are appended to the tar file
>> generated by git-archive, the part by git-archive and the part
>> appended by common tar would have different UID/GID, because common
>> tar preserves the UID/GID of the original files.
>>
>> Of cource, both of GNU tar and bsdtar have the options to set
>> UID/GID manually, but their syntax are different.
>>
>> In the recent source package of poppler (poppler.freedesktop.org),
>> there are 2 sets of UID/GIDs are found:
>> https://poppler.freedesktop.org/poppler-0.62.0.tar.xz
>>
>> I've discussed with the maintainers of poppler, and there was a
>> suggestion to propose a feature to git.
>> https://lists.freedesktop.org/archives/poppler/2017-December/012739.html
> 
> So this is in the context of generating release tarballs that contain
> untracked files as well.  That's done in Git's own Makefile, too:
> 
>   dist: git-archive$(X) configure
>           ./git-archive --format=tar \
>                   --prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
>           @mkdir -p $(GIT_TARNAME)
>           @cp configure $(GIT_TARNAME)
>           @echo $(GIT_VERSION) > $(GIT_TARNAME)/version
>           @$(MAKE) -C git-gui TARDIR=../$(GIT_TARNAME)/git-gui dist-version
>           $(TAR) rf $(GIT_TARNAME).tar \
>                   $(GIT_TARNAME)/configure \
>                   $(GIT_TARNAME)/version \
>                   $(GIT_TARNAME)/git-gui/version
>           @$(RM) -r $(GIT_TARNAME)
>           gzip -f -9 $(GIT_TARNAME).tar
> 
> Having files with different owners and groups is a non-issue when
> extracting with --no-same-owner, which is the default for regular users.
> I assume this covers most use cases in the wild.
> 
> The generated archive leaks the IDs of the user preparing the archive in
> the appended entries for untracked files.  I think that's more of a
> concern.  Publishing a valid non-root username on your build system may
> invite attackers.
> 
> Changing the build procedure to set owner and group to root as well as
> UID and GID to zero seems like a better idea.  This is complicated by
> the inconsistent command line options for GNU tar and bsdtar, as you
> mentioned.
> 
> So how about making it possible to append untracked files using git
> archive?  This could simplify the dist target for Git as well.  It's
> orthogonal to adding the ability to explicitly specify owner and group,
> but might suffice in most (all?) cases.
> 
> Not sure what kind of file name transformation abilities would be
> needed and how to package them nicely.  The --transform option of GNU
> tar with its sed replace expressions seems quite heavy for me.  With
> poppler it's only used to add the --prefix string; I'd expect that to
> be done for all appended files anyway.
> 
> Perhaps something like --append-file=<FILE> with no transformation
> feature is already enough for most cases?
> 
>>> Would it make sense to support the new options for ZIP files as well?
>> I was not aware of the availability of UID/GID in pkzip file format...
>> Oh, checking APPNOTE.TXT ( https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT ),
>> there is a storage! (see 4.5.7-Unix Extra Field). But it seems
>> that current git-archive emits pkzip without the field.
> 
> Indeed.  Git doesn't track owners and groups, so it doesn't make
> sense to emit that kind of information so far.  If git archive grows
> options to specify such meta-information then it should be supported
> by all archive formats (or documented to be tar-specific).
> 
> However, the UNIX Extra Field in ZIP archives only allows to store
> UID and GID (no names), which is useless unless the sender knows the
> ID range of the receiver -- which is unlikely when distributing
> software on the Internet.  And even then it won't work with Windows,
> which has long Security Identifiers (SIDs) instead.
> 
> So these are more advantages for letting git archive append untracked
> files: It's format-agnostic and more portable.
> 
> 
> [snipped interesting history of security-related tar options]
> 
> Btw. I like how bsdtar has --insecure as a synonym for -p (preserve
> file permissions when extracting).  It's a bit sad that this is still
> the default for root, though.  OpenBSD cut that behavior out of their
> tar almost 20 years ago.  (An evil tar archive could be used to fill
> the quota of unsuspecting users, or add setuid executables.)
> 
>>>> +#if ULONG_MAX > 0xFFFFFFFFUL
>>>> +    /*
>>>> +     * --owner, --group rejects uid/gid greater than 32-bit
>>>> +     * limits, even on 64-bit platforms.
>>>> +     */
>>>> +    if (ul > 0xFFFFFFFFUL)
>>>> +        return STR_IS_DIGIT_TOO_LARGE;
>>>> +#endif
>>> The #if is not really necessary, is it?  Compilers should be able to
>>> optimize the conditional out on 32-bit platforms.
>> Thanks for finding this, I'm glad to have a chance to ask a
>> question; git is not needed to care for 16-bit platforms?
> 
> I'm not aware of attempts to compile Git on 16-bit systems, but I
> doubt it would be much fun to use the result anyway.  It couldn't
> handle files bigger than 64KB for a start.
> 
>>> GNU tar and bsdtar show the names of owner and group with -t -v at
>>> least, albeit in slightly different formats.  Can this help avoid
>>> parsing the archive on our own?
>> Yeah, writing yet another tar archive parser in C, to avoid the additional
>> dependency to Python or newer Perl (Archive::Tar since perl-5.10), is
>> painful, I feel (not only for me but also for the maintainers).
>> If tar command itself works well, it would be the best.
>>
>> But, I'm not sure whether the format of "tar tv" output is stably
>> standardized. It's the reason why I wrote Python tool. If I execute
>> git-archive with sufficently long randomized username & uid in
>> several times, it would be good test?
> 
> The append-untracked feature would avoid that issue as well.
> 
> A unique username doesn't have to be long or random if you control all
> other strings that "tar tv" would show (in particular file names).  You
> could e.g. use "UserName" and then simply grep for it.
> 
> Checking that git archive doesn't add unwanted characters is harder if
> the format isn't strictly known -- how to reliably recognize it sneaking
> in an extra space or slash?  Not sure if such a test is really needed,
> though.
> 
>>> But getting a short program like zipdetails for tar would be nice as
>>> well of course. :)
>> I wrote something in C:
>> https://github.com/mpsuzuki/git/blob/pullreq-20171227-c/t/helper/test-parse-tar-file.c
> 
> OK.  (But the append-untracked feature could be tested without such a
> helper. :)
> 
> Just some loose comments instead of a real review: You could get the
> line count down by including Git's tar.h and parse-options.h
> (Documentation/technical/api-parse-options.txt).
> 
>> but if somebody wants the support of other tar variants,
>> he/she would have some headache :-)
> 
> Yeah, the history of tar and its various platform-specific formats
> fills volumes, no doubt.
> 
> René
> 

