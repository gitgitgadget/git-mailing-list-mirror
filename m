Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D118C32772
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiHVP6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiHVP6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:58:51 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2781713D22
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661183916;
        bh=JGsbg3fy1+5GY1PsaL+k52KjT6CjA4yIni1Yyd/7ZMw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WBN5otOhU6mD0IFGKeH59Nr3rRx2QJ/PNoyK5KcAXMBelofhYLFqONEfjzFvRMow0
         sCHkrB1c82s4j80rfB2lO6O+MQAVrpldgAg/ag+5MGMnKak8kJLWyy22/MYYg5qMtI
         8fLobH3E6WYrfeaScG22ZqDLah2CGPN+XGp4F4FU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.146.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuFD7-1pJufR2U9t-00uHXQ; Mon, 22
 Aug 2022 17:58:36 +0200
Content-Type: multipart/mixed; boundary="------------wlDBucgAKJbvvupqeUAI6NZ8"
Message-ID: <4e3edfa1-9c04-7a63-30ee-65fe6f2de62f@web.de>
Date:   Mon, 22 Aug 2022 17:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: `git patch-id --stable' vs quoted-printable
To:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, meta@public-inbox.org
References: <20220822022503.M873583@dcvr> <xmqqczcsgbvn.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqczcsgbvn.fsf@gitster.g>
X-Provags-ID: V03:K1:EBKnTJUpY2zGTG/fD1tD1X7pVfAiho2uvP1EgFfXUkYZv/dh5Hm
 GH7CK+IcyaS8SCsBEya/lrOCE/LnbEV0z4pjjmCURCGXmKabc5SqSt4KF9Y6SsHO4KqtD4w
 jduEkibJy7Ijlo8iqvkstZ1f6+RnpPoa7UFiHAn5E8DGYHj8JqPXVEvLxdyf/rWZBbKOiwW
 LU3+Q6Dr3z0Y6WGzuC7SA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:feo9T7QsIaw=:+jsAlSqy32ME8nDdFa9H/A
 ndWZaBuyvUa1LDsCVyySHuLxq9I2qnMxFouGN2fbDe7Y6aOjWjzEohmBhckGxgQ8DoneUM4a5
 b8CZ86yUrg6hFyn6Nf0sM6C+w+ii24bmgl1ZpjiLJNxvYG2JUfStc3VotvD064K/efcVjR4DO
 UuZGxjTSF5en/T0nSPavoeooNlo8DOD7IrtG7xuq7gjdw6ITbVnKycLH8RdgG2su7FDIWPybM
 oUKvedx6KVzlVt7+egmN5v+Exxqral4a6vaJomHVw2FpclrToBYrhqs8ZxuZu0RIgkCQWGVY0
 5H9GxNIYo4CmHgtJoFSnu+HinifEhmOVLc+UuamQTk4fCQKCHE41oV7T1m7sfdU6ypZlHJknU
 8Mg9pg+j9rlbotNg7IPtz9rtGSh6Lw3r61C7qJBNJKNSjgIT9NDpMSyJWEd92Q96bun9faNux
 IG58A83xN9DnPc68frff40SOUOxRYq4tKbX8MqOZcz/ZD32c5g6UjAXVLrJ8UrMlXLjcekvM6
 Hp794q64dCG8MwwOWfP6KG6SL1I3sK9b9mYD1/hVcLl1J8E2/KkGKinsyNp67xeoaN6RD6VA8
 98gAwlNbTL7dDKz2h4M6sR4feNJUp888dc6gtpRx7T6lduljNxK5GVTKgU7lw1KZJ/+DG0RXM
 QtuThSFKS2v4ZmrJwDIiQmOmK8Z5en027zSqV7tiX/OJHLJChqoLR6V3arZugSM5r3Z5c+yCO
 d38r6m4Vx9vsVZTLo1zBs/abIj3kBByFDRiHE8DJKQqP1IuaEX1cua2AjCkARv+kQy7oqKPGY
 wdx4y/hVlaiJMpGoi8eI6xJOecv/p/pTNpUIxBIJRZKdYHsdUXvypW3H+JXjmCRNGEN2/M7I8
 aP+C7j1fxLuQvsbup2t5iXAhFghrL+9itQaqqGnD0G7el85Y3DBC8vaJDKUj637YosKehVa5K
 EgCj9+a+aoXHMv0U38u1YCtNINl0nIIwRUQEtFBGSfsa+Dqdwil2GtTyfgTO0CmOBhvkHxp9f
 bdeBnTaYspdoHAFakY3I3miFNhLCH9ejaw+ppT9IrA16CECfIgyoN08pNg3SxrEWL9fd5Qzlt
 k61tXJY/TZXEW2rtRpgGbigUzGAkiu1bAm+
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------wlDBucgAKJbvvupqeUAI6NZ8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 22.08.22 um 06:06 schrieb Junio C Hamano:
> Ren=C3=A9, do you remember if you used diff.suppressBlankEmpty
> configuration when generating the patch in question at:
>
>     https://public-inbox.org/git/6727daf1-f077-7319-187e-ab4e55de3b2d@we=
b.de/raw
>
> by the way?

I did not use that option.  Attached the copy from my Sent folder, which
has spaces at the start of the blank lines in the config.txt hunk.

Ren=C3=A9

--------------wlDBucgAKJbvvupqeUAI6NZ8
Content-Type: message/rfc822; name="[PATCH] revert: optionally refer to commit
 in the \"reference\" format.eml"
Content-Disposition: attachment; filename*0="[PATCH] revert: optionally refer
 to commit in the \"referenc"; filename*1="e\" format.eml"

From - Sun, 26 Jun 2022 09:29:36 GMT
X-Mozilla-Status: 0001
X-Mozilla-Status2: 00800000
Message-ID: <6727daf1-f077-7319-187e-ab4e55de3b2d@web.de>
Date: Sun, 26 Jun 2022 11:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfp2b30k.fsf@gitster.g>
From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqsfp2b30k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 22.05.22 um 06:32 schrieb Junio C Hamano:
> ---
>  Documentation/config/revert.txt |  3 +++
>  Documentation/git-revert.txt    |  9 +++++++++
>  builtin/revert.c                |  2 ++
>  sequencer.c                     | 32 +++++++++++++++++++++++++++-----
>  sequencer.h                     |  1 +
>  t/t3501-revert-cherry-pick.sh   | 31 +++++++++++++++++++++++++++++++
>  6 files changed, 73 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/config/revert.txt
>
> diff --git a/Documentation/config/revert.txt b/Documentation/config/reve=
rt.txt
> new file mode 100644
> index 0000000000..797bfb6d62
> --- /dev/null
> +++ b/Documentation/config/revert.txt
> @@ -0,0 +1,3 @@
> +revert.reference::
> +	Setting this variable to true makes `git revert` to behave
> +	as if the `--reference` option is given.

Shouldn't this be "were" instead of "is"?  Not fully sure.  Anyway:

=2D-- >8 ---
Subject: [PATCH] revert: config documentation fixes

43966ab315 (revert: optionally refer to commit in the "reference"
format, 2022-05-26) added the documentation file config/revert.txt.
Actually include it in config.txt.

Make is used with a bare infinitive after the object; remove the "to".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/config.txt        | 2 ++
 Documentation/config/revert.txt | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e284b042f2..e376d547ce 100644
=2D-- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -495,6 +495,8 @@ include::config/repack.txt[]

 include::config/rerere.txt[]

+include::config/revert.txt[]
+
 include::config/safe.txt[]

 include::config/sendemail.txt[]
diff --git a/Documentation/config/revert.txt b/Documentation/config/revert=
.txt
index 797bfb6d62..802d6faca2 100644
=2D-- a/Documentation/config/revert.txt
+++ b/Documentation/config/revert.txt
@@ -1,3 +1,3 @@
 revert.reference::
-	Setting this variable to true makes `git revert` to behave
+	Setting this variable to true makes `git revert` behave
 	as if the `--reference` option is given.
=2D-
2.36.1

--------------wlDBucgAKJbvvupqeUAI6NZ8--
