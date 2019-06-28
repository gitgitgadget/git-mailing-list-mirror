Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32001F461
	for <e@80x24.org>; Fri, 28 Jun 2019 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfF1NjQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 09:39:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38184 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfF1NjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 09:39:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so10930441edo.5
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vntox4bsl2L1to0rSmmPWs8t408kAu8p+N/OICulnMY=;
        b=ALvERPuSpMpgPBCyU+iPFUenOOoUpZZ7/7DqNdhnZOaEvie+jhiQ7JOh2mbZtOAMw6
         qnt/ucLs5JrBPG4IR6mkoydkHu1Q7iKlZaxdAiYspsZKlQdIYUWZ03BPiNTt49jhxtib
         oVM1Hf/Vema/jHlUqTq1B3R9eoDpCwlMwkNL+i9wOBDQ4EVg8SMTvGb4CIkTydNOBsE8
         oVu1V7R1ZyNcasJ/eP2Fbv3R6c0zQx50Z5LRO1KzUmXzS1pUwhz+6PxSJxLU/Ck0FQmi
         LF5jkxloRXrzQiamLR2IvlIP8K3ReyecwgScGk5dRBaAuYaa+/lcAqZHHcUrz5HakjrU
         9fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vntox4bsl2L1to0rSmmPWs8t408kAu8p+N/OICulnMY=;
        b=r8q7Dm4iQdOOhKj7pXNJdWHlC9WYhaFAJ8SBqlFPB5CeiZlJV6YXFQi1jE6GCL3IL1
         Z02jCuY87ORuS15EXHGNJbXunDLB1ksZhJYzowo/XElgw1q0q/HJjdoWMZttMVlwxzhM
         bxHy7lth11fPx+3TQqgOzMewhbukZqWQxrlbPhlKYExAGdhSTBjrKj53NonAueqQOzuY
         DLAQ6xd5TIegrL2kgfMkJM/nPMTUNRUG6Zci/z7rVAUetMO82xFTzGbwMEp//WnSSasb
         a8wK8m3Gy8g3JEeX8u/mnO7r9ZmP6o7rBg4IPXBve+kvw6X9wd9z5XJ89tPBvmVrdgNU
         aidA==
X-Gm-Message-State: APjAAAVvTj3D8t3vSVWKqT+J9eu91WqYgsf/pt9OchRDrbRyYo3LsgIe
        k5XCgaGl7BlCQ9vGy4IhBUW2KBfIiC4RKNsiNJV8ThJl
X-Google-Smtp-Source: APXvYqwPk0aP5Q9ePHwjHYAlWwsfBtX7H8chaVEvWKA5Q9jOyDPZy7orT7PLbpDvYrl1LTKdu857SzdjPRfqZtK2X6s=
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr8843680ejb.217.1561729154769;
 Fri, 28 Jun 2019 06:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com> <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
In-Reply-To: <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 28 Jun 2019 15:39:03 +0200
Message-ID: <CAP8UFD3VFdCUwDBTb9en22FO7HnWc4vgQ4h0hhariCB=om4b8A@mail.gmail.com>
Subject: Re: Git Test Coverage Report (Thurs. June 27)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 7:35 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Here are some interesting sections I found when examining the test coverage
> report. I am only highlighting these sections because they seem to include
> non-trivial logic. In some cases, maybe the code isn't needed.
>
> On 6/27/2019 1:05 PM, Derrick Stolee wrote:
> > promisor-remote.c
> > db27dca5 25) die(_("Remote with no URL"));
> > 48de3158 61) warning(_("promisor remote name cannot begin with '/': %s"),
> > 48de3158 63) return NULL;
> > faf2abf4 93) previous->next = r->next;
> > 4ca9474e 108) return git_config_string(&core_partial_clone_filter_default,
> > fa3d1b63 139) return 0;
> > 9e27beaa 202) static int remove_fetched_oids(struct repository *repo,
> > 9e27beaa 206) int i, remaining_nr = 0;
> > 9e27beaa 207) int *remaining = xcalloc(oid_nr, sizeof(*remaining));
> > 9e27beaa 208) struct object_id *old_oids = *oids;
> > 9e27beaa 211) for (i = 0; i < oid_nr; i++)
> > 9e27beaa 212) if (oid_object_info_extended(repo, &old_oids[i], NULL,
> > 9e27beaa 214) remaining[i] = 1;
> > 9e27beaa 215) remaining_nr++;
> > 9e27beaa 218) if (remaining_nr) {
> > 9e27beaa 219) int j = 0;
> > 9e27beaa 220) new_oids = xcalloc(remaining_nr, sizeof(*new_oids));
> > 9e27beaa 221) for (i = 0; i < oid_nr; i++)
> > 9e27beaa 222) if (remaining[i])
> > 9e27beaa 223) oidcpy(&new_oids[j++], &old_oids[i]);
> > 9e27beaa 224) *oids = new_oids;
> > 9e27beaa 225) if (to_free)
> > 9e27beaa 226) free(old_oids);
> > 9e27beaa 229) free(remaining);
> > 9e27beaa 231) return remaining_nr;
> > 9e27beaa 248) if (remaining_nr == 1)
> > 9e27beaa 249) continue;
> > 9e27beaa 250) remaining_nr = remove_fetched_oids(repo, &remaining_oids,
> > 9e27beaa 252) if (remaining_nr) {
> > 9e27beaa 253) to_free = 1;
> > 9e27beaa 254) continue;
> > 9e27beaa 262) free(remaining_oids);
>
> Christian: this section continues to be untested, but I think you were
> working on creating tests for this.

Yeah, I am planning to work on this soon.

> > t/helper/test-oidmap.c
> > 11510dec 52) if (get_oid(p1, &oid)) {
> > 11510dec 53) printf("Unknown oid: %s\n", p1);
> > 11510dec 54) continue;
> > 11510dec 58) FLEX_ALLOC_STR(entry, name, p2);
> > 11510dec 59) oidcpy(&entry->entry.oid, &oid);
> > 11510dec 62) oidmap_put(&map, entry);
>
> Christian: this block looks like the test-oidmap helper never uses the "add"
> subcommand. Is that correct?

Yeah, I initially copied it from hashmap, but then I realized that it
was nearly identical as the "put" subcommand, so not worth testing
separately. I should have removed it and will do it soon.

> > 11510dec 97) if (get_oid(p1, &oid)) {
> > 11510dec 98) printf("Unknown oid: %s\n", p1);
> > 11510dec 99) continue;
> > 11510dec 103) entry = oidmap_remove(&map, &oid);
> > 11510dec 106) puts(entry ? entry->name : "NULL");
> > 11510dec 107) free(entry);
>
> Similarly, this block means we are not using the "remove" subcommand.

Yeah, it looks like I forgot to implement a test for that subcommand.
Will add it soon.

Thanks,
Christian.
