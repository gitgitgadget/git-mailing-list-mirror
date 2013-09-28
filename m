From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sat, 28 Sep 2013 17:57:45 -0500
Message-ID: <CAMP44s2Fg2NwinKTDrHjKhKQkniwAZD041n8QYrN5oOjOJ8osQ@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
	<CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
	<20130921235647.GC235845@vauxhall.crustytoothpaste.net>
	<CAPc5daWa0BPXdrYqek=WzixVVfh0DvHhxjtOh2LW6bgR0MAOPw@mail.gmail.com>
	<20130923014157.GE235845@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Sep 29 00:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ3SQ-0003VP-Nz
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab3I1W5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:57:48 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:41709 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab3I1W5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:57:46 -0400
Received: by mail-la0-f42.google.com with SMTP id ep20so3342179lab.1
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a3QZX0/2tWj2azq39ZdQB5887uwzOyXd1LcDUSz9OPk=;
        b=Zf1hD7hjxitxAEEQEQa5YSB7seMS8dGlRyfU6qFPIHOwVnZv8fDGmftMBems8WY5F/
         cD7iHQB7Pq0DO/82Vkt+Q32sJW5pYQ9O3EewfShPw/Ej+mPAkllr6L7lbdQb/pxLBmsm
         duBhH2kE2yCifWwpsG5fU2i885UWEyFvURy93DLEFtHEkAjfnmQymIJvov1y6e8LrEf6
         +5meU+EAZKTZd8vFAOtA6rBLqPpnkmk4L1D+CsXXpnbroUgjxD3s8raQU9nFlySWizLw
         zcz66/cw3WOAEVfox7STj9O4HlKml4FlSEWEoDVWxFTaV9goxd7dhFiykWfr9A+sRjoh
         Ly4w==
X-Received: by 10.152.45.106 with SMTP id l10mr12575711lam.12.1380409065381;
 Sat, 28 Sep 2013 15:57:45 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 15:57:45 -0700 (PDT)
In-Reply-To: <20130923014157.GE235845@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235567>

On Sun, Sep 22, 2013 at 8:41 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Sep 22, 2013 at 05:00:44PM -0700, Junio C Hamano wrote:
>>  - Moving away from higher-level scripting languages such as shell and Perl.
>>    Recent "clean --interactive" may have added some code that could be
>>    reused for a rewrite of "add -i" (which I think is in Perl), for example.
>>    The minimum "You need to have these to use Git" should be made more
>>    portable by doing *less* in shell or Perl, not by adding more in the higher-
>>    level languages, and certainly not by adding other languages, be it Ruby or
>>    Lua.
>
> I can certainly go for that.  C is faster and the codebase can be more
> consistent (and more portable to non-Unix).  My concern was that if
> we're going to be adding additional languages, some previous warning
> would be appropriate.  As I said, I wouldn't be able to deploy a git
> using Ruby immediately, and I'm sure I'm not the only one.  If we're not
> going to be adding another language, then obviously the issue becomes
> moot.

You could just build with NO_RUBY=y. Problem solved.

-- 
Felipe Contreras
