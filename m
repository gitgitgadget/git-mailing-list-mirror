From: Stas Cherkassky <scherkas@gmail.com>
Subject: Re: collapsing old git history to reduce repo size, while preserving
 commit #s and tags
Date: Wed, 30 Oct 2013 00:42:56 +0200
Message-ID: <CAJSXqrqz3KeiPKWz6rFKb4o0F88o9=63Sv37MJSp5qmYtod-6A@mail.gmail.com>
References: <CAJSXqrr4nA6azBgaD7rBbYSLWonQkn7PvSsPTXjAPaxW6E+LiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 23:43:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbI05-0003vb-PR
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 23:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab3J2Wm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 18:42:58 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:58376 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab3J2Wm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 18:42:57 -0400
Received: by mail-wi0-f169.google.com with SMTP id cb5so5625505wib.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=j4pxUxESRWVa5rx7lNiD7ShRVUQWNaRTedui0uUuzwo=;
        b=FLKcKwzOcC3xrdhQULPxbsmFv5Bl5lxorCdBx5LhAoROEI/tSL5ORPjIgy36BSP1AG
         Sf9LxNZuDmYLUt9gR4qO0gCrt1CYFtcIM0Jnvp6DkYChtpNqTkxVa92wWaoHzsZ6HJWv
         OXWNOQaZYLdH8TJBDvwnUhk8Bf9WIy3gKGf+Ltu1kRMu0SwxIJ0MIQd+h0pjLJc5SzzP
         /jQP+IY0X4K+zj6YbftZ/UUT/hmm+eP+5/9Ox66YZ+iZiyKmJ7+k5XBWn4e3/qfKrwt+
         NMnXEHNzeNwwcSBgvnBO9ldprM84+yUR2iesIxDZTsbsn5Xl5+9Xp46oB9DRNZpPetB7
         y08A==
X-Received: by 10.180.94.100 with SMTP id db4mr140839wib.14.1383086576356;
 Tue, 29 Oct 2013 15:42:56 -0700 (PDT)
Received: by 10.194.201.97 with HTTP; Tue, 29 Oct 2013 15:42:56 -0700 (PDT)
In-Reply-To: <CAJSXqrr4nA6azBgaD7rBbYSLWonQkn7PvSsPTXjAPaxW6E+LiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236952>

Hi,

I have an old git repo with e.g. 1000 commits, that grew up to
considerable size.
Now, I am starting a new project and want to use this repo, but "slimmed down".

I'd like to clone the repo to the new project and "slim it down"
I'd like to collapse 900 first commits into one, but keep last 100,
with their commit numbers and tags. I also want to be able to push and
merge changes from the old repo to the new one.

I've read about git rebase, but it seems to tamper with commit numbers
and looses tags.. Is there any other way to have it done ?

thanks!!
