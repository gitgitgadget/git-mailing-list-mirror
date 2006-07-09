From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Mon, 10 Jul 2006 01:34:05 +0300
Message-ID: <20060710013405.54fbe6bb.tihirvon@gmail.com>
References: <11524258261798-git-send-email-ryan@michonline.com>
	<46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>
	<20060709221326.GU29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: martin.langhoff@gmail.com, ryan@michonline.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:34:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzhqf-0006NH-Bz
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWGIWdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWGIWdx
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:33:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:4154 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161203AbWGIWdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 18:33:53 -0400
Received: by nf-out-0910.google.com with SMTP id l37so313816nfc
        for <git@vger.kernel.org>; Sun, 09 Jul 2006 15:33:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=NWA1voRJg9k2/zk581+CMPv3xDfSRMYS/eq5Dvg+RzVuE2oIOCqnmzkvL17vzFYuqo89aSLry83aKuh7V8m/gOQkztAAPaCPgxw1LrOazTUzJP5JJ0/04DY5qIGz/lrzsvurodK3XgSIP1TcvqV+ryofg1/goYmB3ceCYjHvWgQ=
Received: by 10.49.64.2 with SMTP id r2mr930151nfk;
        Sun, 09 Jul 2006 15:33:52 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id n23sm11740285nfc.2006.07.09.15.33.51;
        Sun, 09 Jul 2006 15:33:51 -0700 (PDT)
To: pasky@suse.cz
In-Reply-To: <20060709221326.GU29115@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23575>

Petr Baudis <pasky@suse.cz> wrote:

> I've been meaning to do something like this for some time already; my
> itch have been the builtins. The tree size _is_ getting out of hand and
> a little more categorization of the sources would certainly help.
> Although I'd take a different approach:
> 
> 	libgit/
> 	builtin/
> 	standalone/
> 	scripts/

Please don't.  One directory is much easier to work with.  At least
don't split the Makefile.  Also moving files makes "git log <file>"
stop at the rename.

-- 
http://onion.dynserv.net/~timo/
