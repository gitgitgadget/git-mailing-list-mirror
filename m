Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A931F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 15:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeKTCEy (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 21:04:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35910 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeKTCEy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 21:04:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so49235320qkf.3
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1ceKnjrNtvX+akQeyUpieBTGpNB+qV2J7bXUBLWFyHQ=;
        b=Bm/XrdsXjK2Is315T7Se5clq2nUdokcI6nch1GT+ngSg1/I63Il2gQ7PxJMENSy0ED
         9AZK040jOpzxKG5V7Zg6w7qKW0gFX9eOuGI3O0E3Ivu8qEykE89Q8Vbs7pCZDAwYZGXb
         zMfcf428shxCCFF6+2inI7wcpWO4XupmkWPaipyce71gCqUTLPlRgl8d35hkYJnDoI0S
         CPsINAZIproZLVETmiUsrof/6FNjKygDK3eDFRR724pQW1i40+0WZZoC/oRk6slqlpJB
         I2jfYkMLKeNc28xmFNsuuMlbP2zC9wgQUOEGeqcyYXfMFqFP6EOPwE2D/We7rm0DpNcm
         QFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1ceKnjrNtvX+akQeyUpieBTGpNB+qV2J7bXUBLWFyHQ=;
        b=qpfkk6kkPHDEc2QIPauuC+9iwZh4bqyUPELVpxA8C4+GjOGK9fN5KPO0yBYthrYdgq
         wk06g95dxQLnt9bSYi3p8VqMFdY9LNx+h/SLrzuFSA/9aOQ7LPVE7en08xwVd++FmhjV
         jp0LS0aGkbG3tND2PhrtRQy3C8OhEvLg3Q4U3toQCS2G7Acy+t57TGjDcUpluvQmyaz6
         MIAeDzQBwZc4R7gLXgxBvazfSP2ChclPtTZU9jbDgD4u2+g2cq6YmQMeB5CHgF/NuEYK
         Z844nKePmohDpNPKlhYGzL/cB/ocpncwdM/88tMxHP+gVJFnYFuPYz9krsH1jmmNv9cd
         AUqQ==
X-Gm-Message-State: AGRZ1gKUPam3IMBGVCN3xyg46aWkAYr6PkD7bEf0ChSH8B7P26kk14tg
        BT49bzSww5cx8yYwndyfaeU=
X-Google-Smtp-Source: AJdET5d25x6W6X150MnZuJ2KaCvytwlT7oAIGkIz0AtPTfQJkOeG33Li9ZroOD9B59r59fZHL5j+Jg==
X-Received: by 2002:a37:2881:: with SMTP id o1mr21321499qko.130.1542642055316;
        Mon, 19 Nov 2018 07:40:55 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:85d6:aeeb:c7ff:3261? ([2001:4898:8010:0:6f0c:aeeb:c7ff:3261])
        by smtp.gmail.com with ESMTPSA id x49sm4403428qta.89.2018.11.19.07.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 07:40:54 -0800 (PST)
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
From:   Derrick Stolee <stolee@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
Message-ID: <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
Date:   Mon, 19 Nov 2018 10:40:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test coverage reports started mid-way through this release cycle, so 
I thought it would be good to do a full review of the new uncovered code 
since the last release.

I eliminated most of the uncovered code due to the following cases:

1. Code was only moved or refactored.
2. Code was related to unusual error conditions (e.g. open_pack_index() 
fails)

The comments below are intended only to point out potential directions 
to improve test coverage. Some of it is for me to do!

Thanks,
-Stolee

On 11/18/2018 9:54 PM, Derrick Stolee wrote:
> 66ec0390e7 builtin/fsck.c 888) midx_argv[2] = "--object-dir";
> 66ec0390e7 builtin/fsck.c 889) midx_argv[3] = alt->path;
> 66ec0390e7 builtin/fsck.c 890) if (run_command(&midx_verify))
> 66ec0390e7 builtin/fsck.c 891) errors_found |= ERROR_COMMIT_GRAPH;
>

There are two things wrong here:

1. Not properly covering multi-pack-index fsck with alternates.
2. the ERROR_COMMIT_GRAPH flag when the multi-pack-index is being checked.

I'll submit a patch to fix this.

