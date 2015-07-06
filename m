From: Andrey Hsiao <andreyhsiao@gmail.com>
Subject: Re: Git merge commit message issue
Date: Tue, 7 Jul 2015 00:16:19 +0800
Message-ID: <CAArk4YPvO46H2HXkPyPxwirauKXYJ1qpi_GmYMh-T2xz5EdaBQ@mail.gmail.com>
References: <loom.20150706T173729-880@post.gmane.org>
	<vpqtwths1yq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:16:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC94G-00035j-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbbGFQQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:16:22 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36580 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbbGFQQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 12:16:20 -0400
Received: by qkei195 with SMTP id i195so120599410qke.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FjnU4S3nv5OqcmMnpQYc79HWV+MNZYGt9HmRl9qlrr0=;
        b=bx7iMaQ7fZELj3RuajmioNZ9b8qjIPRquK95PV9jGVvebjWxQvbxy2klbtBx/xrK0F
         Jz9DDqAG28qFsCnc0oW0Pcd0EaB4iGxjq872qqh5LtD66T7jtxAPmpeEaQ6RjZy7qUdo
         ItgytR7xBpGJeho5yDAzOUokt5q8Vmhdis2jjRcHlaR0NXF+g3NQsur6A09S09pNEgro
         Kt5sdSYKd+8y83rlyMrkMbSMuXmo3KS7/0M4dLp7gwyA8OZdUlP6htKfZrnktOWgxWIz
         ADxatMADZtsx4NKUdvSvGVAnq0zVykoHa3y5j3qUgw/KYs562JU1VFxEzK+b37IPI6Gn
         1vPQ==
X-Received: by 10.55.33.196 with SMTP id f65mr94179512qki.2.1436199379199;
 Mon, 06 Jul 2015 09:16:19 -0700 (PDT)
Received: by 10.140.82.81 with HTTP; Mon, 6 Jul 2015 09:16:19 -0700 (PDT)
In-Reply-To: <vpqtwths1yq.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273397>

It was a bit sad since we use scripts to do the merge, then we can
check the conflict list in the log message, and assign to separate
owners to resolve them.

Would it be possible to make it as an config option?

On Tue, Jul 7, 2015 at 12:08 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Andrey Hsiao <andreyhsiao@gmail.com> writes:
>
>> Dear list:
>>
>> In the past, when we do the merge in git, if conflicts occurred,
>> when we commit, the conflict list will be appended to
>> the default commit message automatically.
>>
>> eg:
>> Conflicts:
>> ....a.java
>> ....b.java
>>
>> Today, after using Git 2.3.0 for a merge, it seems now the conflict list
>>  was commented out by default.
>
> Yes, this changed here:
>
> https://github.com/git/git/commit/261f315bebfa9af2d09f20211960100ff06f87cb
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
