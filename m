From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Sun, 14 Dec 2008 18:33:50 +0100
Message-ID: <20081214173152.GA6557@joi>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: David Howells <dhowells@redhat.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754789AbYLNRel@vger.kernel.org Sun Dec 14 18:36:02 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754789AbYLNRel@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBusr-0003ZG-Pg
	for glk-linux-kernel-3@gmane.org; Sun, 14 Dec 2008 18:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbYLNRel (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 14 Dec 2008 12:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbYLNRea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2008 12:34:30 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:52922 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbYLNRea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2008 12:34:30 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1242286muf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Dec 2008 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gcKoK715ITtdxXMOpJTDJgLv994npYhaDCC3jP3W1Rw=;
        b=KZL7P47kZPpilIUDjv8M5vtkRErdnbUwTlOXG+h2aFGbAi5LkGECF7TwT7QWgIIr77
         1lIdN3GVOQBkZ5hUVuK0C75CecAM+fChJW5j2o0qmBtdr/OWhzQYkPW9jyARQ0gSfRnk
         CDxAxRSYIpju+yGwHHHsBaz5kkmwFN/Fx9o+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FykKYDRfJkgxLgIB83HcIEShYmWQTRR8reeKSkgdl9MRqR+xkoD6vlRJzF/19xVPvk
         YaPqpI0w9c617JW2F3TMYnD8YPMyRPDXW/W2AX0J9BTdC2NrxSoDdX1NqIJQN2lrzRXT
         J8ZYYorUSHuhYtJji0GjkR//2IL94eUy39thY=
Received: by 10.103.214.8 with SMTP id r8mr2642988muq.6.1229276067309;
        Sun, 14 Dec 2008 09:34:27 -0800 (PST)
Received: from @ (public-gprs50551.centertel.pl [91.94.70.5])
        by mx.google.com with ESMTPS id e10sm7837120muf.18.2008.12.14.09.34.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 09:34:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103095>

On Fri, Dec 12, 2008 at 06:28:27PM +0000, David Howells wrote:
> +REVERTING COMMITTED CHANGES
> +---------------------------
> +
> +And sometimes you'll want to revert changes that you've committed, but that are
> +now buried beneath other commits.  Short of discarding and reapplying commits,
> +you have to apply a reverse patch:
> +
> +	git diff %COMMIT_ID | patch -p1 -R
> +
> +and then commit it.  Both the original application and the reversion will be
> +retained by GIT.

"git revert $commit" is a bit shorter.

Marcin