> 2fa233a554 builtin/pack-objects.c 1512) hashcpy(base_oid.hash, 
> base_sha1);
> 2fa233a554 builtin/pack-objects.c 1513) if 
> (!in_same_island(&delta->idx.oid, &base_oid))
> 2fa233a554 builtin/pack-objects.c 1514) return 0;

These lines are inside a block for the following if statement:

+       /*
+        * Otherwise, reachability bitmaps may tell us if the receiver 
has it,
+        * even if it was buried too deep in history to make it into the
+        * packing list.
+        */
+       if (thin && bitmap_has_sha1_in_uninteresting(bitmap_git, 
base_sha1)) {

Peff: is this difficult to test?

> 28b8a73080 builtin/pack-objects.c 2793) depth++;
> 108f530385 builtin/pack-objects.c 2797) oe_set_tree_depth(&to_pack, 
> ent, depth); 

This 'depth' variable is incremented as part of a for loop in this patch:

  static void show_object(struct object *obj, const char *name, void *data)
@@ -2686,6 +2706,19 @@ static void show_object(struct object *obj, const 
char *name, void *data)
         add_preferred_base_object(name);
         add_object_entry(&obj->oid, obj->type, name, 0);
         obj->flags |= OBJECT_ADDED;
+
+       if (use_delta_islands) {
+               const char *p;
+               unsigned depth = 0;
+               struct object_entry *ent;
+
+               for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
+                       depth++;
+
+               ent = packlist_find(&to_pack, obj->oid.hash, NULL);
+               if (ent && depth > ent->tree_depth)
+                       ent->tree_depth = depth;
+       }
  }

And that 'ent->tree_depth = depth;' line is replaced with the 
oe_set_tree_depth() call in the report.

Since depth is never incremented, we are not covering this block. Is it 
possible to test?

> builtin/repack.c
> 16d75fa48d  48) use_delta_islands = git_config_bool(var, value);
> 16d75fa48d  49) return 0;

This is a simple config option check for "repack.useDeltaIslands". The 
logic it enables is tested, so this is an OK gap, in my opinion.

 > builtin/submodule--helper.c
> ee69b2a90c 1476) out->type = sub->update_strategy.type;
> ee69b2a90c 1477) out->command = sub->update_strategy.command;

This block was introduced by this part of the patch:

+       } else if (sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
+               trace_printf("loaded thing");
+               out->type = sub->update_strategy.type;
+               out->command = sub->update_strategy.command;

Which seems to be an important case, as the other SM_UPDATE_* types seem 
like interesting cases.

Stefan: what actions would trigger this block? Is it easy to test?

> delta-islands.c
> c8d521faf7  53) memcpy(b, old, size);

This memcpy happens when the 'old' island_bitmap is passed to 
island_bitmap_new(), but...

> c8d521faf7 187) b->refcount--;
> c8d521faf7 188) b = kh_value(island_marks, pos) = island_bitmap_new(b);

This block has the only non-NULL caller to island_bitmap_new().

> c8d521faf7 212) obj = ((struct tag *)obj)->tagged;
> c8d521faf7 213) if (obj) {
> c8d521faf7 214) parse_object(the_repository, &obj->oid);
> c8d521faf7 215) marks = create_or_get_island_marks(obj);
> c8d521faf7 216) island_bitmap_set(marks, island_counter);

It appears that this block would happen if we placed a tag in the delta 
island.

> c8d521faf7 397) strbuf_addch(&island_name, '-');

This block is inside the following patch:

+       if (matches[ARRAY_SIZE(matches) - 1].rm_so != -1)
+               warning(_("island regex from config has "
+                         "too many capture groups (max=%d)"),
+                       (int)ARRAY_SIZE(matches) - 2);
+
+       for (m = 1; m < ARRAY_SIZE(matches); m++) {
+               regmatch_t *match = &matches[m];
+
+               if (match->rm_so == -1)
+                       continue;
+
+               if (island_name.len)
+                       strbuf_addch(&island_name, '-');
+
+               strbuf_add(&island_name, refname + match->rm_so, 
match->rm_eo - match->rm_so);
+       }

This likely means that ARRAY_SIZE(matches) is never more than two.


> c8d521faf7 433) continue;
> c8d521faf7 436) list[dst] = list[src];

These blocks are inside the following nested loop in deduplicate_islands():

