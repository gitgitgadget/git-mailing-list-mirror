From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Thu, 11 Oct 2012 21:43:45 +0700
Message-ID: <CACsJy8C2zYkWV4b60WczGe4CCsXXffa00hnzj723+=ubhmA67Q@mail.gmail.com>
References: <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7vvcer4chm.fsf@alter.siamese.dyndns.org> <CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com>
 <7va9w23i45.fsf@alter.siamese.dyndns.org> <CACsJy8BeWuKT_jUyRYf3cKrp7Jx07J2jPEZd96KbWEY+aiX24w@mail.gmail.com>
 <7vmx00u1nz.fsf@alter.siamese.dyndns.org> <20121011124326.GA30589@do> <vpqhaq13xdq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 11 16:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMK04-0002wk-FE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 16:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab2JKOo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 10:44:26 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55243 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab2JKOoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 10:44:25 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3075758iea.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6Mzzcz88jsvn01/HR3Cyd5l4ZISqzn1zLnihA61Usp0=;
        b=Vc912Brf0D6eYs6P/Jjlqbc3wwoqE3tlQUC+G9bMweZIo9GH9V4Vu0g4cnHIVUEBV5
         Z1BvWu/vMHH7fil7cK39m1q17PwFJ6qZmRBUEwroADxqVXiXMEaa9TRe40HFEH4z5I/N
         oHLH1CmK39RzEICVBk7Mw52/NG8CRFgaAY6mnMeSm0BROAV6TqTG4zvMQ7GcuCsdVfUS
         ZEUx98JxSJYNpkTy4mFZGQYuoisx0Rfs/wcWK1pX3qfEmL+DpIKjPzX4mmfbKOHLZD13
         oG3Z3vp0EA0fzh4j2kKkxN5fdPV9tRiKMQydukx1NcMyPR6BEi29yspQEE3LM5ITeI12
         B3mQ==
Received: by 10.50.212.97 with SMTP id nj1mr1047033igc.26.1349966655668; Thu,
 11 Oct 2012 07:44:15 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Thu, 11 Oct 2012 07:43:45 -0700 (PDT)
In-Reply-To: <vpqhaq13xdq.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207478>

On Thu, Oct 11, 2012 at 9:18 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> For example, it makes the output of git status look like:
>
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #   Set advice.statusHints to false to turn off this message
> #
> #       modified:   foo.txt
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #   Set advice.statusHints to false to turn off this message
> #
> #       modified:   foo.txt
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #   Set advice.statusHints to false to turn off this message
> #
> #       bar.txt

And two more lines on my output:

 no changes added to commit (use "git add" and/or "git commit -a")
 Set advice.statusHints to false to turn off this message

> I think it's going really too far in verbosity, the actual information
> is hidden by the advices.

We could make it only one extra line in this case by prepending "hint:
" before the advice and say "you could turn the hints off by setting
advice.statusHints" at the end. Not applicable in general though.

>> (which is good, more motivation to turn advice off).
>
> I disagree. Having advices turned on doesn't harm anyone. I don't
> remember anyone complaining about the verbosity of Git's advices. I've
> seen *many* more people complaining about the user-unfriendliness of
> Git.

"git status" is actually quite verbose, but the advice only plays a
part of it. So, not an actual complaint from me about the advice
alone.

>> -     "  git checkout -b new_branch_name\n\n";
>> +     "  git checkout -b new_branch_name\n"
>> +     "Set either advice.detachedHead to false to turn off this message\n\n"
>             ^^^^^^
>
> Wrong cut-and paste from "... either XXX or YYY ..."? (repeated several
> times below).

Cut&Paste mistake.
-- 
Duy
