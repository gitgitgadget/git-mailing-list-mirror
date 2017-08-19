Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D784C1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 16:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdHSQ63 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 12:58:29 -0400
Received: from mout.web.de ([212.227.15.14]:56593 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdHSQ62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 12:58:28 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfEfA-1dCEAB0xia-00oqXH; Sat, 19
 Aug 2017 18:58:15 +0200
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
 <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
 <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
Message-ID: <798212ae-ffb8-2ffb-8b59-fa307424b48a@web.de>
Date:   Sat, 19 Aug 2017 18:58:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:2qS3v+QU7c4zMhXZ4L4LZCw9XMgUfTXRwCh+yE6m0rpuY8zyYk6
 NxCMCY9g/qCKi4Na0oHJTlrkUkvh5KrY6tGWIdKTuB/9UfHoEzXOWST9auMJitHyH51pMrL
 cAidFtiFSlwFO5LQPu0I70q8wBx2OxmxVn8+I7Nbsha88cHxRalfc8NcGLAaD8giA0kpb6E
 7ym+GQQcJWTEcEVzoma/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LH2gunir9gk=:HJVOvBJxHNIDS0igPjahyW
 PNrNyJNARW4N1c6PUgIIxJ1rdhffIxZZtqUIJVnYF8osfQDGqPJzfMFmlrukj5MZ2Wzaalhb2
 aaF+ueru/USHIXa3IxGKhVyAF5QMOaLCfIWqO2mq/pdeOoO+xhYd/2kwUmMgfM35ZvpKew+B3
 8oisaUH2PlcpbgcIUekLpYs6sru1VaGLlPVIHTHZfplzTtYzRj8lGoVr47zWj/omJxc03Z2mt
 nvHNbX0VC79Ubs+4AGTSNgvSyh4mWoJKPBDwT8vRt3+sx5P6P6njO8rKGq82vxvZPRrQjk14t
 LDEkl23PHle3rSoe/astR7EgLoH/AzznS7e82pdFrdbIXxT2wGXqObMg6H5LEKLVp1V/yWW5Y
 6o7E0Azty9wSjIZ0Lu7XUyCJBpupAvmLs4F2MdfNZ669+BJmArDmgP9lR9UeJo8txv01AAkPe
 bnhP3WWPN//fE2XY/+1RHL1sQ+bimWdwxsyqOk/gxU/4IHWBjIxQ5RCRXVXISBIDnGs8nRozN
 9ggK0SeitYBQ5lK6qd9Mt8BGxcWaSyYruUurEJRrBbAas8kvSAdo8lI6wiQvhBpbIw5EpFdLE
 FE4xxo9AzYqF7rSHVLYjVu/0U1pli3Shjga5lxdR2MvTRcLOz9XSoopJWuW2AlnzvpAeW3lUF
 2omor2JUXT3YefsXqCglLfIeGI6QP/QiHmKXim3ipB5ewHpimrKBYR6XtUxlLX6yYYk1ENlIK
 80XoSQVlVGqd0sp/fek/4PpC8H4QNhjSjFe28adNcNxzWeWrsOYa+/jX9UcjURDCd/ub6lfr1
 8LpTBh93LyZhZJ4A2Q9dmdYrbfgig/FaHMvmbyuNZKW1jFcUmI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.08.2017 um 18:53 schrieb René Scharfe:
> Am 19.08.2017 um 07:33 schrieb René Scharfe:
>> When read_tree_recursive() encounters a directory excluded by a pathspec
>> then it enters it anyway because it might contain included entries.  It
>> calls the callback function before it is able to decide if the directory
>> is actually needed.
>>
>> For that reason git archive adds directories to a queue and writes
>> entries for them only when it encounters the first child item -- but
>> only if pathspecs with wildcards are used.  Do the same for literal
>> pathspecs as well, as the reasoning above applies to them, too.  This
>> prevents git archive from writing entries for excluded directories.
> 
> This breaks the test "archive empty subtree with no pathspec" in t5004 by

No, it's "archive empty subtree by direct pathspec" that's broken.  Gah!

> omitting the empty directory from the archive.  Sorry for missing that!
> 
> This is kind of a bonus patch, so please discard it for now; the first
> three are OK IMHO.
> 
> A better version of this patch would at least update t5004 as well, but
> there might be a better way.
> 
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>    archive.c               | 2 +-
>>    t/t5001-archive-attr.sh | 2 +-
>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/archive.c b/archive.c
>> index 1ab8d3a1d7..174c0555b6 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -123,7 +123,7 @@ static int check_attr_export_subst(const struct attr_check *check)
>>    
>>    static int should_queue_directories(const struct archiver_args *args)
>>    {
>> -	return args->pathspec.has_wildcard;
>> +	return args->pathspec.nr;
>>    }
>>    
>>    static int write_archive_entry(const unsigned char *sha1, const char *base,
>> diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
>> index 897f6f06d5..e9aa97117a 100755
>> --- a/t/t5001-archive-attr.sh
>> +++ b/t/t5001-archive-attr.sh
>> @@ -73,7 +73,7 @@ test_expect_missing	archive-pathspec/ignored-by-tree
>>    test_expect_missing	archive-pathspec/ignored-by-tree.d
>>    test_expect_missing	archive-pathspec/ignored-by-tree.d/file
>>    test_expect_exists	archive-pathspec/ignored-by-worktree
>> -test_expect_missing	archive-pathspec/excluded-by-pathspec.d failure
>> +test_expect_missing	archive-pathspec/excluded-by-pathspec.d
>>    test_expect_missing	archive-pathspec/excluded-by-pathspec.d/file
>>    
>>    test_expect_success 'git archive with wildcard pathspec' '
>>
