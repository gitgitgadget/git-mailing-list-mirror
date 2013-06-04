From: Andrey Kiyanovsky <andrey.kiyanovsky@gmail.com>
Subject: Re: Git status reports untracked on tracked files
Date: Tue, 4 Jun 2013 12:05:45 +0300
Message-ID: <CAO-zUniGNqxLJ9JrRMtfGF7O52sQsrGBoh0HJf+zh0czwt7ETQ@mail.gmail.com>
References: <CAO-zUnh4018FSnsXzX4gLw-4AnWsKgEiZ5P4pktjxNokargQwA@mail.gmail.com>
 <20130603222618.GA26180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 11:06:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjnCN-0004SB-Dt
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 11:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab3FDJG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 05:06:27 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:52942 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3FDJGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 05:06:25 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so8934844obc.26
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VXtV3PTH9voF5GyqZPkpzQh8945yIMoli0VYa3UNewU=;
        b=o/3Fm6zybiNQNhwagF9iE+NL51qjISBvvhN/wuieLPRANZ/gNmBeaYg7RWbhCAYgYx
         IVER7kX9E18ku259cfR3vP/YD9fIz/R+uihs71vH9r1Dry0X6f2wQESftB0UsPkPR5+m
         W2p7n6ReGa/OD4/9KGIPIwXuwoeFrONSRiBynoenjALQSXaF8AKxeuvAOC5ESMbOxyR3
         EmyMH08LRN/NbEjMlUhPfI0DCA6j1e8bcLlwdHFRXZ0q2vWkHc9axqayN18WyGVVWm2p
         9bFHeXEw22dX7zGjFAafbiZ63wQLfoGGEBMksm3kxnVr6B0oUrZsPn6sjKrsn89q9+l6
         0kvQ==
X-Received: by 10.60.173.143 with SMTP id bk15mr11526778oec.70.1370336785293;
 Tue, 04 Jun 2013 02:06:25 -0700 (PDT)
Received: by 10.182.132.113 with HTTP; Tue, 4 Jun 2013 02:05:45 -0700 (PDT)
In-Reply-To: <20130603222618.GA26180@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226333>

I have tried Git 1.8.3 for Windows. Case is fixed. Thank you very much!

2013/6/4 Jeff King <peff@peff.net>:
> On Wed, May 29, 2013 at 11:40:56AM +0300, Andrey Kiyanovsky wrote:
>
>> Git version 1.8.1.2. for Windows
>>
>> Git config:
>>
>> [core]
>>       repositoryformatversion = 0
>>       filemode = false
>>       bare = false
>>       logallrefupdates = true
>>       symlinks = false
>>       ignorecase = true
>>       hideDotFiles = dotGitOnly
>>       compression = 1
>
> In the past there have been some problems with status listings of
> untracked files when core.ignorecase is in use. I fixed some cases with
> a commit that went into v1.7.8, but some problems remained. Karsten
> Blees (cc'd) did some work that went into git v1.8.1.6, but I do not
> know off-hand if it would fix your case or not.
>
> Can you try with a more recent version of git?
>
> -Peff
