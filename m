From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: creating a new branch without an ancestor
Date: Thu, 4 Feb 2010 22:32:43 -0500
Message-ID: <76718491002041932m3398abdel85bd1f4e1eb96899@mail.gmail.com>
References: <d2e97e801002041919r2043d05cjfb114a466605d9a1@mail.gmail.com>
	 <20100205032429.GA23285@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Wookey <michaelwookey@gmail.com>
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:03:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL2Y-0003Bj-9k
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868Ab0BEDcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 22:32:45 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:33091 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668Ab0BEDco (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 22:32:44 -0500
Received: by iwn27 with SMTP id 27so510039iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 19:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=k0GDtrMW3PHG6RR4ezzmp1RG9HregrX5QJEK+8l9TlI=;
        b=F2sPUtnhJc4deB7aYpCm/ajd1FQdzqTtFMrF9kVLcyTo7Ee7Z55E2ssEErunG3AjZv
         0z8sf+/726/oPMx8EUw1sD8b/CkDBxbjfeiIT4OWkLejVS1QF8/fsuP+K7UDb/+ZiqSx
         kkl3GVfHpehr5d42onk8VOxGkWsxdwcox/8Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NGfU+EuxxBvAnm725llVKL9FAJGG/ZVn1aohBk1AWVRCy4ek4T6XWNtsq7ttQVN7QZ
         IyCRKYG9i2oy1eHiiIxx8P4XrZmYNJhnZl4N99Q7xER5i8kB6R/swy/HXKxJxzmqguAX
         2+KjGZJ+gb8CboTbeZhW7ruZiO1PRY8sPSGyQ=
Received: by 10.231.145.206 with SMTP id e14mr1327039ibv.10.1265340763935; 
	Thu, 04 Feb 2010 19:32:43 -0800 (PST)
In-Reply-To: <20100205032429.GA23285@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139025>

On Thu, Feb 4, 2010 at 10:24 PM, Larry D'Anna <larry@elder-gods.org> wrote:
> * Michael Wookey (michaelwookey@gmail.com) [100204 22:20]:
>> Maybe I'm missing something from reading the docs, but I couldn't see
>> how to create a new branch in an existing repo that has no ancestor. I
>> would like to do something like what git.git does with some of the
>> other ancillary branches like "man", "html", and "todo".
>>
>> I was hoping to do something like "git branch --no-ancestor
>> new-branch-name" but didn't see anything in the documentation that
>> describes the necessary branch options.
>>
>> Or, am I looking in the wrong place?
>
> git symbolic-ref HEAD refs/heads/whatever
>
> That'll leave your index and working tree alone of course, so if you did a
> commit right after that it would match the content of your current branch but
> not the history.

You can also create the branch in a new repo, then just fetch that
into your existing repo.

j.
