From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 19:33:25 +0300
Message-ID: <20060526193325.d2a530a4.tihirvon@gmail.com>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 18:34:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjfGd-0007JU-5T
	for gcvg-git@gmane.org; Fri, 26 May 2006 18:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWEZQdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 12:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWEZQcW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 12:32:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:5412 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751087AbWEZQcC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 12:32:02 -0400
Received: by nf-out-0910.google.com with SMTP id n29so89932nfc
        for <git@vger.kernel.org>; Fri, 26 May 2006 09:32:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=lhQLRgmqumNFVow/++eG1CCwB/7MBPB4m9q1X6HVORDLhoJWoQDKOWqhZcA7CP8Z486X5vltaONMWGiznVwD5yprQZmScedAUtt6BmvxIaCKMzi3b0gZT7czBpc5Zl+qRjtg4BX8kv09awYbxDtu5NS63ZsqYO9bZUpd0mnrnYc=
Received: by 10.48.207.17 with SMTP id e17mr5703nfg;
        Fri, 26 May 2006 09:31:28 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id n22sm672288nfc.2006.05.26.09.31.27;
        Fri, 26 May 2006 09:31:27 -0700 (PDT)
To: Anand Kumria <wildfire@progsoc.uts.edu.au>
In-Reply-To: <20060526152837.GQ23852@progsoc.uts.edu.au>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20817>

Anand Kumria <wildfire@progsoc.uts.edu.au> wrote:

> Hi,
> 
> git is unable to construct a reasonable default email address in my
> current environment.  So, I use GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL
> to override things.
> 
> This has worked well but, now, I need to vary the email address for some
> repositories.  Unfortunately the environment variables override
> .git/config.
> 
> It would be good if things were like:
> 	- try to construct one automagically
> 	- use ~/.git/config (if available)
> 	- use .git/config
> 	- use environment variables
> 
> That way I could set my default email address in ~/.git/config and
> override it as required for those repositories that need it.

I backup my $HOME using git, so there's a .git directory in ~.  I don't
think a global config file is really needed but it would be nice if
.git/config would override the environment variables, not the other way
around.

-- 
http://onion.dynserv.net/~timo/
