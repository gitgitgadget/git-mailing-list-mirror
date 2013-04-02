From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Composing git repositories
Date: Tue, 2 Apr 2013 12:20:17 -0700
Message-ID: <20130402192017.GI28148@google.com>
References: <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de>
 <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de>
 <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
 <51597A37.1010301@web.de>
 <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
 <20130402185426.GG28148@google.com>
 <CALkWK0kCcSgHfmTuQc-0XGHOdm6PPaVHqFeD4bko-zq3pH8mUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:20:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6lH-0001Kb-5G
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab3DBTUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:20:23 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:34647 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab3DBTUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:20:22 -0400
Received: by mail-pb0-f52.google.com with SMTP id mc8so408798pbc.25
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=77bORXRwwiDpQGvNSmEQtoqkyPKTmle++aaxLOhQHOw=;
        b=Vu5N1Xf4QV/LswVirRMK74dghQPHAzE1VRYv2G9xpeLH2x3wFa3gHrWD7DYOOWQykK
         E0tPL+uCeQhIC+zekjTOWH3llynB666fYW0R7FrW1e24a0WPYOsTituHRJzj+e1LLpub
         PrUd2GrVxIzG1UpSt/TtahyFQLVftDfaTRGZgyKgjcNofadrtNn7555OROdBjN+LjY8x
         ZNrSFiDcUdVQH/P9hIul+8nIGT1gehp7YaJ/HeVKAFx/I+seq4wriEwueFXbnNtJednK
         2W1nyvEg5zJhRn/4yLE5SgFo9Z8gdPR89El6G7MBb0WvVjnjXr+PVaOVwspHhOmeP+l3
         TOzg==
X-Received: by 10.66.168.6 with SMTP id zs6mr26715990pab.5.1364930421911;
        Tue, 02 Apr 2013 12:20:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id fc8sm3450872pad.21.2013.04.02.12.20.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:20:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kCcSgHfmTuQc-0XGHOdm6PPaVHqFeD4bko-zq3pH8mUw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219857>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>>         $ git clone git://repo.or.cz/git.git
[...]
>>         Don't forget to "git clone -b todo git://repo.or.cz/git.git git/Meta"
>>         for maintenance scripts.
>>         $
>
> Nope, it's not mandatory for everyone to use dotfiles.git in exactly
> the same way either.  In other words: I'm not sitting in an office and
> working with my colleagues on exactly the same things, in exactly the
> same way; wasn't that the Subversion age?  Some might decide to
> initialize a few submodules, change the URLs of some, and remove some.

Can't a script pointed to in README handle all these things?

>  I'd want my private fork to have commits changing "initialize
> submodule quux" to "don't initialize submodule quux", and be able to
> rebase that on top of upstream.

These would be patches to comment or uncomment repositories in the
list used by your "setup" script.

>                                  Why are you leaning towards solutions
> for very narrow usecases?

I don't think this hostile way of explaining things is warranted. :/

Yours,
Jonathan
