From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] submodule: make 'show' an alias for 'summary'
Date: Mon, 1 Oct 2012 23:03:49 +0530
Message-ID: <CALkWK0mQMe1zfbPNf5prjgTwFtPKJuK=uwxqAqN_Q2=76e-=mA@mail.gmail.com>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
 <50670A94.2070504@web.de> <CALkWK0nCahg7165_JuJSj7u0UfYRGZgFjJ6O-o=HCwdsPwU-xg@mail.gmail.com>
 <50671364.5030205@web.de> <CALkWK0nRKopT4fm36UVyR4Jy1gfeSY4zGy+-nzxm=H=NGcR=DQ@mail.gmail.com>
 <5069D24A.6060101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:37:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIjst-0001Im-L8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab2JAReM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:34:12 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59970 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab2JAReL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 13:34:11 -0400
Received: by qchd3 with SMTP id d3so3875834qch.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JYGh5WJYT203uI2yzlW9fsc6P5qMVxAPG7tgAlEYigA=;
        b=iGzzPuiGLvJEv7meHRfMthciRwKLpCDNwMDORTCjhZ0gnlDuUDIUtNlYbpg8h3NOcw
         qrFcJY6hWqrVae7lQ1StuesQsHbRvKdVHbI5f9+uXec2zF+Bt9I72PnUZ9vdSmidDGVf
         2Fwp5Fop6z8TfmejAwOVNdFScQP8z1YLWDNxrZFHcpYasjZ78wRGZPW47A5df1RUlM5h
         wtFJSAdphjZGkx5KLM8BFgJ3Y6bK2yXDDOjiKwrbqiRPC/I0whoOoH4xrLOCP6NS8Jea
         Yxn3+WS3Pg/WtWRWXRcHRELrYJFJU/X5xT3Ht6KXAM0tzGUcSGgfJVNrUyGSA1TZLTH1
         ZsPA==
Received: by 10.224.213.10 with SMTP id gu10mr38669502qab.10.1349112850302;
 Mon, 01 Oct 2012 10:34:10 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 1 Oct 2012 10:33:49 -0700 (PDT)
In-Reply-To: <5069D24A.6060101@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206748>

Hi Jens,

Jens Lehmann wrote:
> Am 01.10.2012 08:45, schrieb Ramkumar Ramachandra:
>> Jens Lehmann wrote:
>>> I'm very interested in your feedback as a first time submodule user,
>>> what you wrote above makes sense and explains why you did that patch
>>> (and it would have been nice to read some of it in the commit message
>>> ;-). What information did you expect to get from a "git submodule
>>> show" which isn't already provided by "git status" and "git diff"
>>> (especially as they give you some information the "git submodule"
>>> commands don't)?
>>
>> I expected 'git submodule show' to list all the submodules, and show
>> changes to specific submodules like the 'git submodule summary'
>> output.
>
> Ok, but "git submodule summary" doesn't list all the submodules,
> only those with changes. Maybe "git submodule status" is closer
> to what you expect (except for the missing changes)?

Yes, "git submodule status" with "git submodule summary"-style change output.

> And - apart from the list of all submodules - the changes to them
> are given by "git status" and "git diff --submodule" too, right?

Oh, I didn't know about "git diff --submodule" at all.

> (sometimes I forget that "--submodule" is not enabled by default,
> as I'm a heavy "git gui" user, and that option is used there. We
> might need a config option to turn that on)

That's a good idea.  I'll write a patch tomorrow.

> Me too would expect a show command to show me a list of all the
> submodules and maybe some extra information (is it populated or
> not, does it have its .git directory embedded, does it contain
> changes). So maybe "show" should be a slightly pimped "status"?

Sure.  Do we want to create a new subcommand though?  Aren't "status"
and "summary" enough already?

Ram
