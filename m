From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Fri, 7 May 2010 01:25:25 +0200
Message-ID: <o2v40aa078e1005061625md5fede79h660a22227c4f22d1@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com>
	 <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>
	 <o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com>
	 <i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com>
	 <alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org>
	 <h2x600158c31005061300tfe485e01x251ae20b22ef5b27@mail.gmail.com>
	 <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
	 <w2h600158c31005061514m1fc1e75ay9096eb27d9a1a4ba@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: hasen j <hasan.aljudy@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 01:25:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAARh-0002rI-Qt
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 01:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab0EFXZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 19:25:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42871 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0EFXZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 19:25:26 -0400
Received: by mail-wy0-f174.google.com with SMTP id 36so422824wyg.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=BGQZcsW+K5h/W2cbMzBCiuH4mAcyPa7ynJrZErUSSJA=;
        b=fIXclMhj24zhcyumXJBrKNT9+74Qa/syyieC4L1kqqJZYk92MPNYHbSPFgtqCLL9w8
         VGH3TBH4M6gfW7+dn/YZa9zHf3R4jWPIWiYMb4hhaTnP1Dmpyhm+D5+8q1QqLnJAr0dh
         9+Q2VBxl8u0amWcyVGPtc+hiF0HZtMbG0H3W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=elsqH+/U8MyOuFcp5zx0e3vK49UlLNsfb9HfV1pQOxssl34zIMtOED09efRwKIdnhR
         6HsYQ2UXS8GwlAxGv3y8Cy3xwqyPef0h6E7HyhNhsDXM1rZPhvekayMWE+kJnXuNg4y7
         PZtRDh48JjtHlFhLR6b2RdbipPLrE++0XvlWg=
Received: by 10.216.93.79 with SMTP id k57mr1263580wef.161.1273188325267; Thu, 
	06 May 2010 16:25:25 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Thu, 6 May 2010 16:25:25 -0700 (PDT)
In-Reply-To: <w2h600158c31005061514m1fc1e75ay9096eb27d9a1a4ba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146511>

On Fri, May 7, 2010 at 12:14 AM, hasen j <hasan.aljudy@gmail.com> wrote:
>>>
>>> When I'm on windows, I prefer LF (unless the project already uses
>>> CRLF, or it's outside my control).
>>>
>>
>> "When I'm on windows" leads me to believe Windows is not your primary
>> operating system. If not, please excuse me.
>
> I used to be, I only moved to linux about a year ago, but I use
> windows at work, and I started using git when I was on windows.
>

OK, I'm sorry for assuming some Windows-ignorance.

>> Open source isn't the only model for developing software.
>
> But it's probably the most common scenario where people run into line
> ending issues.
>

Closed source does not imply a single operating system, and you get
these issues whenever you have a project with targets systems with
different newline style. In my day job I develop closed source,
multi-platform software, using git. So it's certainly not MY most
common scenario.

And even if it were, so what? When did we start only caring for the
most common case?

> If the project is a VS project, then it's probably not multi-platform,
> plus everyone at the company would be using windows anyway, so there's
> no line-ending issue.
>

Using VS on Windows does not exclude other platforms either. Either
one can maintain multiple build-systems for Windows and Unix-y
systems, or one can use a system like CMake that automate the job.

A typical case where you pretty much have to build using Visual Studio
is when you develop a C++ library, where your Windows users use Visual
Studio (due to C++' symbol-mangling you have to use the same
compiler). This is not an entirely uncommon situation for open source
software.

>> And again... even if it were, working well together with
>> visual studio support would be very beneficial for quite a bit of
>> projects. Visual Studio is probably the most used code-editor among
>> Windows-developers (with a good margin too, I suspect), so ignoring it
>> is would just be sticking your head in the sand - or worse, asking for
>> less contributions from Windows-users (which can often be a problem in
>> the first place).
>
> The problem can be avoided with a little bit of education. VS is not a
> multiplatform IDE anyway
> Sure, it can't work with LF endings as well as notepad++, but it's not
> git's responsibility to try to fix that.

Again, using VS on Windows does not exclude other platforms. I'm not
sure what you mean with "a little bit of education" here, though.

CRLF is Windows' native newline style. If git can't check out to that,
it'll look like a lot less attractive solution to anybody that targets
Windows compared to the competition. If it wasn't for core.autocrlf, I
would have never switched myself.

>
> I just don't think it's a big enough issue to be built into git.
>
> IMHO it's much better to work around the problem (if and when it
> arises) by using clean and smudge filters in .gitattributes, than
> having it built in and enabled by default in the msysgit installer.
>

But it IS built in. And it's very unlikely that this feature will ever
be removed. So what's the problem with using it?

And it's a very common thing to want to do, so why make everybody who
does have to jump through hoops just because YOU don't need it?

-- 
Erik "kusma" Faye-Lund
