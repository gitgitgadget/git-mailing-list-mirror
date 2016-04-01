From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git alias quoting help
Date: Fri, 1 Apr 2016 13:05:40 +0200
Message-ID: <CAP8UFD3y_hFVT_PjAQFJ_091M83nmGGFsPGii0YFKOORbHqkKg@mail.gmail.com>
References: <CAH_OBievBBjzLwPZf3-qLn-SQyJG0UHhbdkvyZFfC8b-TsTUJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 13:05:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alwtm-0004kT-L9
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 13:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759024AbcDALFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 07:05:43 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34697 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759017AbcDALFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 07:05:41 -0400
Received: by mail-wm0-f49.google.com with SMTP id p65so21164902wmp.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=w2PA6/f8l9xybhliVx6ChYMQQo3Os1qjMVlfzJnTZ3Y=;
        b=PIDY3AIxsjleuJNyoCdOei7FPyzhsW+2zjUJWJz4xsq37j/Ezx26YAUmpZP0KmTl/W
         jCl8L0Ko0nZP6/Q0fScPV8wC9XNhzcx5cnzgQmVmhwd0wkc7XbAb/nsfpk8HBystfUUd
         /npoWWLASCEZzC2CPtHP2aNUg8H1Nn+o5Jse1lsa7D2ZeB+C029F9dYELn7EwBCZpPg0
         As4S6D1A33ajp7fDXrctbSCO9noqdA631/O8l4wzgexSXHwzSRfLYuDivjuSmP99smBR
         BQbHRc9sx5Z7Zm8F1aNytnfdYaShGa/QrlKbaLO6x1j26Dbrbzb3awDGDy81/G5i/ny9
         3r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=w2PA6/f8l9xybhliVx6ChYMQQo3Os1qjMVlfzJnTZ3Y=;
        b=RCHZqRQqe8KUl2c31xqhsTfO10M0f0JuMjyGbckWrDK0wAJSXNyEeUfl0WXcugYFCG
         Y6pjQPYPmRMxAiqdRYysaP/p4RODtplgomBmIlJUjEiZPf2T0JOTe9N1kO6DKsaze4OQ
         ygkB0QfS3OAmPdLLLMUDcFTZQQfMuDpRo3lHi2wPzy/kkCOHlhap7chZlYg89tqPUTea
         M4HN+gf5M/MUoP336xEQmCsZRaESbaOMKC7RObR1lqNKe96e+7wvspn5Zb2CctNv9u60
         G8IOrp6txKTzccsElhN3YslTvOfw/G3cF6aQU7vROTWic69ML7AtdqSluLjJuT2Ch4sm
         ZQeQ==
X-Gm-Message-State: AD7BkJIoce4tOeirr3kujZj7aoNnu/qQMTMN9JwI/64222JIy5AiSLVgdlODinzsYDtOtM9VlZ+/6PhLOn5tPg==
X-Received: by 10.28.97.10 with SMTP id v10mr3381611wmb.62.1459508740159; Fri,
 01 Apr 2016 04:05:40 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Fri, 1 Apr 2016 04:05:40 -0700 (PDT)
In-Reply-To: <CAH_OBievBBjzLwPZf3-qLn-SQyJG0UHhbdkvyZFfC8b-TsTUJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290523>

On Wed, Mar 30, 2016 at 6:13 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
> I've also tried to make this a plain bash script (w/o the function or
> if statements and am failing at the same place). The issue seems to be
> with the quoting in the filter-branch | ls-files bit. Also, the end
> goal here is to be able to move a directory from one repo and keep the
> history.

Did you try git subtree
(https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt)?
