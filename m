From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: git alias quoting help
Date: Fri, 1 Apr 2016 08:21:49 -0400
Message-ID: <CAH_OBif6v3WiQ0+bz0hNGvAzqXdXjy+NJNYB65QxMexDy5s=og@mail.gmail.com>
References: <CAH_OBievBBjzLwPZf3-qLn-SQyJG0UHhbdkvyZFfC8b-TsTUJQ@mail.gmail.com>
 <CAP8UFD3y_hFVT_PjAQFJ_091M83nmGGFsPGii0YFKOORbHqkKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 14:22:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aly5f-0004Cf-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 14:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbcDAMWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 08:22:11 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36035 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcDAMWK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 08:22:10 -0400
Received: by mail-pf0-f175.google.com with SMTP id e128so72116017pfe.3
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=owm3rePHqHXSzoW9a/BeASUaXFsTVyrTlIuip3RsyC0=;
        b=R+30IBCx25B2+GTw9UJeUW2l6rGN/ZLFSIbkbucjU89S/iBMPZMZpvNz7aEraBYpFo
         Llx85ZHoJyJS7TQtIS/k0tfWjZob6uBCiMHgT+S8mnmULEqnbtx3bSUSejS+Ih0XD1uk
         Afonq5ajBAipCZfhGy4c9+Su45vs5R5DvhSR5YmLmX5BNq1MGpUjjxXYIKOHHqNqSgnV
         HYtX7nyQ48cglgceDP3YLHTwkb1LHr/HvSp05lyPJuQp3Xo6W0rxcgp/deDvFI49oxJT
         I/pviOk6w7IQr0hULk/MUkb/lQJwYsWbFjcUXFpHr2M1g92mzNuaPQ1Om1JmwbWMCs4q
         GiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=owm3rePHqHXSzoW9a/BeASUaXFsTVyrTlIuip3RsyC0=;
        b=PKxJ75c0lmk8i2LwdVqdsI772xzKdAK6bObxuHpUSIQpNKgJSRIvBgPyGS3cgpoDo/
         JR9ltS7CQp1rG5TYY4XzNJb/QtWFyX9b6XEmagKmwicDoNQkuinlfLBcyyry49ALu5iG
         4IwSp7bo6WXIWGDOxmi/aGg1QssiK9oE6O7m1rbUnmP96T674yauKcVO55JorZ4eyYah
         afUh1lW47s63+5hMRmg4OKwKbL6oifcSqsNIY8xXfUIxsE6kKalUoefJvCrBpFPJwjvi
         T0De1MyFxQYGUUFNQi6Mb7271q984kaqpaXVQlZXnj8QRvfJwaSy8Bvz7qWM1MUyYe5T
         GPbA==
X-Gm-Message-State: AD7BkJLX74t9yd3lwIBQ9LJKPFqzdRVrU0G49LYFLDzbYyOMyC/LSoEBQg1vMqJy6XEj1eRZzCLCZcJArP6n0w==
X-Received: by 10.98.71.210 with SMTP id p79mr30415285pfi.4.1459513329230;
 Fri, 01 Apr 2016 05:22:09 -0700 (PDT)
Received: by 10.66.5.163 with HTTP; Fri, 1 Apr 2016 05:21:49 -0700 (PDT)
In-Reply-To: <CAP8UFD3y_hFVT_PjAQFJ_091M83nmGGFsPGii0YFKOORbHqkKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290529>

On Fri, Apr 1, 2016 at 7:05 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Mar 30, 2016 at 6:13 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
>> I've also tried to make this a plain bash script (w/o the function or
>> if statements and am failing at the same place). The issue seems to be
>> with the quoting in the filter-branch | ls-files bit. Also, the end
>> goal here is to be able to move a directory from one repo and keep the
>> history.
>
> Did you try git subtree
> (https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt)?

Yeah, it looked like it left the repo in the same state as
subdirectory-filter and the merge failed. But I'll try it again when I
get to work.
