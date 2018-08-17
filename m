Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA5E1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 22:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHRBZR (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 21:25:17 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39988 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeHRBZR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 21:25:17 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so16562253oie.7
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PbV0/5qlgyf4aVZFyJNevd1YZZ3DY8yvGY7Oetsg1w=;
        b=UXKM81c96kgUMBZFyaHXJgEIuhtAbpE17140wMPLLREIB8tH0JGlVn7DMZ5g8y2wx+
         bJ85FxX2nlM6TMPfbfFWV/m2lLfPERjNk/NY3ljXSuYLuXzjX8JD9ggF2Z4WQ21pCCzh
         GbDT2SOPsCI3irZvvUJFW+OeurGfUIuuAMRQvMWPJiIPFJAlQ0XsZ2+XItzAga+FBKnP
         I3V44KV5mCj5SV54N4QtpMm3fzzN5ly74IQcyeG8k7FGjoWrYI+NIEnjZQzvau40Ab30
         vCtLmEm6FlGEVUH6qpt49kztQbhdcrteJmNvFzJKjP2bL+Aa7bi4BbvHDdhv1wyG5IFk
         pHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PbV0/5qlgyf4aVZFyJNevd1YZZ3DY8yvGY7Oetsg1w=;
        b=uXNLoQKwisbAiCyt/v84q3z0agtgHPw3SzxGX/XzpFpZavBdvIUUe0IiCMSxIRxRK4
         ogHPHcDZszNv0FzCIoUJSdpsNTQ8Mmaulg5Xrye1u/lH/Lt4yf/2Bvbg0sDddbSfipJs
         006OB1NZteLz7fETRIoCjfXUtjssk07frWv1LscyabwTRfoCwv6ku3GdjjcQnvCm5q/V
         wQb0vBxn2yCSp9Btuq6ZC5tAze/uia4lP0CgnoU/kJzr23YvnZ1vMDxWn5/J/D5tF/bs
         vwZ9e6Std8chFJuaaaFNfACFWSQGvSNAp9C/B/KBPsN2AIGZuMM9SouDJovJveIq+8Ld
         sraA==
X-Gm-Message-State: AOUpUlGkZHMueLOyqurWL53MkOjsUIOe52Uo9ida3q5eCSg4BaY9X2km
        hU/GktFhoiaSoG+3LFWtiuZ2LGdYdHIYShpXtwk9
X-Google-Smtp-Source: AA+uWPzYQrqKsbQsvoT50WdI3G0QM7nNz/oecD8r0x6IcBROZN10CpWHFkiujhFnIEH0niMOhTtMvDCCO3/yXSUdAqk=
X-Received: by 2002:aca:fc94:: with SMTP id a142-v6mr4069145oii.29.1534544407014;
 Fri, 17 Aug 2018 15:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
 <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com> <CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com>
In-Reply-To: <CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 17 Aug 2018 15:19:54 -0700
Message-ID: <CAMfpvhK3ouxa5H1ZWy_ZrQBjSq_qwavOtLe98SshaUmjTyBQXw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     sbeller@google.com
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 2:42 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Wed, Aug 15, 2018 at 4:23 PM Matthew DeVore <matvore@google.com> wrote:
> >
> > Teach list-objects the "tree:0" filter which allows for filtering
> > out all tree and blob objects (unless other objects are explicitly
> > specified by the user). The purpose of this patch is to allow smaller
> > partial clones.
> >
> > The name of this filter - tree:0 - does not explicitly specify that
> > it also filters out all blobs, but this should not cause much confusion
> > because blobs are not at all useful without the trees that refer to
> > them.
> >
> > I also consider only:commits as a name, but this is inaccurate because
> > it suggests that annotated tags are omitted, but actually they are
> > included.
>
> Speaking of tag objects, it is possible to tag anything, including blobs.
> Would a blob that is tagged (hence reachable without a tree) be not
> filtered by tree:0 (or in the future any deeper depth) ?
I think so. If I try to fetch a tagged tree or blob, it should fetch
that object itself, since I'm referring to it explicitly in the git
pack-objects arguments (I mention fetch since git rev-list apparently
doesn't support specifying non-commits on the command line). This is
similar to how I can fetch a commit that would otherwise be filtered
*if* I specify it explicitly (rather than a child commit).

If you're fetching a tagged tree, then for depth=0, it will fetch the
given tree only, and not fetch any referents of an explicitly-given
tree. For depth=1, it will fetch all direct referents.

If you're fetching a commit, then for depth=0, you will not get any
tree objects, and for depth=1, you'll get only the root tree object
and none of its referrents. So the commit itself is like a "layer" in
the depth count.

>
> I found this series a good read, despite my unfamiliarity of the
> partial cloning.
>
> One situation where I scratched my head for a second were previous patches
> that  use "test_line_count = 0 rev_list_err" whereas using test_must_be_empty
> would be an equally good choice (I am more used to the latter than the former)

Done. Here is an interdiff (sorry, the tab characters are not
maintained by my mail client):

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a1b93c72c..7e2f7ff26 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -200,14 +200,14 @@ test_expect_success 'missing tree objects with
--missing=allow-promisor and --ex
  git -C repo config extensions.partialclone "arbitrary string" &&

  git -C repo rev-list --missing=allow-promisor --objects HEAD >objs
2>rev_list_err &&
- test_line_count = 0 rev_list_err &&
+ test_must_be_empty rev_list_err &&
  # 3 commits, 3 blobs, and 1 tree
  test_line_count = 7 objs &&

  # Do the same for --exclude-promisor-objects, but with all trees gone.
  promise_and_delete $(git -C repo rev-parse baz^{tree}) &&
  git -C repo rev-list --exclude-promisor-objects --objects HEAD >objs
2>rev_list_err &&
- test_line_count = 0 rev_list_err &&
+ test_must_be_empty rev_list_err &&
  # 3 commits, no blobs or trees
  test_line_count = 3 objs
 '
@@ -226,7 +226,7 @@ test_expect_success 'missing non-root tree object
and rev-list' '
  git -C repo config extensions.partialclone "arbitrary string" &&

  git -C repo rev-list --missing=allow-any --objects HEAD >objs
2>rev_list_err &&
- test_line_count = 0 rev_list_err &&
+ test_must_be_empty rev_list_err &&
  # 1 commit and 1 tree
  test_line_count = 2 objs
 '
diff --git a/t/t6112-rev-list-filters-objects.sh
b/t/t6112-rev-list-filters-objects.sh
index 30bf1c73e..27040d73a 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -206,11 +206,11 @@ test_expect_success 'rev-list W/ --missing=print
and --missing=allow-any for tre
  test_cmp expected missing_objs &&

  # do not complain when a missing tree cannot be parsed
- test_line_count = 0 rev_list_err &&
+ test_must_be_empty rev_list_err &&

  git -C r3 rev-list --missing=allow-any --objects HEAD >objs 2>rev_list_err &&
  ! grep $TREE objs &&
- test_line_count = 0 rev_list_err
+ test_must_be_empty rev_list_err
 '

 # Test tree:0 filter.

>
> Thanks,
> Stefan
