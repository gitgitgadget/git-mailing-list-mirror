From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 9/9] revert: simplify communicating command-line arguments
Date: Sat, 10 Dec 2011 01:19:41 +0530
Message-ID: <CALkWK0m2veE8FmFVTPEqNAmbtvm1sWVHtFt0QOWU=huQFafeBw@mail.gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-10-git-send-email-artagnon@gmail.com> <20111209190236.GA20913@elie.hsd1.il.comcast.net>
 <CALkWK0m_6yGuyLt-VqvRZkAiDoSxES8KeNzeXaejYRCpW=HAOg@mail.gmail.com> <20111209192919.GB20913@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:50:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6SR-0004rK-LS
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab1LITuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 14:50:04 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55582 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab1LITuD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 14:50:03 -0500
Received: by faar15 with SMTP id r15so1054499faa.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rhxYF1ZcrBtcvrbcSIMkeRP/NQiO+wT+Ps7tpYEis/E=;
        b=p2tAuTuvzR/X7JJJQBg7/w5Rd3TTMdzAi/v6MuENLTA1ZUYiLVHrfwEKuflzK1SETX
         HJkCniPlw5mnFijX1XEf0Do+a5CX6MtUX49Ol4GC8hczq+xsKN9oYFd0BlNb/GRzCPaN
         4HZl5cTm5O57pEuGXzspksGkV4fQGZ9s7PFds=
Received: by 10.180.88.66 with SMTP id be2mr11791933wib.54.1323460202214; Fri,
 09 Dec 2011 11:50:02 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 11:49:41 -0800 (PST)
In-Reply-To: <20111209192919.GB20913@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186674>

Hi again,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
> [...]
>
> So, is it a bad test?

I'll just drop this test.

>> Way starts with creating an API for "git commit".
>
> Not sure what this means.

It certainly doesn't make any sense when you quote it like that.  What
I meant is that: by convention, 'git cherry-pick' is supposed to exit
with positive status on conflict.  Conversely, this means that a
positive exit status can be interpreted as a conflict, but this is
clearly not the case here.  How do we fix this problem?  By creating
an API for "git commit", not by shelling out like this and letting it
take over the exit status.

-- Ram
