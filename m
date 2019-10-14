Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6AF91F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 12:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfJNMtl (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 08:49:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:45385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731092AbfJNMtl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 08:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571057364;
        bh=b/rDuw+ilrQH23lKH7g2ZS+Hgzv1vb3rceQ8WM1qXbc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cY/lGc8C063qR+CpP5F9QX4hG98DHRjqmvgYZWfHil0IDhtIBm9T/JTNauDi0jIbC
         B/vTTcmqtcj7fPvWoIUj8ZGAO90QMTuxKxg7hYOpxB3a2SEULTO7Isc55Uy9wO2u7V
         wAXbmt4rJrEexQF/yM5rFJM4hmoohDwiGa0ynf/4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1iPm933BT3-007zfs; Mon, 14
 Oct 2019 14:49:24 +0200
Date:   Mon, 14 Oct 2019 14:49:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] Use complete_action's todo list to do the
 rebase
In-Reply-To: <20191007092641.12661-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910141445250.46@tvgsbejvaqbjf.bet>
References: <20190925201315.19722-1-alban.gruin@gmail.com> <20191007092641.12661-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1389144308-1571057144=:46"
Content-ID: <nycvar.QRO.7.76.6.1910141448320.46@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:PoqI0UGSqvRzwFKD6HnKmYmhQ5+Xodnk/tnVZNHHpM7nasoF+1W
 MjzCO76w5K/7YC+xsI/bmeaKg37Sl7vxmv1MV3mwWFaJxKD2Kx8wTs+iZ8ggeReNQUAKNBE
 C73pXhqoX0xD7F+vduVqgR2xhZpUy0IMM+CuA8E3zyF+GLtllboTf6X0RUGA3xpOOv/q7NL
 0wHKIbLFC3FC36iG+dTgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ryo7qAMjPxE=:tsCY7GCRHByA7snmWebTX5
 bz7EiZkR3ZyW9i0FPsNDL6M5L/zAskkLzs9xFbvplY5NOGj4gSV8zZSNPgHSXNTZv9y7tebLA
 0Tv9vFBClwMD1ynJEOBQmFVOvJ21Wovah0q8TRfIvINogvuC8v9g30YtZ/Lok6u7ppLPSIxuP
 LdL+FPcsLMXdr0MfvPBU84tTC4qwUBirqgTCuDL350rnryWESLOz2xHoAGu9LOsu/DLwqAPJL
 EyI5mVoHcfNJreqSzTwI9mJfwWQI3rVVILP+x22+pkCZYI9P31Ti8oydYQ0pfomVUZzV4hWsW
 zPCC0LDoENeS22wB+edL50wtaUDRSJUFmax4qVgpvS6DXsABELjQ0SH17k3yGHeRVXAvaQe1v
 /gGoJgVfUuO5E8wa+XaYaglTGEoxTbo86A2GqTLIZ8qtHgQ4m8wFR+HCphll8gkvf0vLBJ5jK
 aGjHPlTACzSc6WOeKANhL1dMszOljBAUNwydi4g1y6snkE74gocB7LiXaZDS/SOkwzn+6finO
 ZOMAz1uvo+KdR60uAzwryeKaWtUnbe4O9laheTWoVnfKSLrbQs5PWduGllMlPlwPo/QTHZ1SH
 s8sKra4pr1OOEEjXFHnuidRV2tN3aCgsxBombfB6wg0b4b5LaATKMasjPnTX078hmyJu8cy5d
 ei/s8h3e/PNkpjKh4nh7DdrHnH+Kv4CePLK4Z2uamuiJ+2gZ5YHk5dCsbKuAWxUC9Rb8s9YMX
 GOpaKVgNBzbzYVEbiwSFnTkA/zpw0YBGe0tE/Mo8OUX2Ud59pfDwJj+eSpsoLbuqEYkV91tmX
 SBH5a/lIqerluRIFYPraGFuqJQCgtPnoRBYYrvyVPnQ+SPYmN7wnPg+Kex93UhsDNC+HR1Wjw
 btulGNbBAkYRryzwNUf4cMHz2pagIW0Af67Tndx1WiTolHHzMiTrgHx2X0omWT3aE0aXeOthh
 t55hxGC4/NuFtBMG/cqFRedNg9O2fp47gk44Ceh4uoHs2yT4nI5t3e6el30U6nag2oqk2rbO/
 NgIbFLANJLNJP1P3Ny83CoOefGpvqW4mCNAs0jFTYeb92AAE+/EDwom643YfGB0ftxv04SlyQ
 TOxe7Su5lycargHZlp/Wd7XSPUJQgoFmYQEDu4Y0R/GkCSfJngyX5e37F6LPyDpm/O71ovSbX
 ftswjJba1GYzlGy2Sme+2CgtXsfRYAiYL2rIqL7lHDcpDlP/sWk8SG2crYHfgL+KkrkoRGyw+
 gmZ1c/edvbr2UvSrJlo86nqDN8K4/PBXwTTuEr9FozACmQuj9BURwTj78xrc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1389144308-1571057144=:46
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1910141448321.46@tvgsbejvaqbjf.bet>

Hi Alban,

On Mon, 7 Oct 2019, Alban Gruin wrote:

