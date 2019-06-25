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
	by dcvr.yhbt.net (Postfix) with ESMTP id 701571F4B6
	for <e@80x24.org>; Tue, 25 Jun 2019 09:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfFYJGz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:06:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:43361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbfFYJGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561453610;
        bh=3gmh07Uv7EWd3a+FjZb2g2s2qNt/vxcvaYl1L+mE+MA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FUMS4pHWoM92D+s1uVpISNFsEHdZUTdOC0y1Ywdcejk1S9uPgr7uXSIb7D+l7wvP/
         XdJ2iZ3r35R9STZIIhlfhUNTeS87jvLbm4yqbntveRgN2R6weaDCekIKWou6Euj4gh
         stFx4eoE7+GKHJ559Vm2Ioqu0RIhgf2TqQmdXHRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1iVlR60JAc-00zHCx; Tue, 25
 Jun 2019 11:06:50 +0200
Date:   Tue, 25 Jun 2019 11:07:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/5] t3404: make the 'rebase.missingCommitsCheck=ignore'
 test more focused
In-Reply-To: <20190624181318.17388-3-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251106480.44@tvgsbejvaqbjf.bet>
References: <20190611130320.18499-1-szeder.dev@gmail.com> <20190624181318.17388-1-szeder.dev@gmail.com> <20190624181318.17388-3-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-213627099-1561453631=:44"
X-Provags-ID: V03:K1:8ElyQ5+6GbIbZj5k7jbgcd95SNWq4enXzktZszy64h+2LIHgbfW
 3sBFHdDcWsIjaRDNImHeG2hzw57SzNuiMWJJ6gnTBEaffMW9jksUN+f/i4KdniyOhDwsIC6
 Hin16FM//y22Th4705XJEqJ36qVonNgLfB9xE76a90kNwUZXChDV4VXJa9zhKrMDZ77CoDf
 6/Z2bEKi0BLw5PAPxZhew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PX6noYG6YFk=:CP5lXuNDeql2YejpEQ3pTO
 3Pqis0QgRkkVwR9BWsC5oVB5IFB0MRwl9uGJOXCM1Xuw6NiKj9qoo37EQHlUEWfHBGGAesTDw
 unKsTwTlqONBfW8UER4BInDFj7s9lvEwYel0d9RC+qJKrE1LXJYi4KNgjIfF8cWRZfDnK8mcc
 yC3J+Yryye0NiHSuGzIjUkzNqgjgxeBM3Xzg+W/7Yl4cgLNbI2BMv27TgT+YspBv0ggHqhwmA
 imsRo38nfMn5tuHUQV3L/5QvB3SMAPRYmwM7jp04qNPAaBEvCpKYoARN6nI+q0fGN8vqh7BRK
 /iIkEYyVWZKouaTB78uhARbC4aGOusj+k+hpIcaCuvntW0p0vLehIaxTZHzVHZaUbtX1G4nAP
 P66cGN/+bYNSPauzIEnBIugxxNmWCjFL+sbkH8azpXRnanL5W3Go7oITF46Jk8LJNx2B13IUa
 f+VK7d+i2sobwjl84C9qvOtsocNTnC+3G2RgcKcwfT4y4+t+3y7EfTeU4b4LGGWkro6gW3JBU
 wLUjJCqcHr4UsXoltYfsZbc+SxzhTzmhNe9F8SbLPOZ48EQOroMMgut08fQkFtJbJFgXpqyYC
 TnI2XkOcsLLc4qxHyKceYFoym8PSnj5JNKj9VsNUoPVFliHDYx1oCHre+4uZYzpwnpoE1UYHW
 WNWfS8K0HDpRkYbkZal/26aLKbLDI6DycBodOJuIQpqOFtwwRw8Ts5Hbege0ptoTluQ5Bl68g
 4wh6WoLpQ/lLk7uPiHW7G+DAOkkkxxeutvajU0HbojJ31jDRx1k+lqwzYHTKCpw9eRMD4tUfA
 KhnhuopFL/Yz6QFC5inGMI4AHse4jJIHsPq1IB05LXIFq3bXgjAgWNbqkH7imyfGAzhhjZeQE
 t4qKvBXibPm1a9XcgOp8i7yJe/OB9l56zHdV+rsRlAZNj77j0x/++p32+iT6O62Dr0K5sj86F
 UMEVG/dVFRUF+9PAp5xtts1JqBQnzeBdbBJu3rkRA3sOMTblNkwFd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-213627099-1561453631=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 24 Jun 2019, SZEDER G=C3=A1bor wrote:

> The test 'rebase -i respects rebase.missingCommitsCheck =3D warn' is
> mainly interested in the warning about the dropped commits, but it
> checks the whole output of 'git rebase', including progress lines and
> what not that are not at all relevant to 'rebase.missingCommitsCheck',
> but make it necessary to update this test whenever e.g. the way we
> show progress is updated (as it will happen in one of the later
> patches of this series).
>
> Modify the test to verify only the first four lines of 'git rebase's
> output that contain all the important lines, notably the line
> containing the "Warning:" itself and the oneline log of the dropped
> commit.

Thank you. Looks very good to me,
Dscho

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.=
sh
> index 9146f9d47b..0b8267c97c 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1299,32 +1299,19 @@ test_expect_success 'rebase -i respects rebase.m=
issingCommitsCheck =3D ignore' '
>  		actual
>  '
>
> -cr_to_nl () {
> -	tr '\015' '\012'
> -}
> -
>  test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D =
warn' '
>  	cat >expect <<-EOF &&
>  	Warning: some commits may have been dropped accidentally.
>  	Dropped commits (newer to older):
>  	 - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
>  	To avoid this message, use "drop" to explicitly remove a commit.
> -
> -	Use '\''git config rebase.missingCommitsCheck'\'' to change the level =
of warnings.
> -	The possible behaviours are: ignore, warn, error.
> -
> -	Rebasing (1/4)
> -	Rebasing (2/4)
> -	Rebasing (3/4)
> -	Rebasing (4/4)
> -	Successfully rebased and updated refs/heads/missing-commit.
>  	EOF
>  	test_config rebase.missingCommitsCheck warn &&
>  	rebase_setup_and_clean missing-commit &&
>  	set_fake_editor &&
>  	FAKE_LINES=3D"1 2 3 4" \
>  		git rebase -i --root 2>actual.2 &&
> -	cr_to_nl <actual.2 >actual &&
> +	head -n4 actual.2 >actual &&
>  	test_i18ncmp expect actual &&
>  	test D =3D $(git cat-file commit HEAD | sed -ne \$p)
>  '
> --
> 2.22.0.589.g5bd7971b91
>
>

--8323328-213627099-1561453631=:44--
