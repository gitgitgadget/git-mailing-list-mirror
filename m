Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37D2201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 20:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759353AbdKOUD5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 15:03:57 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:53525 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755597AbdKOUDz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 15:03:55 -0500
Received: by mail-qt0-f173.google.com with SMTP id n61so37187245qte.10
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Rv8ap1nknxGidpWW95wTBbnW0aSWm8NcKivqJMKsiQ=;
        b=CPrrvN0wra7OMS7YPxjVsoAIpfyUxwQZcMDH4X5yhCbq8sHCkOgW65ehGeF0He3bdI
         IkR22c9cyASWjWmAmwpOlHFCZROs7AiyJG8+N2uLK6O2PB2lVenLugNvhtsYlN2J62mW
         YCnsPEB/2xc8UfXHkTYrz2FWS7NffV1PPSSMoVjx7GOT7gOHfQClal4erQukedG8iQAb
         ZE4QdMxHLBDlKmEujFpbXOvzrTpZ/AOctapU5U/sTLfBSfTcnmd8+90Y7jakBXX7miY+
         5ZTHCIgi2DjuLNOBjynzxVRiKv1QOI07hFkJEY6WlqoiKK/i5byYZZaO7/MTCVD0sD6u
         W9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Rv8ap1nknxGidpWW95wTBbnW0aSWm8NcKivqJMKsiQ=;
        b=LEeljPkUcSA7YrSl/GHVY+8a3Ki23oLVKWKAjNN8PEGSr74ADDReMeurvImWpnAYzF
         xiR/VnEHTQcD5a8ZZNt1EGnrMJdQzwv3hxAh0cFxftietCYLx5THVqpIsVS9io1gmJ5z
         twAY8Cp71ESolRSDaeHgwptiWKrblVHGnvHFtpVnCh+a4ep3ELn/pBRw77MnTWIOBRDT
         XhdOx1xlbMvg4x+LKPoDRgx4Nvk7KGSDVkFn6uyr1qov1kAkH9xHkeB4jMoOBgFquVrs
         c7HKpEaAmdBkzzOr0St38EWhtCxR6+l0woBeWWMuGljgAHChozMWIOXsKF+z6rgi8Qtr
         GSSg==
X-Gm-Message-State: AJaThX5iVs/Pt4JXGT1nvkuzpWvJ/BkBjqpGMpv6V2Wz2EibxjyADCri
        iEec5SNspp+9Pe68sWcWv6b69cgUBZ8UTeIU4bB0Uw==
X-Google-Smtp-Source: AGs4zMa7KHKujsQ0ypbBeUs9YVH4KBPH87SJLV1Q+iyHd8Xot3kTZI8otbEE5ezuzs32a2BoIvHoTWli8xLUxSTGSpE=
X-Received: by 10.55.111.3 with SMTP id k3mr25644900qkc.332.1510776234267;
 Wed, 15 Nov 2017 12:03:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 12:03:53 -0800 (PST)
In-Reply-To: <20171110190550.27059-13-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-13-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 12:03:53 -0800
Message-ID: <CAGZ79kb13gGJ6V9d08evHKLvTdTQwcp8VAyzi36BnGn-m5pTXQ@mail.gmail.com>
Subject: Re: [PATCH 12/30] directory rename detection: miscellaneous testcases
 to complete coverage
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:

> +###########################################################################
> +# SECTION 9: Other testcases
> +#
> +# I came up with the testcases in the first eight sections before coding up
> +# the implementation.  The testcases in this section were mostly ones I
> +# thought of while coding/debugging, and which I was too lazy to insert
> +# into the previous sections because I didn't want to re-label with all the
> +# testcase references.  :-)

This might also be commit message material, as it describes the workflow,
not the 'misc' aspect of these test cases.

> +###########################################################################
> +
> +# Testcase 9a, Inner renamed directory within outer renamed directory
> +#   (Related to testcase 1f)
> +#   Commit A: z/{b,c,d/{e,f,g}}
> +#   Commit B: y/{b,c}, x/w/{e,f,g}
> +#   Commit C: z/{b,c,d/{e,f,g,h},i}
> +#   Expected: y/{b,c,i}, x/w/{e,f,g,h}
> +#   NOTE: The only reason this one is interesting is because when a directory
> +#         is split into multiple other directories, we determine by the weight
> +#         of which one had the most paths going to it.  A naive implementation
> +#         of that could take the new file in commit C at z/i to x/w/i or x/i.

Makes sense.

> +# Testcase 9b, Transitive rename with content merge
> +#   (Related to testcase 1c)
> +#   Commit A: z/{b,c},   x/d_1
> +#   Commit B: y/{b,c},   x/d_2
> +#   Commit C: z/{b,c,d_3}
> +#   Expected: y/{b,c,d_merged}

Makes sense.

