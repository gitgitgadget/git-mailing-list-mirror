Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA4C1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 14:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeDCOit (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 10:38:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:59285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbeDCOis (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 10:38:48 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LvUwp-1eKVzF1UMV-010e9h; Tue, 03 Apr 2018 16:38:42 +0200
Date:   Tue, 3 Apr 2018 16:38:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Luciano Joublanc <ljoublanc@dinogroup.eu>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Bad refspec messes up bundle.
In-Reply-To: <CAO+-ZX-DvjsOnpvfPuLkx2w2cR5FDb6Ww8xEyuZHMmC57=b2yQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804031610550.5026@qfpub.tvgsbejvaqbjf.bet>
References: <CAO+-ZX_-COVpzqoAZLRGu4mvLMkLYiR3y7rkCtwmnvJ8kA7txQ@mail.gmail.com> <xmqq370wvugk.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803301102430.5026@qfpub.tvgsbejvaqbjf.bet>
 <CAO+-ZX-DvjsOnpvfPuLkx2w2cR5FDb6Ww8xEyuZHMmC57=b2yQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kI7eG+vgKFbQaFQXxrlKABgdSoul0R3GYhXBYTyQryGUdK01mlG
 vjwK2lkpGRLnPV/67E+HoH+2Lx/tvjGa/HOQYm7ly1ioTlgg6DfxTInxi8cOTqb0va9mbGy
 0PRWCtKamt5ukqp8clkcSIdwB2sRobqJ1zLzIJsMXJsLrojci8hctbvejVggjAMAqlD7H7y
 IpVG1cLU64m2B5ILZDTGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aiWahTtE0WQ=:d8NSRXg9Z1i60iejARhxh9
 K4SJkjZvmFG2b0PJnJg5xtLDDiN8WfltjhKUEqTMmhmRvfF/BHSkBei6i99z3plDCkv910ig3
 coApARuWfhsQ916CBNkJ/kuE/NgacFYVaFweb95uaQJFvOOBZcbw/kAC1Nv2VWHIDiY7WINSl
 w218aGBn/3GHUqcUKI2uoJNXq1v6V3JGM8F2wD+WSvvtMqKE47GklCQfCTixiffjNTLGxkkKO
 q2yZBc+K6hblhfw1Pdnali4uDEIVW+PQ2c+cIs9HpCPxaL9Vk8RNaoPHVRuDXrgh+GFK7whWb
 weZ8zYtgxESE/9+YXcU0Fw9KmW+vo+61Wx9/q35lUveMOBxxlHAs5MenoUxFXKxk5UCnDZHS9
 /MDDnLYQNZERWxrCYr3RDt/thxj1v/OCPRnNBST+OKNIKP8PbTzvMlD2/JV8SrpB1ebnk7W77
 4lLgP/rJ6Ztp4UyrONxxLLlQwebO0gmZgtYLzz1D4/NL+ZTsyC+KV2NaK10kB6V4CxOm7iarP
 7LwOIBQG+snnw2jEwJsmW4Lga3M6N314pom5KsrBZRX8/jpgCLrZwc4JdqyTrUdYIKgRP+D3P
 VkDvNhE1jVLzFGsCljWu/6Vg3I6Jpu3+KP2pXpmyFw8PikN2RQtt0cGoiP/Tz1Z2sdppt2hqH
 Sk+M2WbEc7/qY2Wtbc51juLKDkzG4f4anpE4+m7udWa1QjCEZ5JWoNm1PTGoD3iA3usncwAgj
 xaFwmv81fMV1uj7dKohGyobUtJl4V6105u/SVYp/xyvkbWzZbkhHSxSYpe2x2nSo5Sv1YsS7c
 8kUqJLcjHLzAN79vocILsp/BvcKpSzTNsGvtwWp1riDTgsvF/+ZH6noK3yYxPlBYbsU+F3O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luciano,

On Sat, 31 Mar 2018, Luciano Joublanc wrote:

> I've cloned the `maint` branch, built the project, and added the test
> as you suggested - it's failing as expected.

Excellent.

> On 30 March 2018 at 11:20, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >   However, this would be incorrect, as the flags are stored with the
> >   *commit*, not with the ref. So if two refs point to the same commit,
> >   that new code would skip the second one by mistake!
> 
> Isn't that the point here? to deduplicate commits?  My limited
> understanding is that at a 'ref' is like an alias or pointer to a
> commit.

The point is to deduplicate refs, not commits ;-)

Imagine that you have a git.git clone, and then you work on some topic,
say, `bundle-refs` and then call `git checkout -b bundle-refs-wip` from
there. If you now say

	git bundle create wip.bundle bundle-refs bundle-refs-wip

you will want both bundle-refs and bundle-refs-wip to show up in that
bundle, not just bundle-refs, even if both refs point at the same commit.

> >   By the way, this makes me think that there is another very real bug
> >   in the bundle code, in the part I showed above. Suppose you have a
> >   `master` and a `next` ref, and both point at the same commit, then
> >   you would want `git bundle create next.bundle master..next` to list
> >   `next`, don't you think?
> 
> Doesn't this contradict what you just said, that we don't want to skip
> refs with the same commit #?

I would rather be able to generate such a wip.bundle as outlined above
where calling `git ls-remote wip.bundle` would list *both* refs, with the
same commit.

> In fact, if you look in the calling function, there is a
> `    object_array_remove_duplicates(&revs.pending);`
> Which to the best of my understanding removes duplicate refs (not
> commits). However, I suspect this doesn't cover the `--all` case as
> it's a switch rather than a revspec? Would that be right?

Oh, I missed that!

And I also missed that this is implemented with something *else* than a
hashmap, so it won't have linear complexity but instead quadratic. Gross.

But you got an interesting nugget there, as it indeed tries to
deduplicate, but not by object ID, otherwise the bug you reported would
not occur (but other bugs, as I outlined above).

Instead, the object_array_remove_duplicates() code does this:

-- snip --
void object_array_remove_duplicates(struct object_array *array)
{
        unsigned nr = array->nr, src;
        struct object_array_entry *objects = array->objects;

        array->nr = 0;
        for (src = 0; src < nr; src++) {
                if (!contains_name(array, objects[src].name)) {
                        if (src != array->nr)
                                objects[array->nr] = objects[src];
                        array->nr++;
                } else {
                        object_array_release_entry(&objects[src]);
                }
        }
}
-- snap --

And indeed, the `contains_name()` function iterates through all of the
re-added entries and compares the *name*.

Running this in a debugger shows the culprit, too: there is a
`refs/heads/master`, a `HEAD` and a `master`. Note how the last entry
(which was taken directly from the command-line arguments) lacks the
`refs/heads/` prefix? *That* is the culprit...

> > - most likely, the best way to avoid duplicate refs entries is to use the
> >   actual ref name and put it into a hash set. Luckily, we do have code
> >   for this, and examples how to use it, too. See e.g. fc65b00da7e
> >   (merge-recursive: change current file dir string_lists to hashmap,
> >   2017-09-07). So you would define something like
> 
> Separately, if I do end up including the hashmap code, it should be
> refactored out into it's own file, right?

I do not think that is necessary. Personally, I'd just add the hashmap as
local variable to `write_bundle_refs()`, initialize it before the loop, add
the struct for the hashmap entry and the _cmp function as file-local (i.e.
`static`) function before `write_bundle_refs()`, then add all shown refs
(as stored in the `display_ref` variable) to the hashmap, and add another
conditional `goto skip_write_ref` after all the others, contingent on
`display_ref` *not* being found in the hashmap via
`hashmap_get_from_hash(&displayed_refs, strhash(display_ref),
display_ref)`.

In the same run, I would remove that `object_array_remove_duplicates()`
function altogether, as its only caller is now no longer necessary.

Ciao,
Johannes
