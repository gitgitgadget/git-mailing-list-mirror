From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Fri, 18 Aug 2006 23:05:05 +0300
Message-ID: <20060818230505.994b08b6.tihirvon@gmail.com>
References: <44E54AC6.9010600@gmail.com>
	<20060818195148.66411.qmail@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: aneesh.kumar@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 22:05:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEAaj-00018b-2P
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 22:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWHRUFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 16:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWHRUFH
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 16:05:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:54505 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932313AbWHRUFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 16:05:06 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1374974nfa
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 13:05:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Uf1aReP9YJbSxPeCJY5NfcU5BL7aNP0Y+swfi/W7Rix2aL/tfHGqn45i4+SaB88SLY6btl1Tkmeas+yBcvrwMUJnrWfqxN/iS6sZNN1NMFHRZVq8wbwjIZA5FqFdEOXdK7LgA1NEUsQtQXB8jHlYh0NQFkeg2EMn/hI6cwdfi4M=
Received: by 10.49.55.13 with SMTP id h13mr4482546nfk;
        Fri, 18 Aug 2006 13:05:04 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.21])
        by mx.gmail.com with ESMTP id v20sm116254nfc.2006.08.18.13.05.02;
        Fri, 18 Aug 2006 13:05:02 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060818195148.66411.qmail@web31807.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.1; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25692>

Luben Tuikov <ltuikov@yahoo.com> wrote:

> --- "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> wrote:
> > This adds snapshort support in gitweb. To enable one need to
> > set gitweb.snapshot = true in the config file.
> 
> Could you use bzip2?  It generates smaller files (better compression),
> which is a good thing when downloading over a network.

bzip2 is much slower than gzip.  Often just uncompressing .tar.bz2 takes
more time than downloading bigger .tar.gz file.  For small projects it
doesn't matter which one you use.

-- 
http://onion.dynserv.net/~timo/
