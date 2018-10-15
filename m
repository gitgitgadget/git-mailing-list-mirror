Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FE51F453
	for <e@80x24.org>; Mon, 15 Oct 2018 19:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJPD3v (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 23:29:51 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:39016 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJPD3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 23:29:50 -0400
Received: by mail-qt1-f179.google.com with SMTP id e22-v6so22919854qto.6
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=3dwPeIsovbfFG1xnje9kec0xTLlcM6r7XfDPl9RYHJw=;
        b=q4iQMKiFDkUF/NhSrCQJmKrNqJ3Z7k+E7rJJeVcVZVPIp/I4DFBZStHzRF6tqxpFOs
         Bg0MVd1RYB7kdSltyICo/bsB16INf3yD4XvgELcQhkec61FovWjQdWzjtdYfWQTCZyv9
         Bh3Ph8wDg81XoiwkvAFJAwIHwmT7zGUXQghsBAQulMygog0Zy3sw6XEgmkWzwJB2R9Py
         XN1ihnrOtE8/zIsuhe0BAiKwbVZj93EXlb5Mf4MUTM96fE7L8bMeuMBY/JkJUmwmdtpm
         Y3Fpbgd/rOpTDagZ4WWDSWfabuyMs0X+SdK+fygU+iEcvJXVEXMrE1A0oBOgXtZTEdCj
         C3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3dwPeIsovbfFG1xnje9kec0xTLlcM6r7XfDPl9RYHJw=;
        b=VHNc/SJu/mIM4yVirQuYBJBji5muDAKPHLpzci+m+GmmU4ChLbivF3Y6ZCNakOjnck
         UhPhHjn+rzB7hM2Hk12vM6FkSMuIh4Yz7LmcfNzOLwiXy6FA/WmwwePR6cCUdPD1+HAz
         G2DbdXxs10ib74cQvkrv+oWo6FepOntS7ExPoL2IkPPw2M+pefkDe85+QXn4XBhhgwkv
         k2u3NleyAaPNIRbyNP+JYFhFkKJp0+2N8DyO8AIneJNqk2fsAl8mK2Sy59lfdgBsOxRX
         jruVQMYOdi5N8DhNmvr8DFQIeGZBFqcxhvconYIraj62yp2E/GNb014R+OP6RdUtasTw
         f71g==
X-Gm-Message-State: ABuFfojZPT+ou8JTfbkqHevLFY9rzblPIg4bOBVWHZy9s4NFCp0kH5dg
        d8nb9YDpQqAaof888nS3MGiYAS3S
X-Google-Smtp-Source: ACcGV60CHU1fuGOM8lBHUa1oHyMZZ39Q10MBrHsYbr17eFOgEdUfpEpaQ9idHAdNX6mm5kT2tS7jTw==
X-Received: by 2002:aed:3983:: with SMTP id m3-v6mr18155106qte.164.1539632589925;
        Mon, 15 Oct 2018 12:43:09 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a017:1942:43e1:ced3? ([2001:4898:8010:0:894d:1942:43e1:ced3])
        by smtp.gmail.com with ESMTPSA id c34-v6sm8798277qkh.40.2018.10.15.12.43.08
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:43:09 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Monday, Oct 15)
From:   Derrick Stolee <stolee@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <6be9fe04-138d-01b7-91c1-6c029ab7c9be@gmail.com>
Message-ID: <1f6513e1-24f1-496a-2f3b-6ed6e96b99d1@gmail.com>
Date:   Mon, 15 Oct 2018 15:43:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6be9fe04-138d-01b7-91c1-6c029ab7c9be@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/2018 12:24 PM, Derrick Stolee wrote:
>
> Uncovered code in 'jch' (22f2f0f) and not in 'next' (152ad8e)
> -------------------------------------------------------------
>
> prio-queue.c
> 2d181390f3 94) return queue->array[queue->nr - 1].data;
(I have a fix to cover this in my private branch for this topic.)

>
> revision.c
> 4943d28849 2931) return;
> 4943d28849 2934) return;
> 4943d28849 2937) c->object.flags |= UNINTERESTING;
> 4943d28849 2940) return;
> 4943d28849 2943) mark_parents_uninteresting(c);
> 4943d28849 2966) return;
> 4943d28849 2969) return;
> 4943d28849 2974) return;
> 4943d28849 3022) init_author_date_slab(&info->author_date);
> 4943d28849 3023) info->topo_queue.compare = 
> compare_commits_by_author_date;
> 4943d28849 3024) info->topo_queue.cb_data = &info->author_date;
> 4943d28849 3025) break;
> 4943d28849 3038) continue;
> 4943d28849 3048) record_author_date(&info->author_date, c);
> 6c04ff3001 3086) if (!revs->ignore_missing_links)
> 6c04ff3001 3087) die("Failed to traverse parents of commit %s",
> 4943d28849 3088) oid_to_hex(&commit->object.oid));
> 4943d28849 3096) continue;
Looks like a number of these lines are important to cover, but are not 
covered by tests that _also_ specify '--topo-order'. I bet I can cover 
more of these by overriding the sort logic to use the new algorithm if 
GIT_TEST_COMMIT_GRAPH is specified. Or, should I create yet another test 
variable to cover these cases?

(Note: I run these coverage reports with a variety of optional test 
variables.)

> Uncovered code in 'next' (152ad8e) and not in 'master' (5a0cc8a)
> ----------------------------------------------------------------
> builtin/rev-list.c
> 7c0fe330d5 builtin/rev-list.c 227) die("unexpected missing %s object 
> '%s'",
> 7c0fe330d5 builtin/rev-list.c 228)     type_name(obj->type), 
> oid_to_hex(&obj->oid));
>
> commit-graph.c
> 5cef295f28   67) return 0;
> 20fd6d5799   79) return 0;
These are two ways to say the commit-graph should not be used, but are 
not covered by tests currently. One is if we say "is the repo shallow?" 
which happens to return when the repo has grafts (but we keep the check 
here in case the way shallows are implemented changes) and the other is 
if the repo is not initialized, but I fixed the test-helpers that had 
not initialized the repo yet.
>
> Uncovered code in 'master' (5a0cc8a) and not in (fe8321ec05)
> -----------------------------------------------------------------
> builtin/fsck.c
> 66ec0390e7 builtin/fsck.c 862) midx_argv[2] = "--object-dir";
> 66ec0390e7 builtin/fsck.c 863) midx_argv[3] = alt->path;
> 66ec0390e7 builtin/fsck.c 864) if (run_command(&midx_verify))
> 66ec0390e7 builtin/fsck.c 865) errors_found |= ERROR_COMMIT_GRAPH;
These are underneath the "for all alternates" loop, and _should_ be 
covered with the coming GIT_TEST_MULTI_PACK_INDEX test variable.

Thanks,
-Stolee