> +# Testcase 9c, Doubly transitive rename?
> +#   (Related to testcase 1c, 7e, and 9d)
> +#   Commit A: z/{b,c},     x/{d,e},    w/f
> +#   Commit B: y/{b,c},     x/{d,e,f,g}
> +#   Commit C: z/{b,c,d,e},             w/f
> +#   Expected: y/{b,c,d,e}, x/{f,g}
> +#
> +#   NOTE: x/f and x/g may be slightly confusing here.  The rename from w/f to
> +#         x/f is clear.  Let's look beyond that.  Here's the logic:
> +#            Commit C renamed x/ -> z/
> +#            Commit B renamed z/ -> y/
> +#         So, we could possibly further rename x/f to z/f to y/f, a doubly
> +#         transient rename.  However, where does it end?  We can chain these
> +#         indefinitely (see testcase 9d).  What if there is a D/F conflict
> +#         at z/f/ or y/f/?  Or just another file conflict at one of those
> +#         paths?  In the case of an N-long chain of transient renamings,
> +#         where do we "abort" the rename at?  Can the user make sense of
> +#         the resulting conflict and resolve it?
> +#
> +#         To avoid this confusion I use the simple rule that if the other side
> +#         of history did a directory rename to a path that your side renamed
> +#         away, then ignore that particular rename from the other side of
> +#         history for any implicit directory renames.

This is repeated in the rule of section 9 below.
Makes sense.

> +# Testcase 9d, N-fold transitive rename?
> +#   (Related to testcase 9c...and 1c and 7e)
> +#   Commit A: z/a, y/b, x/c, w/d, v/e, u/f
> +#   Commit B:  y/{a,b},  w/{c,d},  u/{e,f}
> +#   Commit C: z/{a,t}, x/{b,c}, v/{d,e}, u/f
> +#   Expected: <see NOTE first>
> +#
> +#   NOTE: z/ -> y/ (in commit B)
> +#         y/ -> x/ (in commit C)
> +#         x/ -> w/ (in commit B)
> +#         w/ -> v/ (in commit C)
> +#         v/ -> u/ (in commit B)
> +#         So, if we add a file to z, say z/t, where should it end up?  In u?
> +#         What if there's another file or directory named 't' in one of the
> +#         intervening directories and/or in u itself?  Also, shouldn't the
> +#         same logic that places 't' in u/ also move ALL other files to u/?
> +#         What if there are file or directory conflicts in any of them?  If
> +#         we attempted to do N-way (N-fold? N-ary? N-uple?) transitive renames
> +#         like this, would the user have any hope of understanding any
> +#         conflicts or how their working tree ended up?  I think not, so I'm
> +#         ruling out N-ary transitive renames for N>1.
> +#
> +#   Therefore our expected result is:
> +#     z/t, y/a, x/b, w/c, u/d, u/e, u/f
> +#   The reason that v/d DOES get transitively renamed to u/d is that u/ isn't
> +#   renamed somewhere.  A slightly sub-optimal result, but it uses fairly
> +#   simple rules that are consistent with what we need for all the other
> +#   testcases and simplifies things for the user.

Does the merge order matter here?
If B and C were swapped, applying the same logic presented in the NOTE,
one could argue that we expect:

    z/t y/a x/b w/c v/d v/e u/f

I can make a strong point for y/a here, but the v/{d,e} also seem to deviate.

> +# Testcase 9e, N-to-1 whammo
> +#   (Related to testcase 9c...and 1c and 7e)
> +#   Commit A: dir1/{a,b}, dir2/{d,e}, dir3/{g,h}, dirN/{j,k}
> +#   Commit B: dir1/{a,b,c,yo}, dir2/{d,e,f,yo}, dir3/{g,h,i,yo}, dirN/{j,k,l,yo}
> +#   Commit C: combined/{a,b,d,e,g,h,j,k}
> +#   Expected: combined/{a,b,c,d,e,f,g,h,i,j,k,l}, CONFLICT(Nto1) warnings,
> +#             dir1/yo, dir2/yo, dir3/yo, dirN/yo

Very neat!

> +# Testcase 9f, Renamed directory that only contained immediate subdirs
> +#   (Related to testcases 1e & 9g)
> +#   Commit A: goal/{a,b}/$more_files
> +#   Commit B: priority/{a,b}/$more_files
> +#   Commit C: goal/{a,b}/$more_files, goal/c
> +#   Expected: priority/{a,b}/$more_files, priority/c

> +# Testcase 9g, Renamed directory that only contained immediate subdirs, immediate subdirs renamed
> +#   (Related to testcases 1e & 9f)
> +#   Commit A: goal/{a,b}/$more_files
> +#   Commit B: priority/{alpha,bravo}/$more_files
> +#   Commit C: goal/{a,b}/$more_files, goal/c
> +#   Expected: priority/{alpha,bravo}/$more_files, priority/c

and if C also added goal/a/another_file, we'd expect it to
become priority/alpha/another_file.

What happens in moving dir hierarchies?

A: root/node1/{leaf1, leaf2}, root/node2/{leaf3, leaf4}
B: "Move node2 one layer down into node1"
    root/node1/{leaf1, leaf2, node2/{leaf3, leaf4}}
C: "Add more leaves"
    root/node1/{leaf1, leaf2, leaf5}, root/node2/{leaf3, leaf4, leaf6}

Or chaining putting things in one another:
(Same A)
B: "Move node2 one layer down into node1"
    root/node1/{leaf1, leaf2, node2/{leaf3, leaf4}}
C: "Move node1 one layer down into node2"
    root/node2/{leaf3, leaf4, node1/{leaf1, leaf2}}

Just food for thought.

> +# Rules suggested by section 9:
> +#
> +#   If the other side of history did a directory rename to a path that your
> +#   side renamed away, then ignore that particular rename from the other
> +#   side of history for any implicit directory renames.
