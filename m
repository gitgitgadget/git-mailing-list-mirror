From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 3 Oct 2012 15:14:40 +0700
Message-ID: <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:15:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJK7A-0007cL-QR
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab2JCIPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:15:17 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43395 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab2JCIPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:15:12 -0400
Received: by ieak13 with SMTP id k13so16703443iea.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U/gxn9/gAklEzDi7nnl7A9YdF0tkGs0QipcWtAAOKiQ=;
        b=GBCqJSEoa7lyClqMNULexda4USisyYO4rswSWVt+mKAXZL+fsFbch3rUXQUnABH4FA
         hF/PkfhZOQVhop2YlKjr0iV5dwBWlB0hL4coo+kRFXfZ+hy+CEAzWuQ7Xhh7BigtJAxa
         ISdV+jBySwnAcGX9XnDC0TIf1ctHr+cnAeqTlwtlIGX2vsgHxN99qaHWR6rHHIxbj4wo
         m9TIiZwozmgrvwbqxfhtv7F3jzkvG07k4V/6xYN1r75u/mnYeNkZonQfarO14nvcBFP7
         bFNfBMHz2RbF4j2m5AgbZwq3gi9kAhpZHw3k+zDqawyRkal/JdLJb3vjy3+vaQQp2ehK
         7k3A==
Received: by 10.50.220.129 with SMTP id pw1mr11377042igc.47.1349252111358;
 Wed, 03 Oct 2012 01:15:11 -0700 (PDT)
Received: by 10.64.23.197 with HTTP; Wed, 3 Oct 2012 01:14:40 -0700 (PDT)
In-Reply-To: <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206869>

On Tue, Oct 2, 2012 at 10:09 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> David Glasser wrote:
>> Is the newish push.default documented in the "git push" manpage
>> anywhere? I don't see it mentioned (and there are several references
>> to the "default" behavior), but maybe I'm missing something. Is it
>> left out on purpose (ie, config values aren't supposed to be mentioned
>> in command manpages)?
>
> You're right.  It's documented in `man git-config`, but we should
> probably mention it in the `git-push` manpage.

Your patch is fine. I'm just thinking whether it's a good idea to add
a section in the end of each command's man page to list all relevant
config keys to that command, somewhat similar to "see also" section.
It may help finding useful config keys that otherwise hard to find.
-- 
Duy
