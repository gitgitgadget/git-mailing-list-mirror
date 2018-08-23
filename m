Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5034E1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeHXAZS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:25:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:39657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeHXAZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:25:18 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgHHO-1fVLBO0APW-00NgvK; Thu, 23
 Aug 2018 22:53:44 +0200
Date:   Thu, 23 Aug 2018 22:53:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@talktalk.net>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] t/lib-rebase.sh: support explicit 'pick' commands in
 'fake_editor.sh'
In-Reply-To: <20180823100915.22855-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808232253220.73@tvgsbejvaqbjf.bet>
References: <20180619124651.17425-1-phillip.wood@talktalk.net> <20180823100915.22855-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1459482733-1535057624=:73"
X-Provags-ID: V03:K1:Vy9mFQ6B4b0sDYGm/OdROeqqGgX1zTWzQMuHvpgX4tFzGEXwgFV
 sD+0lfFpps4GJYKC6XtH3YaYhv2EByTtyhBK9RQGgjWGetGMyBritoJY4KurhTisvyEITAl
 Jy4+K4pjWMw+0ISAcVnFeVfbjnsyGxHoQZ3AFB1ablIucKamWbV08KvCHD/+9BYWqHkwnn1
 NDM8ABQqkZDqK+4iAzgPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n5UVBS4hQFE=:6DIBIaQUKXDv9jhDlYgFOW
 F89ZKteue2AqP6XHWEk8YYUiop7JAqWt7GgRziXikD2yijlckx0DDmnvdDvVyzBc4w+E4tspv
 nQw+jufDUWX4q9S9sk7CjPQU+lmg6Tdj2ZaxoK7Wt6LqwViaQT+mkrNV/+/XfXAVvhIlDYlkP
 m4CVuXJNDm0QNONLMdlpgiAgalQumfzOBYQczRAzXvbiEJNStO40TIdgPe2ohFTCzyd6WQKDE
 sYREKjTJsR+3y/kyr8FvX0t5/AsS140D7qKekpBLssQrHRZs5jVHScW3ksrJ92n05XMwkhtLO
 0iD662iKDhuLWoRQ/OY+UWMMvAB/19OCcQL/lh/LBib9kD+8ObKwT/APTpi7XQWm0M6RpB0e4
 pubLRT0EGRpbSgfN1NtgiRZfZIt2DqIkHoAnCTQCHQgcgZcctbwtTnIyqkgOJpXXvVgac7uAn
 uA8aV0RSgZ0VGqlKYPTtAbMyXVROfGaco+PyqRbXaD+4XNtuGs05GUJ838wZQYvgR1ElSZAvs
 1iFCqCc9yQDEZbDj23UfizQJWFkMayCth+0ZpJ2PbXWTyrNo7GWS4R75Cz99wskhXPQffpEHT
 ZDFrqBaD2sE5dxKY/pYNoLU6zifCA/m6TSBoPHIJ3kmpZomhXK5Ck8Rb3IjOlQT7aGHa+djsd
 ddYNbVkQLQPZ8RTAPMe2GHNrvTP5O53EHPmXUUwpSL9LEIGgKaFSUEOFIzGgA3Qkc0fK0CH0n
 5yUtO9M/3jg9uA3DA5e4wgb/Rfyq8xHETwaGTBNWgCe+TXToutYRnLuNa+dDYCNjbx+4E0Otx
 NuhjXRa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1459482733-1535057624=:73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Thu, 23 Aug 2018, SZEDER G=C3=A1bor wrote:

> The verbose output of the test 'reword without issues functions as
> intended' in 't3423-rebase-reword.sh', added in a9279c6785 (sequencer:
> do not squash 'reword' commits when we hit conflicts, 2018-06-19),
> contains the following error output:
>=20
>   sed: -e expression #1, char 2: extra characters after command
>=20
> This error comes from within the 'fake-editor.sh' script created by
> 'lib-rebase.sh's set_fake_editor() function, and the root cause is the
> FAKE_LINES=3D"pick 1 reword 2" variable in the test in question, in
> particular the "pick" word.  'fake-editor.sh' assumes 'pick' to be the
> default rebase command and doesn't support an explicit 'pick' command
> in FAKE_LINES.  As a result, 'pick' will be used instead of a line
> number when assembling the following 'sed' script:
>=20
>   sed -n picks/^pick/pick/p
>=20
> which triggers the aforementioned error.
>=20
> Luckily, this didn't affect the test's correctness: the erroring 'sed'
> command doesn't write anything to the todo script, and processing the
> rest of FAKE_LINES generates the desired todo script, as if that
> 'pick' command were not there at all.
>=20
> The minimal fix would be to remove the 'pick' word from FAKE_LINES,
> but that would leave us susceptible to similar issues in the future.
>=20
> Instead, teach the fake-editor script to recognize an explicit 'pick'
> command, which is still a fairly trivial change.
>=20
> In the future we might want to consider reinforcing this fake editor
> script with an &&-chain and stricter parsing of the FAKE_LINES
> variable (e.g. to error out when encountering unknown rebase commands
> or commands and line numbers in the wrong order).
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

ACK!

Thank you very much,
Dscho

> ---
>  t/lib-rebase.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 25a77ee5cb..592865d019 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -47,7 +47,7 @@ set_fake_editor () {
>  =09action=3Dpick
>  =09for line in $FAKE_LINES; do
>  =09=09case $line in
> -=09=09squash|fixup|edit|reword|drop)
> +=09=09pick|squash|fixup|edit|reword|drop)
>  =09=09=09action=3D"$line";;
>  =09=09exec*)
>  =09=09=09echo "$line" | sed 's/_/ /g' >> "$1";;
> --=20
> 2.19.0.rc0.136.gd2dd172e64
>=20
>=20
--8323328-1459482733-1535057624=:73--
