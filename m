Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F3C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiKRLjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiKRLjI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:39:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD98774CEF
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668771543; bh=d0hxiukUBR+h1ADOc1xn8lkb7a4FXOL+STEXbFbMUFU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=p70n1/n2IlBzsaoXZA4rO7w6gxvyj6tBhJsBkipRbzy/hrbSZ87EDVe60hCVWUwnJ
         Rjg0PXfOFXyqdKywbxC+sa/0MD213ldo8zvDUT/6Y92R2ssxXgLICSy9LMgz/Vinlm
         De+L3EoAg+ujcO6Ckqb6bRyVZe4jb7m71rmYGjtrHQc1NsDTNPcq6zVcZccyb/ZI5y
         e512RtrSJZn6Rz8pTSDXId/AAz03HmzqOkBqCjlGXC3RZdVeYGr8pHaGZzCW5GGXln
         DVCuDS/2JAjHsnML80z98HKBVVglKDBVua9WWN4U7G/EI5odvib2BkdO/+gCqh/wUR
         /LswTstIf/kzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1ohOr41rtN-00Eawj; Fri, 18
 Nov 2022 12:39:03 +0100
Date:   Fri, 18 Nov 2022 12:39:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] range-diff: support reading mbox files
In-Reply-To: <221117.86leo9h20m.gmgdl@evledraar.gmail.com>
Message-ID: <6590112p-1n6o-4413-n805-0pp6o9r1r3sn@tzk.qr>
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com> <221117.86leo9h20m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1269912496-1668771543=:189"
X-Provags-ID: V03:K1:Xo+0VbyIzc9Hyn/02iu4gU014fvgzrwaJmbFn5DLYuzNViBdy0G
 ggJo9GFrNQtSvgFT5OXAjYB49LAa746CB+gXbKcvoTYsPwcWS7wNjP8Ylce0njv7eiBPGuH
 IuCIWaGNIRLMOuujgXs//Q0FmxR5s0PIkua1S8Zyu0BUk69XCkxn4lKf8fbXqL0wHviAPJi
 wG0Q4apVYU6kdMKAeZ2aw==
UI-OutboundReport: notjunk:1;M01:P0:2KAt3WfAVlY=;khI1Js9JP1ga6NML7kAXeOTcHeH
 p+zRhShk+RCcb4/ghMVHRWT4mGFWkJC25IB6AMYa6fHTaM+MWzicOx9VbsDcs3Y3X2NBa2LVH
 eWpCnpAFNMhp+lvmaoKu7SNVRb/74lwMisJNiYMA+hZ9u01hixWtHhws1HGxJywedTlHo9vAj
 vnA43Kn/iIBnNBpQoGk8bmHoiZl2FFbiu2e2dNYvpD/ROuA4RsWLDXyesl3Q2JjPp5qloQQVZ
 CU44xeA+4MmNJjfzj9CXf9nveh3RUDf7AmvTKz2qdsSE6sTZfIhnUFOJa3T+rxAK+io0g9PfF
 1ZFLp2kSTIpuDXwqzYkBcsHiqHsyX+/wrzKqsMaz8CpWvGbnOoDFWDtisnIQWWW7mpeZaw1uU
 Ol0/1HtvMB37iM68w7Muql74vXJ0GmCrXqL4LQE5Iuj66PQ6N1xoiW3w/a7HRFdYdCkDUJ9ib
 uDqn9w4JlQXW34UUgDZvdFRUoczOskn9LwpmaMGBXWipFcmtofSZyd2WmQj4OokxbZIeH0jdA
 3N0sisBNsK7ycb3XfDQSutm/5cUQ+isGyg+GJy8NqDBpfauxN8hv57si+Vzjfyk8uQGbGX/9n
 dSrrxYuo2mEx3oKWBKtTpIy5Uq2gmjSsFRoBMtri8j8aC7IZv9n4oR43eJc4VlscSzXkQFMlw
 xIXDy0FfaoW88uvQr5HsmukD+i7M5keu3/0jm2/LsTIvXGgzlNQizV0IjxhbNAJvcyKmSqCsX
 +qcwIHKtWPyyQQvhKc5PP1GdZ+aoYCRX9o9PN0eb4xg4wYYqf2TaucBI/FfCLJDAACSFGRrF8
 u4u6+GFwF990gGPjs3qk6rAhukXmmvck+dFpTDfcVfkgjCYmlLT+atp8BnBFB4zf7ocAYABkU
 9wQ1VrNDyGJEv/h1fSJ1ULXc8BzqWxUMdSFo58tKtPAyYsWMZpdXQCJYW07vXAOuK8ODGU3l1
 er4LZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1269912496-1668771543=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 17 Nov 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Tue, Nov 15 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > +		if (starts_with(line, "diff --git ")) {
> > +			struct patch patch =3D { 0 };
> > +			struct strbuf root =3D STRBUF_INIT;
> > +			int linenr =3D 0;
> > +			int orig_len;
> > +
> > +			state =3D MBOX_IN_DIFF;
> > +			old_count =3D new_count =3D 0;
> > +			strbuf_addch(&buf, '\n');
> > +			if (!util->diff_offset)
> > +				util->diff_offset =3D buf.len;
> > +			line[len - 1] =3D '\n';
> > +			orig_len =3D len;
> > +			len =3D parse_git_diff_header(&root, &linenr, 1, line,
> > +						    len, size, &patch);
>
> Try this with SANITIZE=3Dleak, e.g. this seems to fix 1/4 leaks that pop
> up if you try the command noted in the patch:
>
> 	diff --git a/range-diff.c b/range-diff.c
> 	index 77fa9b970b1..7ff33f92e39 100644
> 	--- a/range-diff.c
> 	+++ b/range-diff.c
> 	@@ -142,6 +142,7 @@ static int read_mbox(const char *path, struct strin=
g_list *list)
> 	 			orig_len =3D len;
> 	 			len =3D parse_git_diff_header(&root, &linenr, 1, line,
> 	 						    len, size, &patch);
> 	+			free(patch.def_name);
> 	 			if (len < 0) {
> 	 				error(_("could not parse git header '%.*s'"),
> 	 				      orig_len, line);

Thank you for keeping your feedback concise. Much appreciated.

This will be addressed in the next iteration,
Johannes

--8323328-1269912496-1668771543=:189--
