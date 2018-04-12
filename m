Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5EE1F424
	for <e@80x24.org>; Thu, 12 Apr 2018 11:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeDLLyG (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 07:54:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:58049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeDLLyF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 07:54:05 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lq9Ma-1ebwsL35dY-00dlsu; Thu, 12
 Apr 2018 13:54:01 +0200
Date:   Thu, 12 Apr 2018 13:53:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Tiago Botelho <tiago@gitlab.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
In-Reply-To: <CAF2Guqum5dak4us_HJtiW_gL0xgsihgUpidFEJzBgw-tEMunkQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804121341590.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180411225534.48658-1-haraldnordgren@gmail.com> <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com> <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com> <CAP8UFD3j-MGY7jHQK52zVLYMB=1vhCSFKxrvQ1JsRW-Rmnn8Qg@mail.gmail.com>
 <CAF2Guqum5dak4us_HJtiW_gL0xgsihgUpidFEJzBgw-tEMunkQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-695731445-1523534041=:65"
X-Provags-ID: V03:K1:Y+ZFQfLIIjsymRT028qmMPHnlwtcbhM8BCfgKQL9+PRE7VJubDB
 pj5aPRRvv+iXYI5cM45GBySbbU1mnn6uKGwae/O0PrQPUGEsZRb7w3IsuvWW4zqm9E/fCdd
 WvjsPuHzOPDwCj43T2WRkwMnSkif8MUyw4ZPwz+geoov+QJSNcJf6fDAkjgyE8eeCFsCQpV
 xY6TlCRz9KyGMQrE+VLIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X3uYDQrlTJM=:GBUQLvLSNS50WIzpUDdgEC
 po2k1aPtW/CabMgwEZ2gmahHQFSVuVFtUoY02St/2MWAhKDwNC2jKBCo0VmnhtUKzQaQ4NfX2
 sAosHnOo8i12Q2lbjeHXvM9/sm7tsWUu6gasyxHKfCI6GjPE0Anc30GAmVbcHb7yCgFp/mgRn
 gFpfWS7WvaybOr9xpTGCd9Cm7qAQkKlGppS7mzHh9CdYYImytovoZRY0KVrnHWjW27r4pa4Hc
 vX98jpjTK6nXEPvqujSa4kWdVMlgompcNYCKC1XiLA4T3nldKq23Y2sEcIrf2QtwOzLaIpc6O
 C7n74FVtYilGWpy2o5a4fpbHBrymFmQkYF4SfthWw5+xBzk6EWD7G9iHNVWBNakQb8ik4fGE9
 lXtpUPmNaDmMTgfUX0VvRYFa8gHdmbiW1fTZqYKq5chUHNw8MjSiF6Pl2QKVcC2wi6kfnBxy8
 PmxiB5+s6xZapEhXbbyjcFNPnG2UnBgySsRLmHHLQOtLCki6VIxXGH/Elz40BivUo7f+QbF4M
 r1CkiY71yqRaTclcLPneLPQcLOq9RU/9khuKZuAhPw8HqxNdPaCcr9uxN82jWeXdI+dgdMfmL
 acZl3+uFqocpwMev825+IyxjsD2Z0bcMTTfZkt4p0x6RVx1Toz6YZtuV3bOwUrgvkLu4GMwli
 zSx7z42We81VvRxf9W7V3cADgItw5IrWqQXGrkgpdAFKIc6WfcTt6YqXeTAGBqgpMrzTJoY46
 Z0sJr/uiYFfBya6WSz5m7hrBlzWXyfdwVTAA96YNr50L1YhD3NhE2QgNGEn6Z+o2hGLTdZsG7
 JXio5/ttb/7DPeiB5z6C06sfpBly4Ixa5GUUPRWg0BYF5WSWNw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-695731445-1523534041=:65
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tiago,

On Thu, 12 Apr 2018, Tiago Botelho wrote:

> On Thu, Apr 12, 2018 at 9:58 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Thu, Apr 12, 2018 at 9:49 AM, Harald Nordgren
> > <haraldnordgren@gmail.com> wrote:
> >> I think it looks similar. But if I'm reading that thread correctly
> >> then there was never a patch created, right?
> >
> > (It is customary on this mailing list to reply after the sentences we
> > reply to. We don't "top post".)
> >
> > On the GSoC idea pages (like https://git.github.io/SoC-2018-Ideas/) we
> > have been suggesting "Implement git bisect --first-parent" and there
> > are the following related links:
> >
> > https://public-inbox.org/git/20150304053333.GA9584@peff.net/
> > https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/
> >
> > Tiago in Cc also tried at a recent London hackathon to implement it
> > and came up with the following:
> >
> > https://github.com/tiagonbotelho/git/pull/1/files
> >
> > I tried to help him by reworking his commit in the following branch:
> >
> > https://github.com/chriscool/git/commits/myfirstparent
>=20
> Thank you for the cc Christian, I=E2=80=99ve been quite busy and was not =
able
> to work on the PR for quite some time.
>=20
> I intended to pick it back up again next week. If it is ok with Harald
> I would love to finish the PR that I started,
> since it is quite close to being finished (I think it was just specs
> missing if I am not mistaken).

That looks promising. Just like I suggested to Harald in another reply
[*1*] on this thread, you probably want to use `int flags` instead, and
turn `find_all` into BISECT_FIND_ALL in a preparatory commit.

Also, you will definitely want to add a test. Again, my reply to Harald
[*1*] should give you a head start there... You will want to imitate the
test case I outlined there, maybe something like:

# A - B - C - F
#   \   \   /   \
#     D - E - G - H

[... 'setup' as in my mail to Harald ...]

test_expect_success '--first-parent' '
=09write_script find-e.sh <<-\EOF &&
=09case "$(git show --format=3D%s -s)" in
=09B|C|F) ;; # first parent lineage: okay
=09*) git show -s --oneline HEAD >unexpected;;
=09esac
=09# detect whether we are "before" or "after" E
=09test ! -f E.t
=09EOF

=09git bisect start --first-parent HEAD A &&
=09git bisect run ./find-e.sh >actual &&
=09test_path_is_missing unexpected &&
=09grep "$(git rev-parse F) is the first bad commit" actual
'

Also, Tiago, reading through your patch (as on chriscool/git; do you have
your own fork? That would make it much easier to collaborate with you by
offering PRs), it looks more straight-forward than editing the commit_list
after the fact and adding magic weights ;-)

Except for one thing. I wonder why `bisect_next_all()` does not set
revs.first_parent_only after calling `bisect_rev_setup()`? You would still
need the changes in `count_distance()`, as it performs its own commit
graph traversal, but there is no need to enumerate too many commits in the
first place, right?

Harald, maybe --merges-only can be implemented on top of --first-parent,
with the `int flags` change I suggested?

Ciao,
Johannes

Footnote *1*:
https://public-inbox.org/git/nycvar.QRO.7.76.6.1804121143120.65@ZVAVAG-6OXH=
6DA.rhebcr.pbec.zvpebfbsg.pbz/
--8323329-695731445-1523534041=:65--
