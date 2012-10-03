From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Wed, 3 Oct 2012 18:35:15 +0700
Message-ID: <CACsJy8CUK0g4FhuJxzJqN7qS2apoO2zYdg_SGvWzEN5dGcHhaA@mail.gmail.com>
References: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com>
 <506A9EA6.9010303@gmail.com> <CALkWK0=X5nJ6Shwa0+6Jk2cgvvo25j=mKLRs4v=eQY7x9+XvFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:36:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJNF7-0007CQ-GZ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 13:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab2JCLfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 07:35:47 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:45078 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab2JCLfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 07:35:46 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1474037qad.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t9I4UIa0TVsRC03cZJ8c8HquwgPca4jr7PjQ45dIqtY=;
        b=QhIJC+lVibVHCJZ2pEkBQN2RrtMU+B8VQznK5uA51MA4ZX7Bs0k0Nc5Nv9SxVe8jzP
         D1TekIMldFl/D9QkXtHJoSNoz7uhgC+SxA8dZKB7esZmI0ui3B/XqXAPWnd9ie0luPLn
         dpj0igNP249eKgI5uYtp9D46E+Wqo/9Qbr8WVrQxJcLYEQv3GP/7ij4m4qGGhQmNB18Q
         B11JYXok4022lWV2FjBWb1duNr+iG4e65DPlZL8CzE5MhkOhUENXwfBhTxKuEvgZbRMB
         piQwV5J5zo+By5uCm4otk8NwTO2clXs5ffla+pG8mHENtaLI7+ngYOwx8o30BcW+236Z
         CXwQ==
Received: by 10.49.104.9 with SMTP id ga9mr11272990qeb.39.1349264145900; Wed,
 03 Oct 2012 04:35:45 -0700 (PDT)
Received: by 10.49.72.201 with HTTP; Wed, 3 Oct 2012 04:35:15 -0700 (PDT)
In-Reply-To: <CALkWK0=X5nJ6Shwa0+6Jk2cgvvo25j=mKLRs4v=eQY7x9+XvFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206880>

On Tue, Oct 2, 2012 at 3:24 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Stefano Lattarini wrote:
>> On 10/02/2012 09:21 AM, Ramkumar Ramachandra wrote:
>>> Hi,
>>>
>>> I've often found the '**' (extended) shell glob useful for matching
>>> any string crossing directory boundaries: it's especially useful if
>>> you only have a toplevel .gitignore, as opposed to a per-directory
>>> .gitignore.  Unfortunately, .gitignore currently uses fnmatch(3), and
>>> doesn't recognize '**'.  Would extending the .gitignore format to
>>> accept this be a useful feature?  Would it involve re-implementing and
>>> extending fnmatch, or is there some other way?
>>>
>> I think there is a topic in flight about this:
>>
>>     <http://thread.gmane.org/gmane.comp.version-control.git/206406>

While I'm behind this series, I have no use cases for it in my
repositories. It's tested in git test suite but that's about it. Some
feedback would be nice, especially on the performance side if you do a
lot of ignores.
-- 
Duy
