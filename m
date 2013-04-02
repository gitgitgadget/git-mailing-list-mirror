From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 3 Apr 2013 00:59:50 +0530
Message-ID: <CALkWK0kFm8n9CgtvtW=b-JPKO-ZJBn0Dh6z9B0C0_7_EJAb_7A@mail.gmail.com>
References: <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
 <51597A37.1010301@web.de> <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
 <20130402185426.GG28148@google.com> <CALkWK0kCcSgHfmTuQc-0XGHOdm6PPaVHqFeD4bko-zq3pH8mUw@mail.gmail.com>
 <20130402192017.GI28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6v5-0007uF-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab3DBTab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:30:31 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:51904 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760406Ab3DBTaa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:30:30 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so606033iae.25
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vXnTnQ/EhopbnSu3Pc0E9Tg5Ut+JgT6jL46fgKK2umU=;
        b=DDPYgusyM3XwcezXlYdzVqRDGYxrfGxAslL3yG3IK2a5C9CliBZxylH/y+nPB/2poi
         Uh7515UAWc3I6KepbQqOdnRa3LwCj1ViNyaMmzW7OnJvLFRRWYG6cGbP3wNyBsYfqWQM
         devT0aR3m9F+6mHWH9HoohoMpiIemoH1YrRSWIpau4/zc4LXfinbjx0k0YNuYOBWYqmx
         nrhfKzIbtATXacJLpohQoouQJA8b0Imyfkjp0kdSdGULx8BI/gP2pmNVl/Wk8fZdIG1k
         lkisCsvgIOxQbe740ztKlyVeyAlAZU2rgkCPAhfLmzxcaioT5ZzmAYr6HTibfV+G3Q99
         SesA==
X-Received: by 10.50.17.201 with SMTP id q9mr5376699igd.107.1364931030290;
 Tue, 02 Apr 2013 12:30:30 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 12:29:50 -0700 (PDT)
In-Reply-To: <20130402192017.GI28148@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219859>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder wrote:
>
>>>         $ git clone git://repo.or.cz/git.git
> [...]
>>>         Don't forget to "git clone -b todo git://repo.or.cz/git.git git/Meta"
>>>         for maintenance scripts.
>>>         $
>>
>> Nope, it's not mandatory for everyone to use dotfiles.git in exactly
>> the same way either.  In other words: I'm not sitting in an office and
>> working with my colleagues on exactly the same things, in exactly the
>> same way; wasn't that the Subversion age?  Some might decide to
>> initialize a few submodules, change the URLs of some, and remove some.
>
> Can't a script pointed to in README handle all these things?

If it came to that, it's quite possible to write one giant Perl script
to do whatever I want (see: git-slave).

What will I be merging and rebasing?  One configuration file stuffed
with miscellaneous repositories.  Don't you think this is highly
unpleasant?  Why would I want to write slightly different scripts for
each of my repositories?  I'd want to write down several different
adjustable knobs to use something that's well-integrated into core
git, like we do in .git/config (except we can't share a .gitconfig
yet).

> I don't think this hostile way of explaining things is warranted. :/

Sorry about that.  No hostility intended.
