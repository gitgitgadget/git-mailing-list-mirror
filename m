From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/7] am: suppress error output from a conditional
Date: Tue, 23 Apr 2013 22:01:25 +0530
Message-ID: <CALkWK0mTGFiuYhsJMf0x9YrO2ke21YmhzhiQQmqLqG61=pVFdw@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
 <1366725724-1016-2-git-send-email-artagnon@gmail.com> <CANiSa6i+jsZUBgeQcQq2C=d009dU=i6+g35-HoofedaEJRmzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgBC-00018m-02
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030Ab3DWQeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:34:20 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34457 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237Ab3DWQcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:32:06 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so905071ied.33
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bm+/xaCQ6tWkqgS9nHXS0JHDjFPEWPa/MC0sOOzsYHQ=;
        b=gmmfYVwHrfhz8mgoYk20gTUdaJJkueqKXfTW7lzaBjp1JxDBd7rlgiivsQKzRAONvc
         aktk5//vdihSXyyC6y1PwwxCKV9GOW/abdBKRlO9EWFygQWvoR7lNa2BSUaoC6oUjTR1
         iitC21vLW1CVBD2cHwnC+YxYOxiU5hi8CeNNxjubJm7zN6VYRBnvmXi8XTdR4QVLk2VI
         imzg/0JDee7b26YZJEQi2Q2rr0Im30V+CZspJ92l8FNrf1dnpWsnwwh7iVKKirEGEhQV
         7tR0ZoBWmIt0UkT4qzZLgKy/BC70c+5yb0mcOJJiYtv/QNQJhirJ1Y5bvRYTTJ9ff3Tl
         yoPg==
X-Received: by 10.50.119.102 with SMTP id kt6mr19067685igb.12.1366734725676;
 Tue, 23 Apr 2013 09:32:05 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Tue, 23 Apr 2013 09:31:25 -0700 (PDT)
In-Reply-To: <CANiSa6i+jsZUBgeQcQq2C=d009dU=i6+g35-HoofedaEJRmzTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222187>

Martin von Zweigbergk wrote:
> On Tue, Apr 23, 2013 at 7:01 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> When testing if the $dotest directory exists, and if $next is greater
>> than $last
>
> When can that happen? If one edits the todo?

When git-rebase.sh creates a $dotest directory with just an autostash file :)

Like I said in my cover letter, I really wrote [7/7] first, and kept
modifying things until all the tests passed.  So, I can't really
justify these changes independent of [7/7].
