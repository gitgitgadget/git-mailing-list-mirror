Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FDE1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 19:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeJBCAi (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 22:00:38 -0400
Received: from mout.web.de ([212.227.17.11]:41785 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeJBCAi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 22:00:38 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2018 22:00:38 EDT
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iH2-1g1XM50UJQ-00CAX2; Mon, 01
 Oct 2018 21:16:09 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iH2-1g1XM50UJQ-00CAX2; Mon, 01
 Oct 2018 21:16:09 +0200
Subject: Re: What's cooking in git.git (Sep 2018, #04; Thu, 20)
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c5f7009b-53b5-26b9-8a01-b8648ee33a15@web.de>
Date:   Mon, 1 Oct 2018 21:16:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bfBbLx2N8oE+SYdV8BmXs6nE7AbkSJTcBKHizSFFgDV8xNOtyh8
 V/ac/iG3HFWcb/mLap52gyzvQuyxvU/cS9jlz2o9oQm3hFsaKzdstmN/uSK6uFZrR5ceBXF
 /q0pHmK3f/t0XnTl/0FX0P6JqBaPvQvm/n3LHPFteG855MZmRDXgEPFcw6G64PlZB0vIyHM
 nMcyP3+P7DIBbVyOmaihQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kzhmjKdwwAo=:beq/G4iM1zTv6LlqQyCsuY
 L4nTQY8ZkbBS0PTqaaKBneC8xLOhE2j+o/MwCyUNd7MOjxJ4VE+ZGlLQesMqP016EkVmjq5WD
 6gDzZCMuq1kKY3Q+/awsYy6WZUA9BinF2cNrcweRkZuwW8YEspBFYzFJjLGWO6JhnInftk7sN
 11eLIgF5kcWFHApqIHJbMK6MaTHcdu/qFp20zbBIoKwlU0c/0CXLhJb7g+Q2LUShsY+ZNfeZe
 E2i5XEsWchQNACC/tPmN1AUb3VsPHv+IhPnp/PVVpph5ueoD2qL+p5YEIkErIVKt6rJ/3QgEC
 MCFTQiG2Inoupo5eaOJ/R/0QtDhCmQwlU2mVD27CSbrJk8BVM4uCH8/6eQX98QhW1uwfFUhkZ
 2ctnM6O/WvXLlVIPwCUY0OLIzKqyeFNzjDXSGGULAb1qtJHzKag05S1/BvkxDQNZzLoFgnA7K
 IjZBDTYFeZlSY1KQ0ur0uFmqIJGP4hyrC+ToSDeP3fHtW8LvYmem9bOQlJRzkAbUBL84A4En2
 M5LDfNOZYa2LVwxdZlI9Pram7Do2Nw3Rki1F1EPDORRIc2DTh+62lm/8A8EMaQLNA3nP0gznh
 CnEAQMSDSllIcYTTULEbiZmSBy5pqyQWlDCdiPM8fgWLebNUHYSTUOvADIOON1yoJ86/u0vft
 OPOPRPY5nQUtmBLEMj1cI7ubETvuoyh5VYsWE/COMqaRYNa7CDtMe8pvxzg+/QTfcRneJrvhf
 9IT1BGexNbdqEI4gHGfpQU2uA+TYSqD/qiyV5JECMei1DX+JCxMoA3aQgl560rmBLd6mNqQ40
 64KM0NF6GPGv3eqMgE8vuVXpxjHxEKmO2o53K0K9UP0vwptWkw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.2018 um 07:22 schrieb Junio C Hamano:
> * cc/delta-islands (2018-08-16) 7 commits
>   (merged to 'next' on 2018-08-27 at cf3d7bd93f)
>  + pack-objects: move 'layer' into 'struct packing_data'
>  + pack-objects: move tree_depth into 'struct packing_data'
>  + t5320: tests for delta islands
>  + repack: add delta-islands support
>  + pack-objects: add delta-islands support
>  + pack-objects: refactor code into compute_layer_order()
>  + Add delta-islands.{c,h}
> 
>  Lift code from GitHub to restrict delta computation so that an
>  object that exists in one fork is not made into a delta against
>  another object that does not appear in the same forked repository.

> * jk/pack-delta-reuse-with-bitmap (2018-08-21) 6 commits
>   (merged to 'next' on 2018-08-22 at fc50b59dab)
>  + pack-objects: reuse on-disk deltas for thin "have" objects
>  + pack-bitmap: save "have" bitmap from walk
>  + t/perf: add perf tests for fetches from a bitmapped server
>  + t/perf: add infrastructure for measuring sizes
>  + t/perf: factor out percent calculations
>  + t/perf: factor boilerplate out of test_perf
>  (this branch is used by jk/pack-objects-with-bitmap-fix.)
> 
>  When creating a thin pack, which allows objects to be made into a
>  delta against another object that is not in the resulting pack but
>  is known to be present on the receiving end, the code learned to
>  take advantage of the reachability bitmap; this allows the server
>  to send a delta against a base beyond the "boundary" commit.

Not sure if it's the interaction of the two topics or if only one of
them is to blame, but the result of the merge can dereference a NULL
pointer.  Found using Clang's UBSan and t5310.

Here's a patch that avoids the issue, but I don't know if it's the
right thing to do -- should we rather treat a non-existing base as
"not from the same island" instead?

And it's certainly ugly -- that condition is complicated enough
already.  Splitting it up in a nice way would probably help, but how?

---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e6316d294d..9abed4a0f0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1559,7 +1559,8 @@ static void check_object(struct object_entry *entry)
 		    (base_entry = packlist_find(&to_pack, base_ref, NULL)) ||
 		    (thin &&
 		     bitmap_has_sha1_in_uninteresting(bitmap_git, base_ref))) &&
-		    in_same_island(&entry->idx.oid, &base_entry->idx.oid)) {
+		    (!base_entry ||
+		     in_same_island(&entry->idx.oid, &base_entry->idx.oid))) {
 			/*
 			 * If base_ref was set above that means we wish to
 			 * reuse delta data, and either we found that object in
-- 
2.19.0
