Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F04C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 18:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiKRSD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiKRSDy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 13:03:54 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A178D6F
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:03:51 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:03:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1668794627; x=1669053827;
        bh=Oug5Qs6+HWJKEflXrc9Ds1M4a1+lxC6PdHE++tZXDng=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=bL4YM3KEP3KQ+Szng6TwtiKc7/OYy4AtK9CtlyfjvM4fMCpS3QCxcOOIOdZBqANMJ
         VA52yP+3MCDElB23x5ERp+k7QhKzd9p5iThPD0LWa+ImQ3Rod5VwubQgEJh9UqNugL
         K/XhvGn9JYuqrEB6Kmph/7cKV8P9xx3A+X/L1n+5ZrRkYQe1WSVDigaFSWDNDmuAV7
         ZbLt8ta5FuvPZUe6WN2pQbclDfwGYt4M9DeBJIhx2eusNzj7pgdAnkcD5qFh/bUVKU
         W03xzBaIQBRm7wBdhdcLLEo4f8iKF8I9zaOmluqEPSghrJAOvVsp6yiBOJ6oeZCJha
         tuotZK/Jrep+g==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   David Cowden <dcow@pm.me>
Subject: Re: git-subtree docs missing
Message-ID: <mG2PHaCBIK7N--HeRqPn3Vn9Dc7MzTiahRjTxZq9_7T7UWF1YN1LT4wVeDSpFABOyeH-YjXGRMq8HVE_VFOBOYvkdwBNwhS3eDyGkqW-0Nw=@pm.me>
In-Reply-To: <MzUvo2TfR7gGs7FQsyF-0TqfSNT6X_9eZlBkFBDoa2IrpnT81MYqhNJUKh_aSsNJaH0HrM9PeoQhx6LMlFy3bd3bVCo9aqlT_7Ul-wE6LkE=@pm.me>
References: <MzUvo2TfR7gGs7FQsyF-0TqfSNT6X_9eZlBkFBDoa2IrpnT81MYqhNJUKh_aSsNJaH0HrM9PeoQhx6LMlFy3bd3bVCo9aqlT_7Ul-wE6LkE=@pm.me>
Feedback-ID: 9064091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This might be an issue with my search engine. It returns results for https:=
//git-scm.com/docs/git-subtree when I search `git-subtree`. However I'm now=
 aware that `git-subtree` is part of contrib and not officially part of git=
 so my expectations for finding documentation there may be wrong.


------- Original Message -------
On Friday, November 18th, 2022 at 10:56 AM, David Cowden <dcow@pm.me> wrote=
:


>=20
>=20
> What happened to the git-subtree docs on git-scm.com? https://git-scm.com=
/docs/git-subtree currently redirects to https://git-scm.com/docs.
>=20
> David
