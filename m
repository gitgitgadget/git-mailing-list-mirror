Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4801F461
	for <e@80x24.org>; Fri, 17 May 2019 06:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfEQG4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 02:56:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:37815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfEQG4k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 02:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558076193;
        bh=Mf0/dTvh0g9/Ce13iEtmhKUcYflbWahd5jiMEc5rWMk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a1xKgTlvmBAyCEB3avtBQV3KTkyHCtZd08lh0lNOmI9hrqpLkhj7tgOlvWVDq+Dgb
         PW4HU5Xjlakz0hM9QAOukXeLKchtNrMMX8NaWGOxngR9JizpX1hol7tjlFkKo68k/b
         U7kusR4eRE1wfeEfR3G8zibryeQ5yFqn9aE60zCk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.132.255] ([95.208.59.45]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU0k-1grNA532dY-00aZA1; Fri, 17
 May 2019 08:56:33 +0200
Date:   Fri, 17 May 2019 08:56:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] rebase -r: always reword merge -c
In-Reply-To: <20190502102249.9071-1-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905170855000.46@tvgsbejvaqbjf.bet>
References: <a226ffff-212b-d81c-11fd-bb496b84a78d@gmail.com> <20190502102249.9071-1-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AnsqSLp1Egtec5HKLQctVaTfNNMgeQPO50e0L2i/vNookCBkTD1
 XERpD6SOkg5Gb+4Uf5ZT4wMDm0tZeWz8O9GrNJ0KX7TIQMmzMhwxkQiBoguK8pKJl2qFh8s
 dV3V1MVtcY7hs9U3hGTZKAHSTiOXOCMwT3daH3nVC6cLp1oVaB1OU2YcOthhnXocFy+4JUf
 cBeH88/2Bu6S5eCHTOv2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4QTTgMZZxKc=:YfZ+QXidNZiOeNs0BTZlMP
 dgM3C3s3d1H0QRQhsr7MzfvEdntvlk/A/V9XGXUlf+piTCMpy5MFvE14mBiUAwEm5qQ/JdhNV
 bDg2s/ps9AK8KcZ1AocZhOF7nLw/n+MQ7aSA2dOlWdjROjs+dXPVbmsSDrWt3TgpZVWTX85oL
 7/xbOSW15UyBc8Mr2rVAG8B/nPc8MXdtWEBUNez0p9Qyi2Je/fCqZduqCBR/mH+YM1mkIclh+
 +IVkrE8sVhqB13sV6wlOeTiuPANvUQFu2Iu9jpuzsMvoqv8TQQwbSsd0asQI3ZqPnsEcIScjZ
 yu4kFzybR571mbGuCEBz+gf6Fpsdb7hTApNxo8S5eMkS5wQi7qzI8RsTIauDZ+Pzc1bWUeCEF
 FGAJZQIUhJKUgVbVjvhFXRFtfRWIdWWxG/c6B1E2Uphn/Yv+T2NMHSD/qTEQigxEMeutMitSp
 vdhoH8KBNjd2UrQ/VVU4ldw/kD8Ak8qZHzRImoyB9qvUxogXs4SrIaCcDHE02UhTbHco/o370
 dF59t2ANOcpbxZmDVY77A4hd3DkOP5pblICVbDYQfDHuUKHz5XUDem8W3ziFrnpsEyZjPJb5x
 a/URAZcE6tNvPlsdV27UcpjYogdHiStQr91difxI6cmmBjiBzU8WYjx6y4gLiiVLpcJbLtmJt
 +4JdvvFnHphzkJnbhH/wwqdIVMITgDwIXq+X57Tu12YvaPy4QdBsr96nZZjH2Bpuj99CDC/4u
 7NcSRQiCr7CzVcKSKiq67og0xO6ur7z2OEPITIv8vwNvsaC17QAMpQ4WrOwsnIpisqGVrEzdy
 FlOnt3L7t+MnkjrEEcZr7hm0sKMJBbQTjyRMVn03JDgeYfqynV5qqT8Xuu/yZn9f7zQ+XFvx3
 6YLMmES8nt2tCTT+Fu8agEaHhr/diqhkdEHEhWO/l+L78wkZXtxtDZFMdjvYQ7x/zQeD+I7zi
 hPZjk5j7PIMBFdt8xH+kNa/kgsfHeUH1P5eJ2Bum1lT/SS9ubYZnC
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I think this one fell through the cracks (at least I failed to find it in
`pu`), but I deem it a bug fix worthy of including in v2.22.0.

Ciao,
Dscho


On Thu, 2 May 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If a merge can be fast-forwarded then make sure that we still edit the
> commit message if the user specifies -c. The implementation follows the
> same pattern that is used for ordinary rewords that are fast-forwarded.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> Thanks to Dscho for his comments on v1, I've changed the test as he sugg=
ested.
>
> Range-diff:
> 1:  0532b70644 ! 1:  738799241a rebase -r: always reword merge -c
>     @@ -40,9 +40,12 @@
>
>      +test_expect_success 'fast-forward merge -c still rewords' '
>      +  git checkout -b fast-forward-merge-c H &&
>     -+  set_fake_editor &&
>     -+  FAKE_COMMIT_MESSAGE=3Dedited GIT_SEQUENCE_EDITOR=3D"echo merge -=
c H G >" \
>     -+          git rebase -ir @^ &&
>     ++  (
>     ++          set_fake_editor &&
>     ++          FAKE_COMMIT_MESSAGE=3Dedited \
>     ++                  GIT_SEQUENCE_EDITOR=3D"echo merge -c H G >" \
>     ++                  git rebase -ir @^
>     ++  ) &&
>      +  echo edited >expected &&
>      +  git log --pretty=3Dformat:%B -1 >actual &&
>      +  test_cmp expected actual
>
>  sequencer.c              |  5 +++++
>  t/t3430-rebase-merges.sh | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 0db410d590..ff8565e7a8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3248,6 +3248,10 @@ static int do_merge(struct repository *r,
>  		rollback_lock_file(&lock);
>  		ret =3D fast_forward_to(r, &commit->object.oid,
>  				      &head_commit->object.oid, 0, opts);
> +		if (flags & TODO_EDIT_MERGE_MSG) {
> +			run_commit_flags |=3D AMEND_MSG;
> +			goto fast_forward_edit;
> +		}
>  		goto leave_merge;
>  	}
>
> @@ -3351,6 +3355,7 @@ static int do_merge(struct repository *r,
>  		 * value (a negative one would indicate that the `merge`
>  		 * command needs to be rescheduled).
>  		 */
> +	fast_forward_edit:
>  		ret =3D !!run_git_commit(r, git_path_merge_msg(r), opts,
>  				       run_commit_flags);
>
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 4c69255ee6..01238d4b6e 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -164,6 +164,19 @@ test_expect_success 'failed `merge <branch>` does n=
ot crash' '
>  	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
>  '
>
> +test_expect_success 'fast-forward merge -c still rewords' '
> +	git checkout -b fast-forward-merge-c H &&
> +	(
> +		set_fake_editor &&
> +		FAKE_COMMIT_MESSAGE=3Dedited \
> +			GIT_SEQUENCE_EDITOR=3D"echo merge -c H G >" \
> +			git rebase -ir @^
> +	) &&
> +	echo edited >expected &&
> +	git log --pretty=3Dformat:%B -1 >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'with a branch tip that was cherry-picked already' =
'
>  	git checkout -b already-upstream master &&
>  	base=3D"$(git rev-parse --verify HEAD)" &&
> --
> 2.21.0
>
>
>
