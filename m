From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Use "working tree" instead of "working directory" for git status
Date: Thu, 9 Jun 2016 13:55:37 -0400
Message-ID: <CAPig+cR6j=L5P_i=D_6Q8Dfmu0jew9QDnRQTXjCJYQ9AUszz1g@mail.gmail.com>
References: <1465494374-10417-1-git-send-email-Lars.Vogel@vogella.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Lars Vogel <Lars.Vogel@vogella.com>
To: Lars Vogel <lars.vogel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:56:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB4BD-0000Eq-Na
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 19:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbcFIRzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 13:55:39 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36010 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351AbcFIRzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 13:55:38 -0400
Received: by mail-it0-f45.google.com with SMTP id a5so44243403ita.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VRnh8pEap5xH3kebwkOZrqbzxejsBvtmUBaO8WkgFRg=;
        b=ovPwqgXumI3F87Ul3EjKy9pOusM51revj8GOE+o7h8nhmcrKqFKjFG8QgtWIqxx8MB
         kaXuuU0YzyVioVsk42iAe6cFNPPi/lXJXtS4hhty+g6Ii25f5vYi6IkxY4IVZUPVYe1J
         l8PYbe9ocNe5kfhybP3VZqSVWPiCrRVD6EFIMWjGMAWwrT7rjhLXee1WrS4yzQbpbgk5
         AfEv8zz4bflBybZX88UGqdgkOpQynoxRmYHi2CxFTlW/7wbS5EALUk3G+SUrLiCZnQF1
         VKLApsT02g9GNGWrhp07EWounFpyYXsFj8RMLMvFa24rCJNttxDaVtCSsHd5x8ge6FMt
         smjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VRnh8pEap5xH3kebwkOZrqbzxejsBvtmUBaO8WkgFRg=;
        b=I/g/sSM4aSNxwVrsRcOrPHjS5AfQaTP3hS48OsLttnuS0P7/50tj6MhpXpm57yI6m3
         ACMcSKjN5uz9oOVHwefNUYLZjhmEP2AXu2J3VTdGMXpD4k3+m9CvYgq2Qy8o8ySZceiX
         Zb2tvzvQzGfkgopqWW/NjywjU7pEGNdUj/q1d+s5WIqyqIQgzLdojzHZGezXRzgC1xAj
         xKv4hWV2Hy9SrP7n8UkNj9lRi8gIYG7XQnVTmojSN4ZKhAby9VFU373civlBxkOymd7t
         tk1NsfMLg/sx+z04HeiedEg07FZql+NWXmTFhyc8sfHnF6Q1LVdEFroJt+0IrOX2xcfa
         pwXQ==
X-Gm-Message-State: ALyK8tIMPO878lR4+EfgVhMZYNMQ+csM66Es+mnEH3GIoG8Zp46cSvE5zuvj7LdX2VNUdqjASWXI5h4qcJeOfw==
X-Received: by 10.36.98.136 with SMTP id d130mr23799509itc.84.1465494937812;
 Thu, 09 Jun 2016 10:55:37 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Thu, 9 Jun 2016 10:55:37 -0700 (PDT)
In-Reply-To: <1465494374-10417-1-git-send-email-Lars.Vogel@vogella.com>
X-Google-Sender-Auth: fojOPnPICGuHk1qHrqBV81kWZ04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296910>

On Thu, Jun 9, 2016 at 1:46 PM, Lars Vogel <lars.vogel@gmail.com> wrote:
> Working directory can be easily confused with the current directory.
> In one of my patches I already updated the usage of working directory
> with working tree for the man page but I noticed that git status also
> uses this incorrect term.

Missing sign-off.

> ---
>  po/bg.po    | 2 +-
>  po/ca.po    | 2 +-
>  po/de.po    | 2 +-
>  po/fr.po    | 2 +-
>  po/git.pot  | 2 +-
>  po/ko.po    | 2 +-
>  po/ru.po    | 2 +-
>  po/sv.po    | 2 +-
>  po/vi.po    | 2 +-
>  po/zh_CN.po | 2 +-
>  wt-status.c | 2 +-

Don't bother updating the .po files; that's the job of the
translators. Your patch should touch only wt-status.c.

>  11 files changed, 11 insertions(+), 11 deletions(-)
