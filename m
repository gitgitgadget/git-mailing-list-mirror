From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Cannot clone a linked working directory.
Date: Wed, 24 Jun 2015 18:16:11 +0700
Message-ID: <CACsJy8BDrkrxO6f8SgqRjmLgSCwALqhO5hXEOo51v25=6NpwrA@mail.gmail.com>
References: <CA+cck7FB6QPz1Pec11TPXxxAhwKR78K9swgsQjMrZPhKJzi_iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: bjornar@snoksrud.no
X-From: git-owner@vger.kernel.org Wed Jun 24 13:16:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7iff-0001Gm-2C
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 13:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbbFXLQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jun 2015 07:16:43 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33461 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbFXLQl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2015 07:16:41 -0400
Received: by igbqq3 with SMTP id qq3so111314404igb.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=d0ahsuN2Jctchnc3/NqOAN4akBfY0MNJByE/eNVVSmI=;
        b=q52I/2TseJroKIx0v/GfTKEmE1JiS+teFYILTH5zCEzXepOPfKGjLVKPbrlJIItzb3
         d3EQ1BcMCDOx7jvaqwYmoYjHz3U3tPCdjIblEVgRFs1TGgtQgc0ER4xnexcINHU/PXjT
         Zyb/qwjYDQ9m+YuIIS/SOauUZqOkvqTNrwnjxzFLQng0pBF6tj+Ijh/tZlyyinABMkzV
         wuYPbylgDaA3Zxeg6GSNRWkw0SDnUYiREVKLQ/+AWyUkgcCyHa/HOQToI942CdfHGHHI
         MRaSLXNtdcW6WeK79toWQtl8cxT/iQf0I1quKaRR8N1Zy8ym4BazxUkJSOf66pTv/xga
         gW1g==
X-Received: by 10.50.164.233 with SMTP id yt9mr2334255igb.41.1435144600986;
 Wed, 24 Jun 2015 04:16:40 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 24 Jun 2015 04:16:11 -0700 (PDT)
In-Reply-To: <CA+cck7FB6QPz1Pec11TPXxxAhwKR78K9swgsQjMrZPhKJzi_iw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272549>

On Wed, Jun 24, 2015 at 5:38 PM, Bj=C3=B8rnar Snoksrud <snoksrud@gmail.=
com> wrote:
> Summary:
> When creating a linked working directory with `git checkout --to`, yo=
u
> cannot clone from the local path. This works when cloning the main
> repository directory.
>
> I couldn't find anything the the documentation for `git checkout` tha=
t
> indicates that this shouldn't work.

I didn't think of this use case. If something works on the main
worktree then it should also work on linked checkouts. I think I see
the problem and will try to fix it in probably a few days (the "git
add -N" problem takes higher priority).
--=20
Duy
