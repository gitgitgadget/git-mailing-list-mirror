From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 3 Apr 2013 01:19:02 +0530
Message-ID: <CALkWK0=HJP_ScNn7BQzvZeacFEUpN4i3MhYMUt1x0mHNcv3U4A@mail.gmail.com>
References: <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
 <51597A37.1010301@web.de> <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
 <20130402185426.GG28148@google.com> <CALkWK0kCcSgHfmTuQc-0XGHOdm6PPaVHqFeD4bko-zq3pH8mUw@mail.gmail.com>
 <20130402192017.GI28148@google.com> <CALkWK0kFm8n9CgtvtW=b-JPKO-ZJBn0Dh6z9B0C0_7_EJAb_7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7E3-0004kR-0l
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933134Ab3DBTtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:49:45 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37630 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401Ab3DBTtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:49:43 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so842835ieb.8
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FMln/ujI5s68aDcw4UwIOa8L4NNxw8n28qQL6MoKy9Q=;
        b=UC8u6BRXE7PBxqykUFbWgE7B4LTdTg9HQma63lJPBZOo9Ic02PIh06cQGH6FZ5hv4N
         C1PhruPg0NGOHYHieTAZXIVMZRXNRlbPIFc7o2MoAm6yhPabTXQeW3uUlBAR00WPZ724
         JIU8w7VF+Q1DWZNLEl5vKO2gyMqEC7BuzkxShooChcB01zTHL8TqLCVt1brOnmmHcfra
         Lp5FgCDo+Ms0pfvtDixwO1O+99xoEj3AoUcrKnC6bFUrMPvUj+Mxb/hXGA6TQuUb4cYo
         l/fzaQ80oZ8W7s6Zu1Pat0rNe7vJK5OZnJgYueRXSGsGbByw2prHBcpMJGHHZPEf4R/g
         gSGA==
X-Received: by 10.50.17.71 with SMTP id m7mr5872937igd.14.1364932183350; Tue,
 02 Apr 2013 12:49:43 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 12:49:02 -0700 (PDT)
In-Reply-To: <CALkWK0kFm8n9CgtvtW=b-JPKO-ZJBn0Dh6z9B0C0_7_EJAb_7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219866>

Ramkumar Ramachandra wrote:
> What will I be merging and rebasing?  One configuration file stuffed
> with miscellaneous repositories.  Don't you think this is highly
> unpleasant?

I spoke too fast.  Isn't that exactly what we do with .gitmodules
today (I'm not saying it's ideal, but I can't think of an
alternative)?

Yes, you're right: a simple script with a configuration file can
manage only floating submodules quite well.
