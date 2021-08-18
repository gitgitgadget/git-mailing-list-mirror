Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE52C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A04610A0
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhHRKeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:34:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:53817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234775AbhHRKdw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 06:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629282794;
        bh=6cFS8qSp0SuHEEuh1I+7Xb6k2As16FBnOukdHTQFWNA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bylOSBKKcQJrJrVEvZB9g0FNz0elixCYLStc0NpjJvG+ygTk+3wY+5NviKC9wB8uC
         Plsbsz+VNxUOlqVJsGm+8YTf5cbdCNLLEW0CWXTPKFRpOKHJPWdXagC1Bp8hAKsHIK
         cMSG1O/OHL3yAhDnqvXKC4kE5HV4Pohk9YKylL4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1mexWq1HD8-00THNn; Wed, 18
 Aug 2021 12:33:14 +0200
Date:   Wed, 18 Aug 2021 12:33:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] t6300: clear warning when running without gpg
In-Reply-To: <cover.1629263759.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108181231400.55@tvgsbejvaqbjf.bet>
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com> <cover.1629263759.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1013458648-1629282794=:55"
X-Provags-ID: V03:K1:TjtSwJifPMVoHmL6rtEF7QnprSS7Fvw5+xPJv3N/VCiu3/s1j5/
 PjoMvTj6fK21XrDXh3TsNSdgTqB37ApePInf9Kycq2+/gwSPgStdGAncME57fVqLlxZa3So
 cW+TDifnzJDphkG7JP0YS8nQoV74b5wg3qfN2/yyka+xdK96WoWHLHet1Q/qPWb4TJZM8xV
 lrJK2/MVjHphdUXV5nh1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q+RoBvjcLcs=:Th7fkbDJCsCVj34eiu9fQf
 ccRfLHE/qQJG5CW0QzNAVJQP3Ch5c9rY8j6LvlFCAUYHP3UEJ2kcgRBF0VAxrpb787wjaumjc
 UU4tlMT7dC/5FOH0dF1fw3fH7pFMpiyc51esSsVnhHFAXU2zk8zTH9jWxb94hdNzJwdzjPmhX
 39MRxaCNh1GDkuISiDk2W3s2CKxLpfFXhxlnNWJ5/vdzg4E4pvXGuoK/KlmeHwojN2ZtvO2dZ
 BBkGSEGdJgvsYrGc9lxLFOycNw6htIWXf976PmtVEDxYI7BLbrLoiJOXHbbCWlDiyaGGiZFiN
 AGlq6sp++LP7w5peBuKH7cITFoKYfWMl9bffpDMYq31ttJYf+O+7DNGsvVMUaZoFWjouy9a+H
 wuBtFeUI7Ew7ashAGFy6Gj4Tic+bdySlZtZ++ddZqi8+XKFtNfORIgQw/sG0cPa2xJV1rBOml
 cuHmC7hlpI6+y6NRBzXQfZrzmx1nnm9nI2VH6Hull2mS9QVAftTEQdz+Dgj/MshFoyREQUc5H
 XsQbPFIIPvtNG/OqPuociJXmiHY8t7anJvDxKND3U3QdHeswx/s4oiOmn+2XLlI6vg9fMasV7
 Psbwu0rLJygTAp66SOsOdEet/bES7nV3GVcl4fHGY1rJfK/dWDxdu4EFRoL511DgoFhiynvZm
 HLXKTtzPrM4ssVxA+MY6FN8IsVx9Qw1moZkJlShRLoO7QoWs34N0axvw1PmP5qq3IDPDMGpBM
 Op4yP/uUym381O5iRNibRSsYYpP0HJfPJN7Wh9UXVaLS7l3u5quksK7SSJaPGTSv5SrBZfAJS
 K9w/kHwKrQTmdbBH0gXNLv8/I7ndPBa9HuttfHqE1b9cPQ6/muVTIlva1cNlSU+Nt6zkoBuCM
 r/MzLcZWYI4roNrX/Nn3o2xnvP9AQFxugBWbaC65AvmjMlyhst3+EqJ5BN5fQj4mUfBKqlXH6
 p7QX0my/FDELv34BYgA9mSzgPbC2MpFYBZLOzgw70dxiYb82HTp6MeTKLnCpPm9jjkxkk3FAv
 lgAWg75ieq+5KZwzcrjgkFMs/qflfHcqeMDeo3EmQipK89PC0/i8GUd/eWckOpthb+VLSfpdl
 /oULJWWheN0JsnM452+189ctF2zuDoCgvNTxTT4U4hP0n9G4SffwfzEdg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1013458648-1629282794=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Wed, 18 Aug 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

>
> Running t6300 in an environment without gpg(1),
> we'll see those warnings:
>
> 	fatal: Not a valid object name refs/tags/signed-empty
> 	fatal: Not a valid object name refs/tags/signed-short
> 	fatal: Not a valid object name refs/tags/signed-long
>
> Because, those objects will be created only when GPG is satistified.
> This series try to clean those errors.
>
> Change from v1:
> * Make 1/2 as near pure-code-move; and
> * Use 2/2 as a code change to preserve status code for cat-file
> * Mention reasons that 1/2 couldn't be pure-code-move.

Thank you for accommodating my concerns so quickly. The code was still so
present in my mind that I did not have to go back to remind myself, but it
was sufficient to look through the range-diff.

This version happily gets my `Reviewed-by:`.

Thanks,
Dscho

>
> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (2):
>   t6300: don't run cat-file on non-existent object
>   t6300: check for cat-file exit status code
>
>  t/t6300-for-each-ref.sh | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> Range-diff against v1:
> 1:  6d36f3a8df ! 1:  b813d6f2ad t6300: don't run cat-file on non-existen=
t object
>     @@ Commit message
>          * skip their execution if prerequisites aren't satistified.
>          * check their exit status code
>
>     +    The expected value for objects with type: commit needs to be
>     +    computed outside the test because we can't relies on "$3" there=
.
>     +    Furthermore, to prevent the accidental usage of that computed
>     +    expected value, BUG out on unknown object's type.
>     +
>          Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <cong=
danhqx@gmail.com>
>
>       ## t/t6300-for-each-ref.sh ##
>     @@ t/t6300-for-each-ref.sh: test_atom() {
>      -		esac
>      -		# Leave $expect unquoted to lose possible leading whitespaces
>      -		echo $expect >expected
>     ++		# for commit leg, $3 is changed there
>      +		expect=3D$(printf '%s' "$3" | wc -c)
>       		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size"=
 '
>      +			type=3D$(git cat-file -t "$ref") &&
>      +			case $type in
>      +			tag)
>      +				# We cannot use $3 as it expects sanitize_pgp to run
>     -+				git cat-file tag $ref >out &&
>     -+				expect=3D$(<out tail -n +6 | wc -c) ;;
>     ++				expect=3D$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
>      +			tree | blob)
>      +				expect=3D"" ;;
>      +			commit)
> -:  ---------- > 2:  68ee769121 t6300: check for cat-file exit status co=
de
> --
> 2.33.0.rc1
>
>

--8323328-1013458648-1629282794=:55--
