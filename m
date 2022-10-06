Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337FBC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 08:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJFIkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJFIkn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 04:40:43 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 01:40:41 PDT
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15C97C772
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665045639; bh=XkCX399LPM/smC/iDWjEw4skRJTxOkY5X/CA0pQGOjQ=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
        b=tXWg+1yZ6/oqT8EYdHX743CMBjJozPyjJFSra6W8qSAlFjtvqFypsdbgutdvHkBIw
         EpFWTyuCAFBjogpygunwKn/colWEFO07PGxRkjTbf+l57NMpKEMAkWVxKWkXXTSNyL
         2SMph3v6HgQ4MfOowca4kHSWJWpCn6Hiork2m5G5XNNZVSBF9EHwA5Bmyvqaic7lQx
         OqxVR/wz2GnFrYQzgXG0KMZuXkHfyJQZJJAUjCyf6khV1j8WRkO1Ir9P/MxK1RhUuC
         ymwcapXDyBhgcuaqfQNiX4K1qFrxZiitT7zC3nmGN5d91QQyyFbU66lb9T635+dp36
         tIuPpPlZgP2Bw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.0.1] ([46.114.149.253]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1oWUzq2xLo-00ABOY; Thu, 06
 Oct 2022 10:35:35 +0200
Date:   Thu, 06 Oct 2022 10:35:32 +0200
From:   Markus Heidelberg <markus.heidelberg@web.de>
To:     Elijah Newren <newren@gmail.com>
CC:     git@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bfilter-repo_PATCH=5D_contrib=3A_new_tool_?= =?US-ASCII?Q?to_convert_svn=3Aexternals_to_Git_submodules?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CABPp-BEyemFxeCG-bmyiugfzCqZp=XbOJKVWrepjeTf9G5yHgQ@mail.gmail.com>
References: <20221005213633.7070-1-markus.heidelberg@web.de> <CABPp-BEyemFxeCG-bmyiugfzCqZp=XbOJKVWrepjeTf9G5yHgQ@mail.gmail.com>
Message-ID: <FCD8CA29-25B8-43B6-8473-5654D9F0D99A@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zmek1qMe8sKMVFhzpY0C3eLxNRyC7gwKQYRvuVQkAEAFDIcLTfS
 mhfwBqdgmLE4+vpe+atWbqvLIwZsZbldQF8niUJFvAtSA2tT28kaVryCCmPqNe22dZRH32C
 SOtdA1GWqlDPPHbw5EYnfzMSYaDR+UwVPiwck7i1hEnsIoBKYkK+o7rE6sFo+TJjp0HoOMi
 l5KOQVXvVBgco0Ty83jYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AQkIUCyZ+qA=:jrJAR06EqkTDHlPA3t94iM
 Kz2noBTJ8l5ZNFAsC1JbjdeheIchHFacTQ7y0W3MTRFGIHfJVcFJl7JAfNWOhzZSHpVHdG5Og
 0M4e4CEUEGPmoH/fXlfrrL84lK+/yHTX/xk9a0KuSeIHbQG4gdg0dnzm6QNvtG3KKb/vBnm+9
 GOzLLvTvOdMuegp2ROPYMhISse4ojhgQNa6k1VJ8Ny2M7lW2WD2PB8RMS8BPkrRLcz9LnaTdv
 Fgg4gkggS8KH5oURAKCIdP38Wg+X0vqWH20g+EHy8GhCy0NXlz/C0mPjMMZTSaz5iEx8oGPp1
 6XzbVcg3wy/IQynoFXAyfk2DabnNXN0eSQN6WK9U9AYtTkKxr0Y2M4Nn0LXr2/ktv7GH/pos1
 +/cfdS5JW+pP1ZiNHEljay7ruQQ+bpodc99mBbKE9ajRJog457kYGQUH3t/LX6uHAi0wVRgpz
 2hoP/6G0eOCH6cLmeCSzrUiKHZWD8E7/FekeQw1nf3rjuicgKmsVAgkDcAtKhwIiffnZLndD6
 9aL4XhcrRBBdrFM9wH7RQaPSCziVfna+H3yYzVGIBZWT9/nfkgR7FDhqnpWDiX4AQdCsqTXPx
 6J4hoFCN8y/AuX4XvztYhqLeeKmskMvFJMnh5y9b3/OE6GK3Ay2OrZ9oKIsstlXdbT59cPWke
 h3xqT3b5KujLat8qctm3Go5xAea/JBUH5gXPPiV8j7GIt4hocAupS5YxfTdEtUPrdV9/i08GF
 DNe5U7uaOTNRRMyXKusPA0wUfbdPwWQcmzALzixEF/s7Z+YklZlPlYzu4Uf8aV1bV9zFaIWbz
 u1cN3BBiW1V4XFrE/lZMJd3bwiOhBMfXHdJe53S3+besxvtEAhbYfIRDU0HwNNlwIt+p8gTHl
 L2ur8sqQ0OE50WhUAoasyAaHzXL0KpmW2tKGk6lTddS6qChqRboG1op2vxgR3gJT1iIzSc4pK
 fa2gODwlf6ePRHcAB64IWNW/R2KVqPqfIX0w5qpRBTaP5tfDtlxDcfc2It3zdYB5x+g70Ao0P
 DxVYXFbRwZgzpUwb3lThD8aQlU9WWyPryPh1jkaxsp9M7nL7WOzUiCjGQ29bsSHJYzMKFijO2
 A2Iwnh17+JyhFQQijAdqYRt0+Ne4GtfR5VU2c9hBu8P85qOJ/sp6jXEflmKjrIZYMAKxjQzrR
 xJAMw9y5YQWQ3MzwHf33jORh60
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 6=2E Oktober 2022 06:04:05 MESZ schrieb Elijah Newren <newren@gmail=2Ec=
om>:
>On Wed, Oct 5, 2022 at 2:37 PM Markus Heidelberg
><markus=2Eheidelberg@web=2Ede> wrote:
>>
>> This is meant to be a post-processing step after SVN-to-Git conversion
>> by SubGit (https://subgit=2Ecom/), which creates a "=2Egitsvnextmodules=
"
>> file that we will use for svn:externals conversion=2E
>>
>> Signed-off-by: Markus Heidelberg <markus=2Eheidelberg@web=2Ede>
>> ---
>>
>> The SVN-to-Git mapping file format might have to be changed in the
>> future when implementing other features, don't know yet=2E At least I
>> wanted to publish this script now that the basics work=2E Maybe there a=
re
>> even some other late-adopters for whose this script might still be
>> useful=2E
>>
>> I'm eager for hints where descriptions/comments are confusing or
>> incomplete=2E
>>
>> This script was already used for migration of an SVN repository in our
>> company=2E
>>
>> Relates to https://github=2Ecom/newren/git-filter-repo/issues/14
>
>Cool, thanks!  It's been a _long_ time since I've used subversion, and
>I never used subversion externals, so there's not a lot of sanity
>checking I can do=2E  Re-reading my comments on that issue from nearly
>three years ago it looks like I dug in a little bit, just enough to
>give some getting started pointers, but I don't even remember writing
>those comments nor what I found=2E  I can verify it sounds like my
>writing, and I hope my comments helped=2E
>
>Anyway, I did give a quick glance over the script, and it seems
>reasonable from a high-level=2E  As I commented in the issue, it seems
>like a nice addition to the contrib examples=2E  So, I've included it=2E
>Thanks!

Oh, that went fast! And your comments definitely helped for implementation=
, I read them several times :)=20

Thanks for inclusion!
