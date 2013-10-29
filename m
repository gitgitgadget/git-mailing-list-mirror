From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: collapsing old git history to reduce repo size, while preserving
 commit #s and tags
Date: Tue, 29 Oct 2013 15:52:12 -0700
Message-ID: <CAH5451=DGp0aRaA6c-ThO0Aj0VCAUFX17p8gOKPpURwEnjcpdA@mail.gmail.com>
References: <CAJSXqrr4nA6azBgaD7rBbYSLWonQkn7PvSsPTXjAPaxW6E+LiA@mail.gmail.com>
 <CAJSXqrqz3KeiPKWz6rFKb4o0F88o9=63Sv37MJSp5qmYtod-6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stas Cherkassky <scherkas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 23:52:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbI9i-0006Cn-MW
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 23:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3J2Wwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 18:52:54 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:34934 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab3J2Wwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 18:52:53 -0400
Received: by mail-ve0-f170.google.com with SMTP id oy12so429039veb.29
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l+qiicIZEN/surLrrWgTtVrUKRBZb9fYNb6Tq6dzmQU=;
        b=x6rxSnf11guTH00+V1iiQeD8u3/GzbSuI3uuONuiA4JU4jBiRXK6DXyycFEF4KADD6
         wY6hLtJG133uVB6hugkG2hp+h5Y5Xn7XbzZnIm95ZGHh4YuNg3KVGsZKJ001hqDqIzSD
         6Gn1OY4c4QLM5WtbR7P9Mu7ydWlffjrxZ4gxMU9iUmJvlg5Grf91E4I/XlNgFv+E42CN
         M5NZAbGCAUIB1OyLnXBZv6APpK4n2dg/NQpLxLtfWWzLdtEYL88X4KEKivdwTvJaYrIE
         D9C2HUrbaarj//8PYW5oNgu7OjDrwtyawmHwPrNy3IBtyVHNNgjvCDTThyWmeAJ2+jCb
         yEXw==
X-Received: by 10.52.35.20 with SMTP id d20mr796737vdj.33.1383087173035; Tue,
 29 Oct 2013 15:52:53 -0700 (PDT)
Received: by 10.220.58.197 with HTTP; Tue, 29 Oct 2013 15:52:12 -0700 (PDT)
In-Reply-To: <CAJSXqrqz3KeiPKWz6rFKb4o0F88o9=63Sv37MJSp5qmYtod-6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236953>

On 29 October 2013 15:42, Stas Cherkassky <scherkas@gmail.com> wrote:
> I'd like to clone the repo to the new project and "slim it down"
> I'd like to collapse 900 first commits into one, but keep last 100,
> with their commit numbers and tags. I also want to be able to push and
> merge changes from the old repo to the new one.

If you want to change the actual history of your repository, it will
be largely incompatible with the original, and this is by design. You
don't want somebody being able to change your history without you
knowing about it.

> I've read about git rebase, but it seems to tamper with commit numbers
> and looses tags.. Is there any other way to have it done ?

It sounds like a shallow checkout might be appropriate for you, try
looking that up.

Regards,

Andrew Ardill