> This can be seen as a continuation of ag/reduce-rewriting-todo.
>
> Currently, complete_action() releases its todo list before calling
> sequencer_continue(), which reloads the todo list from the disk.  This
> series removes this useless round trip.
>
> Patches 1, 2, and 3 originally come from a series meaning to improve
> rebase.missingCommitsCheck[0].  In the original series, I wanted to
> check for missing commits in read_populate_todo(), so a warning could be
> issued after a `rebase --continue' or an `exec' commands.  But, in the
> case of the initial edit, it is already checked in complete_action(),
> and would be checked a second time in sequencer_continue() (a caller of
> read_populate_todo()).  So I hacked up sequencer_continue() to accept a
> pointer to a todo list, and if not null, would skip the call to
> read_populate_todo().  (This was really ugly, to be honest.)  Some
> issues arose with git-prompt.sh[1], hence 1, 2 and 3.
>
> Patch 5 is a new approach to what I did first.  Instead of bolting a new
> parameter to sequencer_continue(), this makes complete_action() calling
> directly pick_commits().
>
> This is based on 4c86140027 ("Third batch").
>
> Changes since v1:
>
>  - Rewording of patches 1, 2, 4 and 5 according to comments made by
>    Phillip Wood, Junio C Hamano and Johannes Schindelin.
>
> The tip of this series is tagged as "reduce-todo-list-cont-v2" at
> https://github.com/agrn/git.
>
> [0] http://public-inbox.org/git/20190717143918.7406-1-alban.gruin@gmail.=
com/
> [1] http://public-inbox.org/git/1732521.CJWHkCQAay@andromeda/
>
> Alban Gruin (5):
>   sequencer: update `total_nr' when adding an item to a todo list
>   sequencer: update `done_nr' when skipping commands in a todo list
>   sequencer: move the code writing total_nr on the disk to a new
>     function
>   rebase: fill `squash_onto' in get_replay_opts()
>   sequencer: directly call pick_commits() from complete_action()
>
>  builtin/rebase.c |  5 +++++
>  sequencer.c      | 26 ++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> Diff-intervalle contre v1=C2=A0:
> 1:  d177b0de1a ! 1:  9215b191c7 sequencer: update `total_nr' when adding=
 an item to a todo list
>     @@ Metadata
>       ## Commit message ##
>          sequencer: update `total_nr' when adding an item to a todo list
>
>     -    `total_nr' is the total amount of items, done and toto, that ar=
e in a
>     -    todo list.  But unlike `nr', it was not updated when an item wa=
s
>     -    appended to the list.
>     +    `total_nr' is the total number of items, counting both done and=
 todo,
>     +    that are in a todo list.  But unlike `nr', it was not updated w=
hen an
>     +    item was appended to the list.
>
>          This variable is mostly used by command prompts (ie. git-prompt=
.sh and
>     -    the like).
>     +    the like).  By forgetting to update it, the original code made =
it not
>     +    reflect the reality, but this flaw was masked by the code calli=
ng
>     +    unnecessarily read_todo_list() again to update the variable to =
its
>     +    correct value.  At the end of this series, the unnecessary call=
 will be
>     +    removed, and the inconsistency addressed by this patch would st=
art to
>     +    matter.
>
>          Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>
> 2:  09fcbe159b ! 2:  7cad541092 sequencer: update `done_nr' when skippin=
g commands in a todo list
>     @@ Commit message
>          or skipped, but skip_unnecessary_picks() did not update it.
>
>          This variable is mostly used by command prompts (ie. git-prompt=
.sh and
>     -    the like).
>     +    the like).  As in the previous commit, this inconsistent behavi=
our is
>     +    not a problem yet, but it would start to matter at the end of t=
his
>     +    series the same reason.
>
>          Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>
> 3:  26a18cd1a9 =3D 3:  7c9c4ddd30 sequencer: move the code writing total=
_nr on the disk to a new function
> 4:  5d74903cfe ! 4:  cd44fb4e10 rebase: fill `squash_onto' in get_replay=
_opts()
>     @@ Metadata
>       ## Commit message ##
>          rebase: fill `squash_onto' in get_replay_opts()
>
>     -    get_replay_opts() did not fill `squash_onto' if possible, meani=
ng that
>     -    this field should be read from the disk by the sequencer throug=
h
>     -    read_populate_opts().  Without this, calling `pick_commits()' d=
irectly
>     -    will result in incorrect results with `rebase --root'.
>     +    Currently, the get_replay_opts() function does not initialise t=
he
>     +    `squash_onto' field (which is used for the `--root' mode), only
>     +    read_populate_opts() does.  That would lead to incorrect result=
s when
>     +    calling pick_commits() without reading the options from the dis=
k first.
>
>          Let=E2=80=99s change that.
>
> 5:  dc803c671f ! 5:  523fdd35a1 sequencer: directly call pick_commits() =
from complete_action()
>     @@ Commit message
>          sequencer: directly call pick_commits() from complete_action()
>
>          Currently, complete_action() calls sequencer_continue() to do t=
he
>     -    rebase.  Even though the former already has the todo list, the =
latter
>     -    loads it from the disk and parses it.  Calling directly pick_co=
mmits()
>     -    from complete_action() avoids this unnecessary round trip.
>     +    rebase.  Before the former calls pick_commits(), it
>     +
>     +     - calls read_and_refresh_cache() -- this is unnecessary here a=
s we've
>     +       just called require_clean_work_tree()
>     +     - calls read_populate_opts() -- this is unnecessary as we're s=
tarting a
>     +       new rebase, so opts is fully populated
>     +     - loads the todo list -- this is unnecessary as we've just pop=
ulated
>     +       the todo list
>     +     - commits any staged changes -- this is unnecessary as we're s=
tarting a
>     +       new rebase, so there are no staged changes
>     +     - calls record_in_rewritten() -- this is unnecessary as we're =
starting
>     +       a new rebase.
>     +
>     +    This changes complete_action() to directly call pick_commits() =
to avoid
>     +    these unnecessary steps.
>
>          Signed-off-by: Alban Gruin <alban.gruin@gmail.com>

This range-diff looks good to me!

I just verified that b2 addresses all the concerns I offered for v1.

Thanks,
Dscho

--8323328-1389144308-1571057144=:46--
