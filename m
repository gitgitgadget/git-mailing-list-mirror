From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sun, 22 Sep 2013 03:29:03 -0500
Message-ID: <CAMP44s3OYjv2LsU+6FY_qESdCvJcD4zb46aJmKpruof3hYEGzQ@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
	<CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
	<20130921235647.GC235845@vauxhall.crustytoothpaste.net>
	<523e81f338f1e_547c41e7c166be@nysa.mail>
	<20130922073120.GC13262@paksenarrion.iveqy.com>
	<CAMP44s0Lww+se6iA2NWSwkeuLdR9mc0ppnVBSjWu4d73YeP6oA@mail.gmail.com>
	<20130922081250.GD13262@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 10:29:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNf2d-0000Yt-JP
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 10:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab3IVI3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 04:29:14 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:45862 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab3IVI3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 04:29:06 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so1602316lab.17
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eDepopcsUhVt0P07CGiW17ehbA9iiQAmWJuRZd4dBJk=;
        b=lApyl8e8RYV6/xy1AbGsBcim9N1zQoerKylqHgiJf6l2N4sCPLH+aRbK8yQnhasYvh
         F5OwLiYGcxhDqUEUMI058FTqHbtardpUBarUBn2fpLUeJJfyD1TZmjO9kr7flKq/CH3c
         6fkSUjNJbi/a+QonfDlsJygjtISR3ElXTtWNjT6BGH8uYxVVhItbipb42SmBExMjmb+4
         nHBirqGTW/QyKjvwBAIDvE0ZF2WCwfzDOtjVJjPAWogVXn1VgatPej+5mL+Di5mRnVYW
         hEcCIqVhhw1fWlllGFATKHhegPEeQ92owQwX+RTVEh+XYpf4I6/VDYAQbZW+3QLgaMUw
         VzsA==
X-Received: by 10.152.2.4 with SMTP id 4mr14568250laq.0.1379838543718; Sun, 22
 Sep 2013 01:29:03 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sun, 22 Sep 2013 01:29:03 -0700 (PDT)
In-Reply-To: <20130922081250.GD13262@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235163>

On Sun, Sep 22, 2013 at 3:12 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sun, Sep 22, 2013 at 02:43:39AM -0500, Felipe Contreras wrote:
>> > It would actually be usefull to know stats on where git is runned. In my
>> > world of embedded computing, ruby support definitely isn't a standard,
>> > nor is glibc.
>>
>> I come from the embedded world as well, and I've never seen Git used there.
>>
>> I'd say Windows support is much more important than embedded, and we
>> are not supporting that properly.
>
> Me neither, it doesn't mean that it isn't used though... I agree with
> the lack of windows support from git.git.

Sure, it *might* be used, but I don't understand this fascination
about worrying about hypothetical users, possibly non-existent, when
we have real users to worry about, and in big numbers.

> However since Microsoft
> working with libgit2 on a Visual Studio plugin this it might be that the
> need for windows support decreases.

I'll believe it when I see it. And then, when the users like it and
don't report brokenness.

Personally, I don't have much faith the in the libgit2 project, and
it's ability to keep up with git.git.

>> >> > Also, the only Python script that is shipped with Git is git-p4, which
>> >> > is essentially optional, since most git users probably do not use
>> >> > Perforce. Otherwise, all the scripts in git are shell or Perl.
>> >>
>> >> Neither perl, nor shell, nor python scripts solve the forking problem. My
>> >> proposal does.
>> >
>> > It does,
>>
>> No, it does not. All the **current** perl/shell/python scripts use
>> 'git foo' commands to achieve everything.
>
> As I said, "It does" meaning "Your solution solves the forking problem".

Oh.

>> > and so does Lua,
>>
>> There is no lua in Git.
>
> There's no ruby in git either as far as I know... (and no, I don't think
> contrib/ counts).

There is when you apply this patch.

>> > which can be bundled with git and used in the
>> > configuration files as well and is pure ansi C. However bundling
>> > something has it bad sides too. At least this will solve the dependency
>> > problem. So let the language war begin =).
>>
>> Talk is cheap, show me the code.
>
> See this thread by Jeff King:
> http://thread.gmane.org/gmane.comp.version-control.git/206335/focus=206337

That is very very far from what I'm doing.

> And see my humble test of what the speedup would be for git-submodule
> even with a faulty lua integration (still forking... but huge
> performance boost anyway):
> http://thread.gmane.org/gmane.comp.version-control.git/228031/focus=228051

I don't see how that is relevant, but I'm certain the same can be done
with Ruby.

> As you can see a lua integration would increase the git binary with
> 300kb.

And my patch would increase it 49Kb.

IMO the problem with lua is that it's too simple, it's syntax doesn't
resemble c, perl, python, shell, or ruby, it's just weird. Also, it's
much less popular, it's not as powerful, and there isn't a big
community involved with Git like with Ruby.

Sure, for a couple of simple scripts lua bindings would be great, but
for the future, better maintainability, and to grab future developers,
Ruby is simply a better option.

-- 
Felipe Contreras
