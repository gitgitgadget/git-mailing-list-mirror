From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 14:23:42 -0700
Message-ID: <20130407212342.GA19857@elie.Belkin>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan>
 <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan>
 <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan>
 <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:47:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pm-0000sy-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934405Ab3DGVX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 17:23:56 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55038 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934402Ab3DGVXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 17:23:54 -0400
Received: by mail-pd0-f181.google.com with SMTP id y10so2884640pdj.12
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AMdvrcPkiofm09cvQzj2V6d9ktZaE4prg8l2ifDz+nM=;
        b=jlS6CwEU/ws7Jpd5gHCOZsso87ObYlRDotMS0dugyxCVhgP8jS2FpZx/JlB896bU5A
         3grn1wnuG85XClQugg7lOLbn5EduMVmujmoADjSTSxzG0hRmAS/VNrLmZb94zQo7CndY
         C0scc08i8KO8iRlq9jvmmg7QgNpHfQtYBHcNS1epi17e/hUP9u5Xs3qKeRJgBBwMCjgG
         E2Zu2AZF59aWiOVRXgZ3nqumQVjMVFHFFL6lBfD1h9TLUDVLRDGUmBIu8ElwveFb+h9y
         qB6VAN/UfWMTUSGxU7ffptbBpau3wUv6OPDMTYtwxjeeYM53JQtJrZ/f0VuoDqXH9icF
         lLzw==
X-Received: by 10.66.76.170 with SMTP id l10mr30649162paw.190.1365369833711;
        Sun, 07 Apr 2013 14:23:53 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id rt13sm33122785pac.14.2013.04.07.14.23.51
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 14:23:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220384>

Ramkumar Ramachandra wrote:

>             It's about the core object code of git parsing links, as
> opposed to a fringe submodule.c/ submodule.sh parsing .gitmodules.

What's stopping the core object code of git parsing .gitmodules?  What
is the core object code?  How does this compare to other metadata
files like .gitattributes and .gitignore?
