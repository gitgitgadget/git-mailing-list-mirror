Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E282047F
	for <e@80x24.org>; Fri,  4 Aug 2017 17:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbdHDRcM (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 13:32:12 -0400
Received: from mout.web.de ([212.227.15.14]:50357 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbdHDRcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 13:32:11 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LzVMw-1dZkIm44Sw-014iim; Fri, 04
 Aug 2017 19:31:59 +0200
Subject: Re: [PATCH v1 1/1] correct apply for files commited with CRLF
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, asottile@umich.edu
References: <cceaf377-73e0-e733-20ba-c4e547226382@web.de>
 <20170802204203.29484-1-tboegi@web.de>
 <xmqqwp6lr7u0.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <191dc9ea-6ad3-f754-59da-2075a6fd581e@web.de>
Date:   Fri, 4 Aug 2017 19:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp6lr7u0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K0:iZ3/Cj/31lJamvI+nd6x8wrNzNYEXG5TRrtFbe9mAOS5axRC2qA
 3tJ2Vsy2haCv1jKDzpfv3etiZDmWPodWzRx8LHiFmmGePWN9qX7d7el279VmOYIDi5AoThC
 rjUNj+tIKRc2xrg2GjVw/WZQZGpj0w2f54bLVBl7NJEc8TcMemox16FIueJFqxp0VnqVBcy
 G5E4WJaol2HV+pl1uhinw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AiGtlSgqMJ4=:N3VoZMBzq4b42mzcC+ZhmB
 I1rE+zgX69rVCFHn97X2Jo3P1viKLJEJWJWnXMPZwrGtsY3wqhnchdMOT5FbV/uozVw7IFolv
 TEtSCJT4bzJUWcvwSFI30l/4xeYUwjxzowlKOl1Cr4HufmAvcJl2g8wTeaTlqjknA8QtbuI3S
 4qTk04kq8AmktKTSnhN/N+V2zLTfSOfX2F5mFaT9mwvpZ8nup3cYJ0xbLd+BpgP2x1F+2absL
 XqNoVQqDtv9IVhRKChQVaVoEZbVz8sWHqsqCrH7c/w1FPRE/mkbEBLt0wrZhif/qoBsjYU5P9
 db6RG4FpYFtWMu/XrHcXPGEGKHXGVfXqmdU1YuIKj4UZ4A7llV22raOCArbQSkQ45H3qK9bcm
 aBhNCuGYFzZccU90W36a5z9Sa3wbaWJrhPtmNTUBP6j++8uOnUa1vW81XpNwlPktLpVHCOn26
 ElSnt7fBgdXRknnGKNHSonBpvDNvly8FFzV5gxv/8c/4QA+YkP1VtQuV5tPVv0NIagwdPsu9y
 3tutI8p5I+VmO+UepEBCobnjVWb1X/f7hqdTzx5OxmJOCCDH+7x19wzwzzBjh+/dRMXOrHzef
 0uPJsTUS8Nf3Y64d34vowCwwoJjIGskyvBXsC9jtIX9SLW8UVbQzb0qFIeBdhsL+ubf2oKo+z
 Bu5N+h3HtT8JnTZLAGR9qNeBmkMJZAaV0JK2YuxD9dbtwK2urFwT/7Vll4NkNbxhHLNJ+YFyZ
 bAdmIXcEts/+J0J07oqhpcYJqUd2yWwtTRqu70DDNhMv1/ckkBEW2KTVUyf0ikuC2z0V0XLoi
 NKuIBzFB93Zm9Arn7TR8XgnZ2aMX2ovYvOvauavp9etlTgk/F4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/02/2017 11:13 PM, Junio C Hamano wrote:
> tboegi@web.de writes:
>
>> From: Torsten Bögershausen <tboegi@web.de>
>>
>> git apply does not find the source lines when files have CRLF in the index
>> and core.autocrlf is true:
>> These files should not get the CRLF converted to LF. Because cmd_apply()
>> does not load the index, this does not work, CRLF are converted into LF
>> and apply fails.
>>
>> Fix this in the spirit of commit a08feb8ef0b6,
>> "correct blame for files commited with CRLF" by loading the index.
>>
>> As an optimization, skip read_cache() when no conversion is specified
>> for this path.
> What happens when the input to apply is a patch to create a new file
> and the patch uses CRLF line endings?  In such a case, shouldn't
> core.autocrlf=true cause the patch to be converted to LF and then
> succeed in applying?  An extra read_cache() would not help as there
> must be no existing index entry for the path in such a case.
>
> If you did "rm .git/index" after you did the "git checkout -- ." in
> your test patch, "git apply" ought to succeed, as it is working as
> a substitute for "patch -p1" and should not be consulting the index
> at all.
>
> I cannot shake this feeling that it is convert_to_git() that needs
> to be fixed so that it does not need to refer to the current
> contents in the index.  Why does it even need to look at the index?
> If it is for the "safe CRLF" thing (which I would think is misguided),
> shouldn't it be checking the original file in the working tree, not
> the index?  After all, that is what we are patching, not the contents
> stored in the index.
Thanks for the review.
My understanding is that there are different things possible with `git 
apply`:
working on files in the index ("cached") files and "worktree" files.

If we work on files in the index, the line endings must match for
the patch to apply, the patch/apply machinery is not forgiving
mismatching line endings. At least not by default.
There is one exception: Use "blank-at-eol" to declare the CR of
the CRLF as a whitespace, and then tell git apply to ignore white space:
`git apply --ignore-whitespace`
My feeling is that this is not self-explaining, but this is a different 
story.

Back to the fix, the read_old_data() from below works on the working tree,
yes, but after convert_to_git().
And that is why we need the index, to fix this very case.

appy.c:
static int load_patch_target(struct apply_state *state,
                  struct strbuf *buf,
                  const struct cache_entry *ce,
                  struct stat *st,
                  const char *name,
                  unsigned expected_mode)
{
     if (state->cached || state->check_index) {
         if (read_file_or_gitlink(ce, buf))
             return error(_("failed to read %s"), name);
     } else if (name) {
         if (S_ISGITLINK(expected_mode)) {
             if (ce)
                 return read_file_or_gitlink(ce, buf);
             else
                 return SUBMODULE_PATCH_WITHOUT_INDEX;
         } else if (has_symlink_leading_path(name, strlen(name))) {
             return error(_("reading from '%s' beyond a symbolic link"), 
name);
         } else {
             if (read_old_data(st, name, buf))
                 return error(_("failed to read %s"), name);
         }
     }
     return 0;
}

