From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Wed, 17 Apr 2013 20:37:46 +1000
Message-ID: <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 12:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USPkt-0001mJ-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 12:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415Ab3DQKiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 06:38:19 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:60760 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3DQKiS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 06:38:18 -0400
Received: by mail-oa0-f52.google.com with SMTP id k18so1450760oag.11
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=H9PKqklXf64y0tBLsg+c+QrFQw6IEWjHSTwtAoCxpt4=;
        b=OFwR7K6padfDv8HCUQKBmZ6BRQHBOqQ+O7yVe/5yH7CO6VmU9Q+Rk8yS0DDZGMCqVD
         m3E7U3mewnsxtLxNyv3AmXYSopPdSDxuP4U5KZTlfhuICKHnvJ1kLkDmqt6p737IwZon
         nmrPqY5+Pj1C+qW0791MAP9S+a467ToiIiq1v+RgAn/8l4U8FaYHwU5+lcuewVuNTwZa
         d0QBWmRF/a/gnwI4MXqiXx4xXpNOb/TpJ03PauPmb20B9Q+G1+/vDGR4J0tXxJni/ah3
         3xt7cagdnAbgFrJSk7r0hLgd87i+X1BaBVuBm1a7Otq+41RIxm5owvj2aamOLwTxgLBA
         navg==
X-Received: by 10.60.117.35 with SMTP id kb3mr2388475oeb.16.1366195098000;
 Wed, 17 Apr 2013 03:38:18 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 03:37:46 -0700 (PDT)
In-Reply-To: <20130407212342.GA19857@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221531>

On Mon, Apr 8, 2013 at 7:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>
>>             It's about the core object code of git parsing links, as
>> opposed to a fringe submodule.c/ submodule.sh parsing .gitmodules.
>
> What's stopping the core object code of git parsing .gitmodules?  What
> is the core object code?  How does this compare to other metadata
> files like .gitattributes and .gitignore?

Somewhat related to the topic. Why can't .gitattributes be used for
storing what's currently in .gitmodules?
--
Duy
