From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Draft of Git Rev News edition 6
Date: Mon, 3 Aug 2015 10:10:51 +1000
Message-ID: <CAH5451mJBPt37JAjrB3CxOxJyig_3VctitEXrHXUyQPCWQnNow@mail.gmail.com>
References: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nicola Paolucci <nick@durdn.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 02:11:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZM3Ls-0006rZ-4b
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 02:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbbHCALb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 20:11:31 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34628 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbHCALb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 20:11:31 -0400
Received: by igk11 with SMTP id 11so62144235igk.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 17:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uYPz0HbPX+/Ti1521HpF3pqzDrAMLJbQ/PnXbYkTE4U=;
        b=k6l8/UPGH3fE/TRP4+GMmXVwFeO+h9Ao85nrzov3Y3IuppksAeVpyunmPYxkNxMiim
         7ViXOCQ9uytnlHbzQlHwcVdc1erEpZe6DoY73DweuF9njSen33fsNGpqiWvEKoMDNgr+
         0TLZrBoEJBz323RO3U1RBreCIlmDJEKkNJ7IBjq4ZBV3UhGZUJFBf7ne/2kyFDFQR0n5
         WVkKJoFFMaBjlAzUuFf6/7+jGnCFlHBSMqUPk0cXJNygNPsYqAeZYT9yCGxkj6ffNHdt
         2P4qBiw/oGTrj6A1jdGIkRyoZWkbTu4G6a7aWZOJfDcyiXrZKJig70GiN5oz20X4gAvX
         dOhA==
X-Received: by 10.50.142.98 with SMTP id rv2mr17218135igb.41.1438560690483;
 Sun, 02 Aug 2015 17:11:30 -0700 (PDT)
Received: by 10.36.107.144 with HTTP; Sun, 2 Aug 2015 17:10:51 -0700 (PDT)
In-Reply-To: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275154>

Hi Thomas.

On 3 August 2015 at 08:52, Thomas Ferris Nicolaisen <tfnico@gmail.com> wrote:
>
> Hi,
>
> A draft of Git Rev News edition 6 is available here:
>
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-6.md
>
> Everyone is welcome to contribute in any section, either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
> https://github.com/git/git.github.io/issues/89
>
> You can also reply to this email.

I did a quick read through and it looks like another interesting
edition, thank you! I couldn't see any obvious issues with it.

There is quite a lot of discussion in the support section, which I
really like. The following sections pack a lot in, but I think could
warrant a little more discussion themselves.

For example, I think it would be good to add a brief discussion about
the 2.5 release. This seems important/interesting enough to provide a
bit more context in the edition itself. Perhaps something like the
following?

--8<--

## Releases

* Git 2.5 is out! The project maintainer, Junio C. Hamano, has [shared
his thoughts on the release at his
blog](http://git-blame.blogspot.de/2015/07/git-25.html). Git 2.5 is
packed full of new features, and includes contributions from 21 new
contributors. In his post, Junio describes how `git help` has changed:

> One interesting change is to git help. We now list commands, grouped by the situation in which you would want to use them. This came from discussion on usability, inspired by one of the talks at GitMerge conference we had in spring.

He goes on to talk about some of his favourite new features included
in the release, such as a new short hand `branch@{push}` that "denotes
the remote-tracking branch that tracks the branch at the remote the
branch would be pushed to", and a new option `--ws-error-highlight`
that can be used with `git diff` and friends to show whitespace
breakages in deleted and context lines.

Be sure to see the post for more on the new features, or checkout the
[release notes in the
source](https://github.com/git/git/blob/master/Documentation/RelNotes/2.5.0.txt)
for all the nitty gritty details.

--8<--

I'll copy this over to a pull request so you have it there if you
think it's useful.

Again, thanks for the edition, love reading these each month!

Regards,

Andrew Ardill
