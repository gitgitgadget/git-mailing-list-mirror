From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [IGNORE] Implement 'git rebase' in ruby
Date: Mon, 10 Jun 2013 12:20:17 -0500
Message-ID: <CAMP44s2CqhxjzmZc7CiYER=F9BK1bxyCGBwCpLeq+yjDHwSj-w@mail.gmail.com>
References: <1370841722-8059-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=am0kDZWKuvdx9ph+zwtXdjRAbwu3e=GfEYUp+o8oy0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5lY-000161-3F
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3FJRUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 13:20:20 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35922 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3FJRUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:20:19 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so5517567lbv.13
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OepI/7vKhsczhHHTtpLwqxK80z6jKzFC2UiT/rv2mYc=;
        b=j78OR+Jalk6Om8S/PJU/SvFJtE0OZp8lIE4h4NNBDH5TmvexQPytO3+MDHnlNbUdnW
         8TVoZQ5jaw4yobT5gPNnvJbWoB/GCjoSbOGNNq9D5cqP7Us3YoqP1kL1P/Tr6VmqDPO0
         RKF7nyN8+4OZbuGHK3LTqC3coV7EUdL9hNkbZHGY8xvQzeYJ3EzTa5Dm4sOs4iKr11jq
         A+d/01FNRPX+E5u0ed+VWU30jr2KFNDZPbisjawOZLYu29aEHWY1ygxNbBydHKL9caoY
         Ecxxy9/9i5uiQiHpGTeLZy/0anhAbsffYcE57sGui8YZQUcKVW44Ii6jAFBdgOx1G2K0
         FtfQ==
X-Received: by 10.152.5.7 with SMTP id o7mr2024707lao.43.1370884817927; Mon,
 10 Jun 2013 10:20:17 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 10:20:17 -0700 (PDT)
In-Reply-To: <CALkWK0=am0kDZWKuvdx9ph+zwtXdjRAbwu3e=GfEYUp+o8oy0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227327>

On Mon, Jun 10, 2013 at 2:48 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>  git-rebase.rb | 2056 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 2056 insertions(+)
>>  create mode 100755 git-rebase.rb
>
> I suggest putting this in contrib/ and cooking it.  As usual, my
> mantra is: let the patches decide what to do.  I'll help review and
> improve this soon.

What would be the point? There's only so much this script could do. I
was already relying on an improved 'git cherry-pick' that's never
going to happen.

I think it would be more interesting to fork Git, replace all the main
builtin commands with Ruby scripts that access libgit.a, and copy the
code to a libgit-ng library that has stuff that is worthy of being on
a library until the scripts don't access libgit.a any more. All the
time passing all tests in the test framework of course.

Then there would be a truly useful and stable Git library, and we
would have scripts that work on all platforms, including Windows,
without any forks, and the commands would be more maintainable, and
would gather the potential of so many Ruby developers, which if GitHub
is any indication; a lot of them love Git.

I think that's the only way forward, since the Git project doesn't
wish to be improved.

There's only one last patch series that I'll try to push to Git that
I've been cooking for years. Sadly, I don't think it's going to land,
despite it being clearly good, and a simple single patch doing the
trick, and it would be immensely useful for our users, who have
complained about that for years, and most Git developers have agreed
it needs to be done. Yet, if I send it, it would not land.

Perhaps it's time for me to create a pseudonym, and when you have to
do that to land clearly good patches, you know something is *REALLY*
wrong with the project.

-- 
Felipe Contreras
