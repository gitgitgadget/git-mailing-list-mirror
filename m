From: "Ben Bennett" <benbennett@gmail.com>
Subject: Re: git status bug problem.
Date: Mon, 23 Jun 2008 20:37:15 -0500
Message-ID: <970bc7c80806231837j19458b80x81063745a2ef40c4@mail.gmail.com>
References: <970bc7c80806230619i6c060c4eld329729ec7eef1da@mail.gmail.com>
	 <970bc7c80806230622x326c5cd3mbce57949255a067b@mail.gmail.com>
	 <m3r6aol0u8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 03:38:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxU6-0007T8-9u
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 03:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbYFXBhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 21:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbYFXBhS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 21:37:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:30639 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbYFXBhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 21:37:17 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2009629wri.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PIuuw9mZA3fZIJcsrjZU4GlNb4MO6nmfZlk/APZ+IUI=;
        b=ZrQSh+SRVW4aAGiC7mBF0pVCN63YXVOlqRAxO1P7E7QrSiMlsVpJ+hxla02C7b9T3b
         YeRB6nPngG0Sci7h3zXjbzjB04AcvwtgNBPJHsrz3BgCWeFevgnhF6i9Y1v00pJlOsAS
         1QXhYanmpX5Dl9kzsaj7+1IkJrV8s93r7uNNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=feasqWjyBJtdU5gW6cPqGwc4mkDzJp+b43fEW2KeK0SZfGmQm+Qlm0eTew5rvzgx+3
         JsWu7r4i86oW8uAZ7p+wlrhF6aCTp8a0l5Nq7GutB7ApGxy8qqvViuJNTQVvYpkMUjJI
         2qZxeifgRLKdhEU2Rxr+Dvs0LBV+EcDoxkhA8=
Received: by 10.90.49.8 with SMTP id w8mr22940agw.31.1214271435785;
        Mon, 23 Jun 2008 18:37:15 -0700 (PDT)
Received: by 10.90.32.7 with HTTP; Mon, 23 Jun 2008 18:37:15 -0700 (PDT)
In-Reply-To: <m3r6aol0u8.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85963>

I made the initial commit.  git-gui doesn't return anything either.
Something tells me it isn't getting the cwd. Add git status *  it will
work correctly , but git-gui doesn't give anything.

somewhere@something:~/git_test$ git status
# On branch master
nothing to commit (working directory clean)

somewhere@something:~/git_test$ git status *
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   test/test2.txt
#
Thanks,
Ben
On Mon, Jun 23, 2008 at 8:47 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Ben Bennett" <benbennett@gmail.com> writes:
>
>> I can't seem to get git status to return that a file has changed. I
>> think my environment is hosed up, but I don't know for sure. My
>> machine is ubuntu 8.04  with kernel  2.6.24-17-generic #1 SMPx86_64
>> GNU/Linux . I set up a test repo and it added one file to it ,
>> modified the file and saved . Doing git status returns nothing, git
>> gui finds no modified files. Doing git add * finds the modified file
>> and stages it. I can get someone a strace for the git status it is
>> only about a 1 page.
>
> You should have got something like the following:
>
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       new file:   bar
> #
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   bar
> #
>
> BTW. you have made initial commit, did you?
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
