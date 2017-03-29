Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32BA20966
	for <e@80x24.org>; Wed, 29 Mar 2017 07:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbdC2H5B (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 03:57:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58704 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753805AbdC2H5A (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 03:57:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AC4F520D6B;
        Wed, 29 Mar 2017 03:56:58 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 29 Mar 2017 03:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mplew.is; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=yBZngN6UaBfmXFxthP
        RE8zbOw+Ab4DSCnWMink0GONc=; b=F4MoHBkb5pBAbxhEnydoyfwJ0V9eVVARj5
        RTj+8+hecHYueqhOjuYU7mIW1yuVdO2JRZPd3LZlM5BwtsKp9JJh/CxJhEVoqIAe
        H4QhjIBkqzb8ldO2tnGgSGRrRc9TiU8zHoyvDokruk4/djLpDd7TkQ5N59cimExs
        s6Ep4Lyub0uaS1Z+d3i/nTcKBgAUe1AmJI2Ci/5G/RTfkumIjdHqZzcBXr7g2Cdv
        y0kOz2AE5WVyd2N36Iig4m6TNuWRxRsN38yJQIuoSZOgY+/JWNU597NzbrKpVJLp
        1QC2FoKXpzS/S1xkLXyDroDoQW50N4cqoAjLjVrlXJX5UGCNu9kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=yBZngN6UaBfmXFxthPRE8zbOw+Ab4DSCnWMink0GONc=; b=VQUZIXk/
        YEnoMPwVWlWCglAq0WIOPWL710N8BKeDlLT69vM42T8ghhdWHsRf00kC1BJNMJEX
        WpZrYm40PcgLUy2lw5aoJmXXzwyrEdKGlKH9PxPJCG+c052NfN7+kIMf5Pk0ldd/
        p/ELspS+MQ2LUAWnIIbyG1TlCW+NTh++UwOZz0eN14KyxZXjNcm9E3NWK920pr3T
        BUDAxjY4rI/AxlROm/e3MEJZf4EVLmlAOWSUo1eFb5Qouwg5qWhyKDi8hSx9VHEm
        DFit07xcpzis+ZQdjx5XBBlDDNwCxMqCi84b/5jbtmHK9+v0qgoyGaOLBueh9qc4
        xMHV1FI/6qS3Bg==
X-ME-Sender: <xms:ymjbWHSybGRAQw8jaiEN3GXY8aeSISKYdbEHW-b49Rm98QyM1lVQvg>
X-Sasl-enc: mLrQYShnk+by13QNfP3UTpDLPGGrSQ40NpB38LR4W9d/ 1490774218
Received: from [10.0.17.4] (unknown [64.238.189.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E051240B3;
        Wed, 29 Mar 2017 03:56:58 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] contrib/subtree: add "--no-commit" flag for merge and
 pull
From:   Mike Lewis <mike@mplew.is>
In-Reply-To: <20170329073704.vhya5gkwg7j5kchb@gmail.com>
Date:   Wed, 29 Mar 2017 03:56:57 -0400
Cc:     Mike Lewis <mike@mplew.is>, git@vger.kernel.org,
        "David A . Greene" <greened@obbligato.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        James Denholm <nod.helm@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E240B4F0-41D3-4FDB-A2BE-B085CCAAA5B1@mplew.is>
References: <20170326070238.64522-1-mike@mplew.is>
 <20170329073704.vhya5gkwg7j5kchb@gmail.com>
To:     David Aguilar <davvid@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had defaulted it to "--commit" just to make it absolutely clear what =
the default was going to be, since passing the "--commit" flag to =
`git-merge` in this case doesn=E2=80=99t change the existing behavior. =
But you=E2=80=99re right that having the default be blank matches the =
existing style better, so I=E2=80=99ll make a new patch.

Regarding the "--no-no-commit"  I definitely agree it should be that =
way, and my first attempt at this had it that way. However, `git =
rev-parse --parseopt` seems to rewrite "--commit" to "--no-no-commit" =
when it detects the "no-commit" option in the $OPTS_SPEC variable. =
Essentially, you still type the argument as "--commit", but it=E2=80=99s =
rewritten to "--no-no-commit" before it gets to the argument case block, =
as "no-commit" is the only documented option. Documenting both the =
"--commit" and "--no-commit" options in $OPTS_SPEC leads to the expected =
resulting argument, but I wasn't sure if both arguments should be =
documented, as none of the other "default" options (for instance, =
"--no-squash") are documented in the help output. But please let me know =
what your thoughts are, and I'll gladly update my patch.

Mike Lewis

> On 29 Mar 2017, at 03:37, David Aguilar <davvid@gmail.com> wrote:
>=20
> On Sun, Mar 26, 2017 at 03:02:38AM -0400, Mike Lewis wrote:
>> Allows the user to verify and/or change the contents of the merge
>> before committing as necessary
>>=20
>> Signed-off-by: Mike Lewis <mike@mplew.is>
>> ---
>> contrib/subtree/git-subtree.sh | 17 +++++++++++++----
>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/contrib/subtree/git-subtree.sh =
b/contrib/subtree/git-subtree.sh
>> index dec085a23..c30087485 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -29,6 +29,8 @@ onto=3D         try connecting new tree to an =
existing one
>> rejoin        merge the new branch back into HEAD
>>  options for 'add', 'merge', and 'pull'
>> squash        merge subtree changes as a single commit
>> + options for 'merge' and 'pull'
>> +no-commit     perform the merge, but don't commit
>> "
>> eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo =
exit $?)"
>>=20
>> @@ -48,6 +50,7 @@ annotate=3D
>> squash=3D
>> message=3D
>> prefix=3D
>> +commit_option=3D"--commit"
>=20
> It might be simpler to default commit_option=3D empty like the others, =
and
> remove the "" double quotes around "$commit_option" indicated below so
> that the shell ignores it when it's empty.
>=20
>>=20
>> debug () {
>> 	if test -n "$debug"
>> @@ -137,6 +140,12 @@ do
>> 	--no-squash)
>> 		squash=3D
>> 		;;
>> +	--no-commit)
>> +		commit_option=3D"--no-commit"
>> +		;;
>> +	--no-no-commit)
>> +		commit_option=3D"--commit"
>> +		;;
>=20
> "--no-no-commit" should just be "--commit" instead.
> The real flag is called "--commit" (git help merge), so subtree
> should follow suite by supporting "--commit" and "--no-commit" only.
>=20
>=20
>> @@ -815,17 +824,17 @@ cmd_merge () {
>> 	then
>> 		if test -n "$message"
>> 		then
>> -			git merge -s subtree --message=3D"$message" =
"$rev"
>> +			git merge -s subtree --message=3D"$message" =
"$commit_option" "$rev"
>                                                                  ^     =
         ^
>> 		else
>> -			git merge -s subtree "$rev"
>> +			git merge -s subtree "$commit_option" "$rev"
>                                             ^              ^
>> 		fi
>> [...]
>=20
> --=20
> David

