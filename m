From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Fri, 7 Jul 2006 14:23:09 +0300
Message-ID: <20060707142309.4d9601dd.tihirvon@gmail.com>
References: <20060706124025.G325584e9@leonov.stosberg.net>
	<20060706161011.ccc2ea1c.tihirvon@gmail.com>
	<20060707110655.GR29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dennis@stosberg.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 13:23:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyoQO-0006wl-9r
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWGGLXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWGGLXF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:23:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:17353 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751094AbWGGLXC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 07:23:02 -0400
Received: by nf-out-0910.google.com with SMTP id x4so49711nfb
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 04:23:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=sAq5UqdN5spwemSBe0OyUel+MtVNdTcF3hJ/qtHKuJdSKLNOkN/AXjyZVLFje1OMGDvRWGq6MtIXBcmBAcrqFag8dVc2Lzw2RZis3d/GMb0zBR7xmFPHSqGHYt7dCKlmyGrdDJ7h2ET3qAfPAM4B/0WTa9p6/Rmjyj0ua9B5Kog=
Received: by 10.49.15.1 with SMTP id s1mr1295577nfi;
        Fri, 07 Jul 2006 04:23:00 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id g1sm8823885nfe.2006.07.07.04.22.59;
        Fri, 07 Jul 2006 04:23:00 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060707110655.GR29115@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23431>

Petr Baudis <pasky@suse.cz> wrote:

> Dear diary, on Thu, Jul 06, 2006 at 03:10:11PM CEST, I got a letter
> where Timo Hirvonen <tihirvon@gmail.com> said that...
> > "which" isn't portable. On SunOS 5.9 "which foo" prints error message to
> > stdout and returns 0.
> 
> Wait, Git runs on SunOS 5.9?

I have no idea.  I noticed the problem with "which" when I ported my
cmus configure scripts to SunOS.

In the git Makefile there are:

ifeq ($(uname_S),SunOS)
...
    ifeq ($(uname_R),5.8)
...
    ifeq ($(uname_R),5.9)


so it at least tries to work ;)  Oh and that 5.9 is apparently kernel
version, not OS version.  Sorry for the confusion.

-- 
http://onion.dynserv.net/~timo/
