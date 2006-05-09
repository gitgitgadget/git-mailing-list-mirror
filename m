From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Tue, 9 May 2006 23:10:31 +0300
Message-ID: <20060509231031.b62576da.tihirvon@gmail.com>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
	<11471512103526-git-send-email-normalperson@yhbt.net>
	<20060509120809.4d9494b9.tihirvon@gmail.com>
	<20060509191803.GA3676@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 22:09:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdYW7-0004Va-6W
	for gcvg-git@gmane.org; Tue, 09 May 2006 22:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWEIUJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 16:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWEIUJH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 16:09:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:46905 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751117AbWEIUJG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 16:09:06 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1269758nfe
        for <git@vger.kernel.org>; Tue, 09 May 2006 13:09:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=JOfCltvb5Pvn2eGx9DSIlwew8H1HZ3q6oW7fJDB2nMZvwAAOmPRt7xoZcGPJ5PvGoK1N9yKVUKK6VjjQGJihUiq/YjXh3c9LlrE//DiubR0J5YDdaSJJlGT+6oJrRiBH7LyG8cNGVmQnH4LboJB/EXL9PNgtw+e3sFVJEwR8FIw=
Received: by 10.49.34.18 with SMTP id m18mr2378574nfj;
        Tue, 09 May 2006 13:09:03 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id b1sm3692039nfe.2006.05.09.13.09.02;
        Tue, 09 May 2006 13:09:02 -0700 (PDT)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060509191803.GA3676@localdomain>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19846>

Eric Wong <normalperson@yhbt.net> wrote:

> I'm striving for backwards compatibility with existing usage.  That
> means as a diff option, -C alone works, as does -C20.  I've made -C 20
> _not_ work because it breaks existing usage (where 20 could be a
> filename, or a tree-ish).  -C=20 would mean something
> else,

I think optional arguments are still confusing.  We could support both
-C (no args) and -C=20 syntax.

> since I wanted to make pickaxe work exactly as it did before:
> -S=var would search for '=var', not 'var'.

Some other options use -x=y syntax so this would be confusing. Pickaxe's
-Stext syntax is a bit strange.  I think -S text or -S=text would be
more logical.

-- 
http://onion.dynserv.net/~timo/
