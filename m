From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: `git checkout --orpan` leaves a dirty worktree
Date: Fri, 8 Feb 2013 12:31:39 -0800
Message-ID: <CANiSa6hD=zX5=evziqQpXHdjUDEU80t_Du7L+Hpa11ru=5XVNQ@mail.gmail.com>
References: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uc8-000865-0k
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947028Ab3BHUbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:31:41 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40291 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946957Ab3BHUbk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:31:40 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn17so1336439wib.16
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 12:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xoqcW9MBc5iFWErtQ5T2IiIeaekeKaXqcbnnuK0xXU0=;
        b=X+SzkwTuYw2ObeaPy0CUIcMEQhJPYUYYW4MiVlhS4LhEOgC0wL23irX9+XPOHF/JDo
         ZNcQmsKOGwSwY6WjeR7vSgubRt6W3WCcQGBG8Q9su1AcZP5u9xlbwD5Ia0hk7v7SpV3W
         u67d4hrQ2VAQ7MtYP66vprfn5RmE2WSksdflJCWMs5rfzKVfQk3ISGPMewWDAWW0yetJ
         3knZab4exfvGJAJO02k4I/dvJ9Xq4RLGq7W2Yorb7IA1Azi0gtczmdpTL7KF/i5gJ1Ua
         QUIqxIJT9K9TAOEoZ6CDZALYym/eWnj+z/UtbNiwnur37OV9LGhWYRjBrNyBFMNwwzOT
         v8iA==
X-Received: by 10.180.85.97 with SMTP id g1mr4858481wiz.29.1360355499517; Fri,
 08 Feb 2013 12:31:39 -0800 (PST)
Received: by 10.180.85.8 with HTTP; Fri, 8 Feb 2013 12:31:39 -0800 (PST)
In-Reply-To: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215815>

I'm curious what your use case is.

The behavior has been inconvenient for me too, but I have only used it
in test cases; I have no real use case where I wanted to create an
unborn/orphan branch.

On Fri, Feb 8, 2013 at 11:50 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi,
>
> Why should I have to `git rm -rf .` after a `git checkout --orphan`?
> What sort of misfeature/ incomplete feature is this?
>
> Ram
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
