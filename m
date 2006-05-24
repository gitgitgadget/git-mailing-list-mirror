From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] gitk: Replace "git-" commands with "git "
Date: Wed, 24 May 2006 13:34:55 +0300
Message-ID: <20060524133455.f78b11a4.tihirvon@gmail.com>
References: <20060524105740.2cb97585.tihirvon@gmail.com>
	<81b0412b0605240323q29b64949s80d4738cb54c22c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 12:33:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiqft-0003W8-S6
	for gcvg-git@gmane.org; Wed, 24 May 2006 12:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWEXKdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 06:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWEXKdE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 06:33:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:40419 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932655AbWEXKdC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 06:33:02 -0400
Received: by nf-out-0910.google.com with SMTP id x30so14922nfb
        for <git@vger.kernel.org>; Wed, 24 May 2006 03:33:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=fEzTe8qZbckscDapREKBwDymJoLiDe9EZH1fDZYpB3DnWWXhq4KOQ2hzFVCT9ZGaD3hXEki0gslJP3HZfbAmCOSvEyjpTyt5X2Yofe3aUK4BCOQWgboEgVNwcyq0zVuqgCeYTdWsgPKmAYMB5Ln/CIQnfu8ATJbMSgQzurShAHY=
Received: by 10.49.20.8 with SMTP id x8mr5574775nfi;
        Wed, 24 May 2006 03:33:00 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id z73sm7577476nfb.2006.05.24.03.32.59;
        Wed, 24 May 2006 03:33:00 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0605240323q29b64949s80d4738cb54c22c8@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20677>

"Alex Riesen" <raa.lkml@gmail.com> wrote:

> On 5/24/06, Timo Hirvonen <tihirvon@gmail.com> wrote:
> > git-* commands work only if gitexecdir is in PATH.
> >
> 
> How about getting exec-path (git --exec-path) and prepend it
> to every git-<call> instead? You'll save a fork+exec a call in this case.

Many commands are already built-in so I don't think it's a problem
anymore.

-- 
http://onion.dynserv.net/~timo/
