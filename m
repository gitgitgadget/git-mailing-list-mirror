From: =?UTF-8?B?0J3QuNC60LjRgtCwINCh0L7QsdC+0LvQtdCy?= 
	<n.a.sobolev@gmail.com>
Subject: Re: git-secret - store your private data inside a repository
Date: Mon, 14 Mar 2016 10:22:43 +0300
Message-ID: <CAO_bL1y8tp5+NKdPqpwqJvX2xWY6Wg1oZbnRTKAVjKrg94b3BA@mail.gmail.com>
References: <CAO_bL1xQ0C+HYdZQVvyHx3ByPaaJTgpQYhY7h9f76eQXHKZ_SQ@mail.gmail.com>
	<robbat2-20160313T211905-684299027Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 08:22:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afMq8-0005wD-1O
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 08:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbcCNHWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 03:22:46 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36559 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbcCNHWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 03:22:45 -0400
Received: by mail-io0-f177.google.com with SMTP id z76so212461649iof.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iT/qL9Lyv/3vImRAS8Jn4mknWTqch0x7E5kVoPf6QTY=;
        b=CL5a5M5byARt8T2i6DjQKzCxePBCpuiNUtvZeUTe33WfarRb39F7g8FMONTJcZD4Gu
         qGX51SzGTR6fgLcgTSCWUnN/rvmakx9Mj+pbBMhx+5nWSMbcSoEr0Ebieg0liPGqXm8s
         dmybnpyOtxQ1YijUeRpL/3+IFCZUZrXkLn/9tgp8ISi3gAIeGSWiTH6BJ3nZILtSEKb9
         bj2s5WStOQ92mVOqGSlBZcLB7Cqq/bM9pQo6j2WINvBggaIdrJSu6toO+Xk65eGZe5Sn
         4GsJjYPewQWvia7x22oGSn7GimUGDSaoFB88bM2c6EdI36ruLGxeU2MJnWNI9F0qlO3a
         vktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iT/qL9Lyv/3vImRAS8Jn4mknWTqch0x7E5kVoPf6QTY=;
        b=JnU6ea+DBlEP7zvbTBa4szwvF5ZnVkKdke8X01WS1hCO+mMBl1JZtCpVwPi3g7iMzL
         jYr0/YavMo4CowopgMTluCbPtjVQE5wQHKuIoj9q/oHAmOw9zZx6H+HW58KeO2c4mzxW
         b8Ptr3tP/Px57UHB9rLdN6dfutFiw7cNIpb/D8I1H6a4sUQBFlG7nLob+pnyx1vTaEdP
         /nRK7ohMRkbNuuf13bf7jQ262BzfEs9U4AZCprDziq6mSU8kcWehHWInGyY61mickLoJ
         bOzHiY7WGx+VNFjP1s1+q2WsLyui/KeFKUmNMMuEyvhLtJEmwiK+wd0n5RuIgqi5DNxg
         13dQ==
X-Gm-Message-State: AD7BkJJV6vwKpxpNLYed5pn3TKSrkU95kNy+RSrcWsonNDeVUVaDNoSOYZccd8mzZzvpnl5dgQBa6L4HkNXiOw==
X-Received: by 10.107.13.65 with SMTP id 62mr22817113ion.186.1457940163852;
 Mon, 14 Mar 2016 00:22:43 -0700 (PDT)
Received: by 10.36.15.74 with HTTP; Mon, 14 Mar 2016 00:22:43 -0700 (PDT)
In-Reply-To: <robbat2-20160313T211905-684299027Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288772>

Robin, thank you for interest.

I have not seen 'pwstore' before, but I don't like the idea to store
headers inside the file. As it might break things. But I love the idea
of groups and access rights. It is a direction I would like to follow.
Also I like your suggestion about the key's white-list. That's a
feature I have already planed for the future releases.

I guess 'pass' was made for a single user. But 'git-secret' was made
for multiple people. So you can invite someone to share your encrypted
files and easily remove them. Also, I have noticed that 'pass' stores
the encrypted files in the separate repository. Well, that's an
arguable way to go. It has some benefits like: code-repository and
pass-repository may have different access rights, different people
involved. But there's a lack in consistency when you have two separate
repositories.

2016-03-14 2:52 GMT+03:00 Robin H. Johnson <robbat2@gentoo.org>:
> Have you seen the much older pwstore tool?
> https://github.com/formorer/pwstore
>
> It does have some notable features missing from git-secret and similar
> tools to this day.
> - Whitelist of trusted keys to detect addition of unexpected keys.
> - Specify what users/groups have access to any given file (via a header
>   in each file, which implies that the file must be plaintext).
>
> I've wondered if storing metadata about the objects in notes might
> improve matters:
> - a clearsigned block with verifiable readable data (eg who in a team
>   can access)
> - an encrypted block with the inner key (nice side effect that this
>   separates versioning of the wrapped inner key from the versioning of
>   the object).
>
> This also a nice property that when you revoke/remove an outer (user)
> key, can know implicitly the old secrets they had access to (which
> should probably be rotated, as you don't know if they have a copy of
> them outside of the system).
>
> Yes, I'm aware of other system's like Hashicorp's Vault, but do
> appreciate the simplicity of git-secret, pass [1], pwstore [2] and other
> simpler tools.
>
> [1] https://www.passwordstore.org/
> [2] https://github.com/formorer/pwstore
>     It's at least as old as the Git history indicates, possibly
>         older, I don't know if the Git history included a full conversion of
>         SVN history.
>
> --
> Robin Hugh Johnson
> Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
