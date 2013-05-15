From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: "git grep --no-index" doesn't do what it says on the tin?
Date: Wed, 15 May 2013 08:54:02 +0200
Message-ID: <CALWbr2wq7QtTXp=tDn27g6_XQjou9FfCvPkXHxmxqws4nTUwxA@mail.gmail.com>
References: <CAEY4ZpP8txhCCmw-Ck7_rQL+Xn4bJw-RgVa7iDaHzQ6mcS5oLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 08:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcVbF-0002ta-OC
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 08:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab3EOGyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 02:54:05 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48024 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab3EOGyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 02:54:04 -0400
Received: by mail-qa0-f42.google.com with SMTP id ih17so1113651qab.1
        for <git@vger.kernel.org>; Tue, 14 May 2013 23:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Lq3U0XMtC9t4r/3X34okd7+IkCd+rIv77Ymc0boMyIw=;
        b=RvNV2nPB90QwmZSLGTRr77a9pskF7RmBYQH2//DF4Ktj/9qtjJ9UM26bhv55p9vaKR
         r0F+WtMeTb/bGOHL/hBt2f8MGmQowunouCOu56/+FJuozKoIIrfz94pzUU0/iF2MIobO
         UgMvYImUR+7Djv+ForASM0k0xG6/HMXhN4E11sGgARod7vyMwcvQla9Onu7J+0rzjmeO
         WC1M5JGkxBaDhzVGHvlboysOjVaalwJ2UiQrfP0DWTEm4vZ12kZ1K/tU7Nk5mvJychQR
         SAaLq1aFJvZHX3o3zNPwndNKkoc44AdLwkWtiu/JDmN0KqNOyr8SAcmrw5uohAYvuuu8
         xt2A==
X-Received: by 10.224.30.76 with SMTP id t12mr26222534qac.24.1368600842496;
 Tue, 14 May 2013 23:54:02 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Tue, 14 May 2013 23:54:02 -0700 (PDT)
In-Reply-To: <CAEY4ZpP8txhCCmw-Ck7_rQL+Xn4bJw-RgVa7iDaHzQ6mcS5oLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224386>

On Wed, May 15, 2013 at 7:32 AM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> Hi,
>
> From "git help grep":
>
>       --no-index
>            Search files in the current directory that is not managed by Git.
>
>        --untracked
>            In addition to searching in the tracked files in the working tree,
>            search also in untracked files.

The difference is in the "not managed by Git". Inside a repository,
they will do the same thing. But only the first can work outside a
repository.

Cheers,
Antoine
