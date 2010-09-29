From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 03/15] t100[12] (read-tree-m-2way, read_tree_m_u_2way):
 add missing &&
Date: Wed, 29 Sep 2010 11:28:22 -0700
Message-ID: <7v8w2ko14p.fsf@alter.siamese.dyndns.org>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-4-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 20:28:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P11OX-0003KQ-9d
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 20:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab0I2S2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 14:28:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab0I2S2e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 14:28:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67DA9DAD1B;
	Wed, 29 Sep 2010 14:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4FGE5NKnt9XV
	bH5eQLxHE8iFbyc=; b=Iic07GU//CEi6yFnByZnNAQ+4m2NBZx9OE0jFM4mfeAc
	NI7lRQU+hytGzkpXcrfaqJESxSGS+IgFJzyx7yZ3k6OWlNblesvAUReo8Xub//Gm
	cj0lLbr59UCg2N3I2HViUsPA1jHMPxuwtlvmCv6wrGJznzDMvNVrFqhvZLIC+Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OWOgFy
	WK1VMfUzlu73skWPCAUWwyKJjCQBiSR4xulSifl8AtcsvedJEbpuZeJL7pPV/ZdA
	uqPbGRWS21yssWJVgjPqtGYNTDJxkc0+cq5NTUxfqpCpc8wpn1HTVtZvbOKcVSpe
	0muB8G4F794Xsd0tQ7FMc/PaKmjEJHR/Yg62w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FDACDAD18;
	Wed, 29 Sep 2010 14:28:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F38BDAD14; Wed, 29 Sep
 2010 14:28:23 -0400 (EDT)
In-Reply-To: <1285542879-16381-4-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\, 26 Sep 2010 17\:14\:27 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AA1E650-CBF7-11DF-9290-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157587>

Elijah Newren <newren@gmail.com> writes:

> Also, replace "|| return 1" with "&&" in order to keep commands chain=
ed.
>
> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t1001-read-tree-m-2way.sh   |   18 +++++++++---------
>  t/t1002-read-tree-m-u-2way.sh |   10 +++++-----
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.s=
h
> index 93ca84f..ce8112c 100755
> --- a/t/t1001-read-tree-m-2way.sh
> +++ b/t/t1001-read-tree-m-2way.sh
> @@ -98,8 +98,8 @@ test_expect_success \
>       git checkout-index -u -f -q -a &&
>       git update-index --add yomin &&
>       read_tree_twoway $treeH $treeM &&
> -     git ls-files --stage >4.out || return 1
> -     git diff --no-index M.out 4.out >4diff.out
> +     git ls-files --stage >4.out &&
> +     test_might_fail git diff --no-index M.out 4.out >4diff.out &&

Shouldn't this be must-fail, as we are expecting to see some difference=
s?

>       compare_change 4diff.out expected &&
>       check_cache_at yomin clean'
> =20
> @@ -112,8 +112,8 @@ test_expect_success \
>       git update-index --add yomin &&
>       echo yomin yomin >yomin &&
>       read_tree_twoway $treeH $treeM &&
> -     git ls-files --stage >5.out || return 1
> -     git diff --no-index M.out 5.out >5diff.out
> +     git ls-files --stage >5.out &&
> +     test_might_fail git diff --no-index M.out 5.out >5diff.out &&

Ditto.

>       compare_change 5diff.out expected &&
>       check_cache_at yomin dirty'
> =20
> @@ -213,8 +213,8 @@ test_expect_success \
>       echo nitfol nitfol >nitfol &&
>       git update-index --add nitfol &&
>       read_tree_twoway $treeH $treeM &&
> -     git ls-files --stage >14.out || return 1
> -     git diff --no-index M.out 14.out >14diff.out
> +     git ls-files --stage >14.out &&
> +     test_might_fail git diff --no-index M.out 14.out >14diff.out &&

Ditto.

>       compare_change 14diff.out expected &&
>       check_cache_at nitfol clean'
> =20
> @@ -227,8 +227,8 @@ test_expect_success \
>       git update-index --add nitfol &&
>       echo nitfol nitfol nitfol >nitfol &&
>       read_tree_twoway $treeH $treeM &&
> -     git ls-files --stage >15.out || return 1
> -     git diff --no-index M.out 15.out >15diff.out
> +     git ls-files --stage >15.out &&
> +     test_might_fail git diff --no-index M.out 15.out >15diff.out &&

Ditto.

>       compare_change 15diff.out expected &&
>       check_cache_at nitfol dirty'
> =20
> @@ -377,7 +377,7 @@ test_expect_success \
>       git ls-files --stage >treeM.out &&
> =20
>       rm -f a &&
> -     mkdir a
> +     mkdir a &&
>       : >a/b &&
>       git update-index --add --remove a a/b &&
>       treeH=3D`git write-tree` &&
> diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2w=
ay.sh
> index 0241329..a9492e9 100755
> --- a/t/t1002-read-tree-m-u-2way.sh
> +++ b/t/t1002-read-tree-m-u-2way.sh
> @@ -205,8 +205,8 @@ test_expect_success \
>       echo nitfol nitfol >nitfol &&
>       git update-index --add nitfol &&
>       git read-tree -m -u $treeH $treeM &&
> -     git ls-files --stage >14.out || return 1
> -     git diff -U0 --no-index M.out 14.out >14diff.out
> +     git ls-files --stage >14.out &&
> +     test_might_fail git diff -U0 --no-index M.out 14.out >14diff.ou=
t &&

Ditto.

>       compare_change 14diff.out expected &&
>       sum bozbar frotz >actual14.sum &&
>       grep -v nitfol M.sum > expected14.sum &&
> @@ -226,8 +226,8 @@ test_expect_success \
>       git update-index --add nitfol &&
>       echo nitfol nitfol nitfol >nitfol &&
>       git read-tree -m -u $treeH $treeM &&
> -     git ls-files --stage >15.out || return 1
> -     git diff -U0 --no-index M.out 15.out >15diff.out
> +     git ls-files --stage >15.out &&
> +     test_might_fail git diff -U0 --no-index M.out 15.out >15diff.ou=
t &&

Ditto.

>       compare_change 15diff.out expected &&
>       check_cache_at nitfol dirty &&
>       sum bozbar frotz >actual15.sum &&
> @@ -314,7 +314,7 @@ test_expect_success \
>  # Also make sure we did not break DF vs DF/DF case.
>  test_expect_success \
>      'DF vs DF/DF case setup.' \
> -    'rm -f .git/index
> +    'rm -f .git/index &&
>       echo DF >DF &&
>       git update-index --add DF &&
>       treeDF=3D`git write-tree` &&
> --=20
> 1.7.3.95.g14291
