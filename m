From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 2/4] diff: introduce diff.submodule configuration variable
Date: Thu, 22 Nov 2012 15:14:18 +0530
Message-ID: <CALkWK0nxcGrpsK__Jc-Q+Y9HDP4pVx6ySrDGgS+4DxO2Rd+xBQ@mail.gmail.com>
References: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-3-git-send-email-artagnon@gmail.com> <7vk3tht7yz.fsf@alter.siamese.dyndns.org>
 <CALkWK0kZ0p4ptmAySXKspU2qJm9gm6Wg4uyBhRnXQ4qdSC34FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:08:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbc8G-0000zF-Ac
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334Ab2KVTHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:07:54 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41754 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab2KVTHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:07:53 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so8350686obb.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RbVUprwhndlPa/Xeeia6jCTjvfv4pbJbbYMI5EyZ2VM=;
        b=zUo7KOViFcuIcJt/PD7MH3UDGcmtkHlG9YneU3/OeiIyIPq0wiQAVTY7uOlimg70hj
         FhvccIw9bR6G77GOOAMGltx9uX2OXhmLDvJh6UDXMHITwcaIYegcUeOj/5RHxhwASCR1
         yyEhEz5Ctq0nZGjdiCmxl5X6vfNsia59zMcJ6XafYNtyQwsV3dFvFf234fMHuB43xjx/
         lCnrYidCX7WTbU6nEgsItC2ZIDfKKlGvnd9pxjltYap31k7xfb8sWxrv/jmniKhjairz
         a8Ue5IkRwDm2xNOgHoJKUoH/I5v2i2EWm04vrNMn7BkcnyjdOs7zD6KL+Zi/3x94oHuI
         RgWg==
Received: by 10.60.171.11 with SMTP id aq11mr18480081oec.104.1353577478273;
 Thu, 22 Nov 2012 01:44:38 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Thu, 22 Nov 2012 01:44:18 -0800 (PST)
In-Reply-To: <CALkWK0kZ0p4ptmAySXKspU2qJm9gm6Wg4uyBhRnXQ4qdSC34FA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210191>

Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> +test_expect_success 'added submodule, set diff.submodule' "
>>
>> s/added/add/;
>
> I see that the topic is already in `next`.  Do you want to fix it up there?

I was simply following the example set by the previous test in the
file: "added submodule".  I can fix up these two after the topic
graduates to `master`, if you prefer that, instead of rewriting `next`
for a small change like this.

Ram
