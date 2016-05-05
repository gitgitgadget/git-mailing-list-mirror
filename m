From: Stefan Beller <sbeller@google.com>
Subject: Re: Submodule's .git file contains absolute path when created using
 'git clone --recursive'
Date: Thu, 5 May 2016 12:32:28 -0700
Message-ID: <CAGZ79kYjw6vzf7rf_-bOiMmm0VtAwO03vpk67QP4u2m_N_Mm4g@mail.gmail.com>
References: <loom.20160505T140253-275@post.gmane.org>
	<CAGZ79kYmh9wtzXdThzPTdEZ5SsKznYxze6EvmbaZdGog4yydNA@mail.gmail.com>
	<CAK1enhO-2Ne4XVqRNXz+6Jd7uEEHde8-_xzwWzXh=b01bZhj0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Loet Avramson <loet@forter.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:32:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayP0j-0002UI-Rk
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbcEETca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:32:30 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34878 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbcEETc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:32:29 -0400
Received: by mail-io0-f172.google.com with SMTP id d62so94569171iof.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=0u/j/Bh2h3cUm8jVLwa5mhgV66be7CeFjxUN0tk9P+k=;
        b=guSSrdwz2f8Y8vv3sQgPtNZe+sOvo+AwJ7uoVs0z1hcBzSeOYpal6IWL6tq279cEos
         8hNFjhQArzNjmlGCLwuWBlG7DJDT2Aswhyv2pBgwv6j2xEU4I6QUuwU0jMJdO55OXfM0
         UGWCo/E0/SS+XEZZH06ffVmnmZw0PdEC6JoVOOoI4Gmj4CLy4g+ohV7lIeJV899Uh0Dh
         LJ+jAfPkFmu0PFVnbn7A5kCHqVkjx3tXvofoGRgdlVtK9lcjsEEGi2SP48wO7Gf2enbH
         q2x6BLrlwb+DfjKVezuGusn5OpqgE/n9zlhD0NbliZVH1qBlKZ8F9XQ7oOeVIru+BnQr
         4nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0u/j/Bh2h3cUm8jVLwa5mhgV66be7CeFjxUN0tk9P+k=;
        b=WLXqdji5Tcib1v4D7TjjTzc/TQxqceeMeoOEC8BAwMlhAh1KDaJXhbKoFIDQfEp6hL
         VJWPxuhsjCxp7k1zeB7IfjtvDuD9W/Mex9sO8Yk1nwhe3y2m9fLdhQjEgo9tI+oOqUx4
         EcTV6uVrZLj+6iQxqvfW1VNVigtigKszINIEdP97ePoZMLZs7Uj6peMRRCefwjohoztk
         Slo/pUK+4VvhGkve2HQ/nOgZ7oYXEyieNQadxOg+bUW+41Woe48kgKYLVX+iEEZpwgz0
         8fmzmsIiGbNzSG1ZvIVLGZHJ4/05ixas2t3S2kfj0Eb3g6ZNPxHn+ijOfBz3j0WDUV1/
         2NQA==
X-Gm-Message-State: AOPr4FUcV3LhVvcstNVWnjjjhZHcHdRnviM8tEC4wNqKwQq07Lt6JmvE6lPcbyO/htBarTqOCPehNiooANdeLOVv
X-Received: by 10.107.53.204 with SMTP id k73mr18975101ioo.174.1462476748352;
 Thu, 05 May 2016 12:32:28 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 12:32:28 -0700 (PDT)
In-Reply-To: <CAK1enhO-2Ne4XVqRNXz+6Jd7uEEHde8-_xzwWzXh=b01bZhj0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293667>

On Thu, May 5, 2016 at 12:20 PM, Loet Avramson <loet@forter.com> wrote:
> It happened on 2.8.1, also reproducible on 2.8.2.
> Haven't had the time to dive deeper into the code but my guess is that
> relative_path() returns different results in those 2 cases or maybe
> the way git-submodule.sh handles it.
>

Then you found a new bug, congratulations. ;)
Thanks for reporting.

The shell script uses relative_path() only for displaying paths,
not for writing them to the .git file.

it really boils down to different environments
"git submodule update --init --recursive" is called from
(either manually or from `git clone`).

Apart from that there are no immediate bells ringing,
are you doing any weird stuff with the file system (soft/hard
links) ?

Thanks,
Stefan