+       for (ref = 0; ref + 1 < island_count; ref++) {
+               for (src = ref + 1, dst = src; src < island_count; src++) {
+                       if (list[ref]->hash == list[src]->hash)
+                               continue;
+
+                       if (src != dst)
+                               list[dst] = list[src];
+
+                       dst++;
+               }
+               island_count = dst;
+       }

This means that our "deduplication" logic is never actually doing 
anything meaningful.

> entry.c
> b878579ae7 402) static void mark_colliding_entries(const struct 
> checkout *state,

(there is interesting logic in this method, but it is only enabled on 
case-insensitive filesystems. This run was done on a case-sensitive file 
system. Related changes happen in unpack-trees.c.)

> help.c
> 26c7d06783 help.c         500) static int get_alias(const char *var, 
> const char *value, void *data)
> 26c7d06783 help.c         502) struct string_list *list = data;
> 26c7d06783 help.c         504) if (skip_prefix(var, "alias.", &var))
> 26c7d06783 help.c         505) string_list_append(list, var)->util = 
> xstrdup(value);
> 26c7d06783 help.c         507) return 0;
> 26c7d06783 help.c         530) printf("\n%s\n", _("Command aliases"));
> 26c7d06783 help.c         531) ALLOC_ARRAY(aliases, alias_list.nr + 1);
> 26c7d06783 help.c         532) for (i = 0; i < alias_list.nr; i++) {
> 26c7d06783 help.c         533) aliases[i].name = 
> alias_list.items[i].string;
> 26c7d06783 help.c         534) aliases[i].help = 
> alias_list.items[i].util;
> 26c7d06783 help.c         535) aliases[i].category = 1;
> 26c7d06783 help.c         537) aliases[alias_list.nr].name = NULL;
> 26c7d06783 help.c         538) print_command_list(aliases, 1, longest);
> 26c7d06783 help.c         539) free(aliases);

This logic introduces alias help in 'git help -a'. This seems like a 
simple thing for adding a test to ensure that this works now and in the 
future.

>
> http.c
The code in here seems to be logic for Windows-specific SSL backends, so 
is not covered by this report.

> preload-index.c
> ae9af12287  63) struct progress_data *pd = p->progress;
> ae9af12287  65) pthread_mutex_lock(&pd->mutex);
> ae9af12287  66) pd->n += last_nr - nr;
> ae9af12287  67) display_progress(pd->progress, pd->n);
> ae9af12287  68) pthread_mutex_unlock(&pd->mutex);
> ae9af12287  69) last_nr = nr;
> ae9af12287  83) struct progress_data *pd = p->progress;
> ae9af12287  85) pthread_mutex_lock(&pd->mutex);
> ae9af12287  86) display_progress(pd->progress, pd->n + last_nr);
> ae9af12287  87) pthread_mutex_unlock(&pd->mutex);
> ae9af12287 118) pd.progress = start_delayed_progress(_("Refreshing 
> index"), index->cache_nr);
> ae9af12287 119) pthread_mutex_init(&pd.mutex, NULL);
> ae9af12287 132) p->progress = &pd;

There's a lot of stuff going on with showing progress on index writes. 
While the commit message states the progress doesn't show up for 3 
seconds, perhaps that can be tweaked to be in the millisecond range for 
a test?

> read-cache.c

(There's a lot of progress stuff here, too.)

There are a lot of lines introduced by the IEOT extension in these commits:

 > Ben Peart      3255089ad: ieot: add Index Entry Offset Table (IEOT) 
extension
 > Ben Peart      3b1d9e045: eoie: add End of Index Entry (EOIE) extension
 > Ben Peart      77ff1127a: read-cache: load cache entries on worker 
threads
 > Ben Peart      abb4bb838: read-cache: load cache extensions on a 
worker thread
 > Ben Peart      c780b9cfe: config: add new index.threads config setting
 > Ben Peart      d1664e73a: add: speed up cmd_add() by utilizing 
read_cache_preload()
 > Ben Peart      fa655d841: checkout: optimize "git checkout -b 
<new_branch>"

> revision.c
> b45424181e 2951) c->object.flags |= UNINTERESTING;
> b45424181e 2957) mark_parents_uninteresting(c);

These blocks are currently unreachable because we do not use the new 
topo-order logic when there are UNINTERESTING commits. (This will be 
replaced after we have generation numbers v2.) I could force using this 
logic in a `git log --topo-order A..B` query when GIT_TEST_COMMIT_GRAPH 
is enabled.

