From: Stefan Beller <sbeller@google.com>
Subject: Re: Find main branch
Date: Thu, 14 Jan 2016 10:26:45 -0800
Message-ID: <CAGZ79kbHSOm3OxEOXUXt0NDTPknyb435w_WOB4XW_-gtt3TH0A@mail.gmail.com>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: pedro rijo <pedrorijo91@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:26:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJmbi-0002Ws-W4
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbcANS0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:26:47 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37552 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbcANS0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:26:46 -0500
Received: by mail-ig0-f182.google.com with SMTP id h5so133056079igh.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mZKXb2sepWroEVm8ApAfhe0uC7CGcxiJSy362SaX4es=;
        b=aTYMWGTXYt+zkeWRHykJbNtNs21eQJd2trMqhWvtWCYzyOWxE6YCSYcEzDbhuS+TH0
         l8PQ9p3nJ31tddBR6WZBuStasTGpZkxjW13eUXx/uKa74DqmUW0jembbrqpUgqzY+qWe
         9dIxSiAS0Oy7pj7Nur0gGF/XHiaFC4Y4+1p1/t+xjjP7h55yf2JEgt7N/0jgW9tkNDUm
         jmFQfWNQ07fKvZk3SNWDkFDueustbSAlg9SHMK6VMvW1tFFYOrPX4alzlcXFTyHFgExJ
         bBfU+m1ME0jkus9GPH8+aJ5pr27POegCjiVKp7Tt8+lZ/f/wTfAQkzqvvHbIGABaZq3G
         nr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mZKXb2sepWroEVm8ApAfhe0uC7CGcxiJSy362SaX4es=;
        b=iX5b32pqfLRawZ/fMvMlC880RTuGhx0Noh1cOhKrERk9FlKSWSa533s4dl9Bx1Vt87
         0XPTZUZYKWYLzEOSFh66kkiO7bQOf7cMmS+2f6lmeLHB9HQGr1ZJ+CeSVQdb2k7ax+kB
         4EZO2r40cu72YRZQwbiNZAeKs+SxKDE1ZnBb0tnEafdot7KOlBdR2kYnhmBoC12hqm1A
         9vt8qVeK5E6TXARd6o1pzK5eYtoHptYTc+c7d2Kt3x7TrEY2shk7UaxaWxg0lXZXEV1D
         q5HAGeUJYnHKUK4pva+w3wC8SK+6L2u0hjSa73GPrS/7yDukRiHWO2cm0J0EKoBglAc+
         gD9w==
X-Gm-Message-State: ALoCoQlgayBJxHaaQ5TrhFoR34fy190ybWxOg1/30PzG1vXwsJTM/syeqpHgYXjEvZw3RuoL9byAw7a5yv/APauZqL8/6xwt/JcJ+RPdH6vejkrnMT9DgWM=
X-Received: by 10.50.66.179 with SMTP id g19mr6674466igt.94.1452796005734;
 Thu, 14 Jan 2016 10:26:45 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 14 Jan 2016 10:26:45 -0800 (PST)
In-Reply-To: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284076>

Looking at the capabilities the server sends you.
(I forgot if there is a git command for it, but:)

# check for http://github.com/gitster/git
ssh git@github.com git-upload-pack gitster/git
0104fc10eb5b87a75af2cb93a3932897572f2c544915 HEADmulti_ack thin-pack
side-band side-band-64k ofs-delta shallow no-progress include-tag
multi_ack_detailed symref=HEAD:refs/heads/master
agent=git/2:2.4.8~peff-symbolic-refs-iii-revenge-of-the-sith-1258-gc4b0e8b

Notice the "symref=HEAD:refs/heads/master", which is what you want.

On Thu, Jan 14, 2016 at 10:17 AM, pedro rijo <pedrorijo91@gmail.com> wrote:
> Hey,
>
> If I clone a repo, the repo will be on a specific branch, the 'main'
> (typically 'master') branch.
>
> Is there any direct command to find that main branch, since that
> information is present?
>
> If so, is there any way to find it without actually cloning the repo
> (similar to git ls-remote)?
>
> --
> Thanks,
>
> Pedro Rijo
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
