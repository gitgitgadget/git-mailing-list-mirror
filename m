From: Saxon Knight <knight.saxon@gmail.com>
Subject: Re: Out Of Place Capitalization In Stash Feedback
Date: Sun, 3 Apr 2016 12:15:33 -1000
Message-ID: <CAE3c8OuN0k4-mrqK9zVznC3JKuXyoxFcTC3NiH9Ce5NSrDG=Dg@mail.gmail.com>
References: <CAE3c8OtZx33q+gsYFgq9Rn9EtEAnSREkxL9TkTOK_n489Yh+Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 00:15:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amqJ4-0008SK-Fa
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 00:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbcDCWPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 18:15:35 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:32859 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcDCWPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 18:15:34 -0400
Received: by mail-ob0-f175.google.com with SMTP id x3so159649503obt.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=MclXdma99cgmekCrWMEwJwK2NVO6Qui2BVKgQO/+cyo=;
        b=feZGayQxBCsJo3FBcf3T/3EyWguuNE/CDU6/KPOkON6/2gh81zbvJJR/pHspqPxwb9
         2qzWXKOaADgTpC0dTcASums7OGgkKLDKNoP6FLYcvqPCY9oP/3VWH5Fh6/0k2ziC0grc
         hGuT9XjrSLweAoen5wh70sugzpDgpoAItOfjGHUZg1p/tOS2yltrKKGcK9rW4qGzmtSj
         FIJf7H1RUQEzuYK1eeOjh1XB4eJSOAlS/hLgBKLdROBrmk2ELyHICS3MJP5KCK9vmddE
         YtDuLktgOQDiVI3TME4Zkw45rKqvQyuDispWDN4almX5/li/cjvQWwlShXXbKObtjwyj
         w2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=MclXdma99cgmekCrWMEwJwK2NVO6Qui2BVKgQO/+cyo=;
        b=EKGFj0Ud3JqT1P3XkRJgfiOLzSUwNlLWZejaw1OUrVsY1lMXf9hW/9LC3tj8PXK0hm
         rRn27f9DFDDU3v/tGioVFJjoAVvvWhX12WVK/ujHf/jTTNi81aSHLXoNhl4CUlLDZmB8
         +vhKfD7Sd1PkxwwolmPjckod+QQFQUDU2jV7xEqZcG4z0fncQToc5kueWcLzGEem281K
         8vqqHwJLkewBTE7ImJXZgO7zlmJvAeK4+u3hGxf43DDlEcjdRJ2/NkHnHu8daw8xU5BQ
         gIR6h7Lly+TEYkdft5FFH4/EzNIcc/7gIWIHSUlzXpaTsb/FwKQKPmFHdgYyc/tESWsP
         T8Vw==
X-Gm-Message-State: AD7BkJIOu9gj0wV1QGeDXwYpo5Pnt9w6ne8w4/xsEMRFKvkUqZbtk3TQaGYgrnZhXbvhgt/2GMEzFDQeh+IM9w==
X-Received: by 10.60.51.135 with SMTP id k7mr435314oeo.42.1459721733903; Sun,
 03 Apr 2016 15:15:33 -0700 (PDT)
Received: by 10.157.26.79 with HTTP; Sun, 3 Apr 2016 15:15:33 -0700 (PDT)
In-Reply-To: <CAE3c8OtZx33q+gsYFgq9Rn9EtEAnSREkxL9TkTOK_n489Yh+Ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290661>

P.S.

I suppose it would help if I added some relevant details, lol.
I'm using git version 2.5.0 on 64-bit Ubuntu 15.10.
Feel free to contact me for more specific details if needed.

On Sun, Apr 3, 2016 at 12:09 PM, Saxon Knight <knight.saxon@gmail.com> wrote:
> Hello,
>
> I recently did a git stash save "working on main", and in the
> feedback, I noticed that "On" was capitalized ("...state On
> master...").
> I don't think this is intentional, so I figured I'd try to let someone know.
>
> Here is the output (quotes included by me):
>
> "Saved working directory and index state On master: working on main"
>
> By the way, I love Git. Thank you to everyone who helps to make it the
> best VCS out there!
>
> Sincerely,
> Saxon P. Knight
