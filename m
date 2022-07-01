Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8790DC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiGANhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGANhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 09:37:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50D9167F6
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656682657;
        bh=kXXBc9cWqcXlJvzTCv5VwYzVSIVwZt1kLlDQSnWQPxU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Sx4hHbOsqntVjIykheaYJ+5ym76qb9x40duhHAdfWns3UjHtUnKJSNWnOytLqATl/
         jmDoNKLMCar+DrVgxK/rakd8lpi1p/BRdgGZPWL0U/UYEumvS6fWomQcwDkgrSNgrW
         45GS8wXHG3cX3J616uUkWs6dfM/3dWHTIbabaqzM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.204.148] ([213.196.212.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1nnX682o4P-00tUq9; Fri, 01
 Jul 2022 15:37:37 +0200
Date:   Fri, 1 Jul 2022 15:37:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
cc:     git@vger.kernel.org
Subject: Re: Non-interactively rewording commit messages
In-Reply-To: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
Message-ID: <7nrs9832-679s-9s39-56n6-ro31rn84p0o2@tzk.qr>
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NiXXXlseYIM5V2vmgeDAjc5fgw52fEQcBXVlUiuvIooXt7UmkJ6
 mzDYqkTrDP59syqXvbL6ToZMvHxkS6s7LFBGtOhzgVfvkYgxFuUGiBdH9TgODXPw5pzczq4
 WzMZcLAEu/d0QFYx5MTnuVswq25AMqtm+H+mwgZR3Tkq7ZSmmp+TGLzeVG3f2XSDg1KEP7C
 IcIhjjFOYMJVjp9xo+scQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SikxwXYzFEo=:b5Gvi0oc6HMXmm8vUDaH7m
 4OR3xOyYZSou2J1Ua+7xE+OCDRWdkE8P+w2ITz5l5ZKkflJ8To5BBQj3Z8OWTKkbqiW+Q0QSl
 UIggZ8wPWprlQ3t3iXHiorhYIj8lb8uMW1N0DFRFqKLMyWz+9A87lpaXnp0G+R88MJBiEyDND
 kpNEVATzC2dFJDp7OdMurQQEI0YD4zxvUOS6iCTIgYXT6QsGeW1HuHFqI1fqgAT+vDo6KwRR4
 pdWYJHZ3mpiy1iGE66wwOGLo/wd03XPow5OmX/4mzgukEAoj7inadU131efGDt2jUT33MSxpj
 8zqwcQWB1OCBmTzQxexj2+59FEAOyQLsBiObUkkSovJQYds0ikrzn1NWcob9+sR0+c1P+KNbO
 SbqThp1H5AttXn+uN2j/x5K8F3EE5atMSfXVOA2letQmO4z69qWLZNmL94Mz8/4T9oKgKfIbK
 vSwVxw/kAe3mXuK5YtyoUvhBaXRbmgUGt4KDqvqPu4wS+CReDxcH19bEsSTKO7eSBZNs1JqDd
 6MzAtwRvpmzpm2tXAfwSALZDamKWikw5znckxo6JYIyyL54K8+Oq5me9qmbOwUZPyvMrsXA4T
 HMryW/aOQQUgFkF74r2GDRMouw3R7UB00GXyEbnrUqaq65zV4qMgFdbpY7uQLnLRhxkx3oTyH
 dMe/+BlhKlEaHkNlt4362/XH3V/FowGSKBOLE6ziCAp0mwYhfJeB/LSr9EafxHKS1oj4wRuXj
 KW2YpRCZoLwxbwWQuMD7EBuuhxpjWo35nIR8bPv73u6InwzGl7XmeSGQKhGEQ4KI48dtKSIm9
 QfCRhAXyTSBQwIIluXUSExe2+o+YRC+vs51MhQkzzg2hroA8bsK3HqFnsgdMmxFku+uN+5l7R
 RYP9jXZkTNIdY82Yv/WI9P6OAato6JMIyLGUuFErPMLGdwOUIXTX9lWu/h2P2QANmrgrnOkeG
 2zcp+h7lQWCqb8olrQ2iT5tPqAwCf2M4K097cfnI5dZMhCdtohlONZcqOeRA7qqcJ0gISwo+z
 W0PTcWBnYBQW58L7NvX2bWrPd/0Sr9R9ntavqGoMQa5Lw1P5IZnHsivMRAJC4FPcYleQZo697
 661j1m7sbg/OdlZdhgJJg0yHqQohFmadIm9tkZdM2ifXPidAdZ+NmZcbQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konstantin,

On Thu, 30 Jun 2022, Konstantin Ryabitsev wrote:

> What's the best approach to non-interactively rewrite specific commit
> messages? In this particular case, I am trying to automatically retrieve=
 code
> review trailers sent to the mailing list and put them into corresponding
> commits.
>
> For example, I have a set of commits:
>
> abcabc: This commit does foo
> bcdbcd: This commit does bar
> cdecde: This commit does baz
>
> They were all sent to the mailing list and a maintainer sent a "Reviewed=
-by"
> to the second commit. In a usual interactive rebase session this would b=
e:
>
> pick abcabc
> reword bcdbcd
> pick cdecde
>
> When the edit screen comes up for the bcdbcd commit, the author would ma=
nually
> stick the new trailer into the commit message. However, I can automate a=
ll
> that away with b4 -- just need a sane strategy for non-interactively rew=
riting
> entire commit messages at arbitrary points in the recent history.
>
> Any pointers?

The quickest (in terms of script size) might be to craft an `amend!`
commit, something like this:

	git commit --allow-empty -m "$(printf 'amend! bcdbcd\n\n' &&
		git cat-file commit bcdbcd |
		sed -e '1,/^$/d' \
		 -e '{:1;${s/^/Reviewed-by: M A Intainer <maintainer@example.org>\n/;b};=
N;/\n$/b;b1}')"

and then running an "interactive" rebase with `:` as the editor:

	GIT_SEQUENCE_EDITOR=3D: GIT_EDITOR=3D: git rebase -i --autosquash HEAD~3

(The `sed` call is admittedly a bit horrible, it prepends the
`Reviewed-by:` footer to the last paragraph, if it needs to be _appended_,
it can be greatly simplified.)

Ciao,
Dscho
