From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Building git on Fedora
Date: Mon, 18 Apr 2005 09:39:17 +1000
Message-ID: <1113781158.11910.15.camel@localhost.localdomain>
References: <4262F07D.4050007@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:36:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJIo-0006Q8-U4
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVDQXjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVDQXjh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:39:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55752 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261560AbVDQXjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:39:33 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNJMQ-0003L7-WB; Mon, 18 Apr 2005 00:39:32 +0100
To: jeff millar <wa1hco@adelphia.net>
In-Reply-To: <4262F07D.4050007@adelphia.net>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-04-17 at 19:25 -0400, jeff millar wrote:
>     ln -sf /lib/modules/`uname -r`/build/include/linux /usr/local/include/linux
> 
> This fix creates a symlink, on each boot up, in the local include 
> directory that points to the kernel header files. If there's a better 
> way to do this, I'm all ears.

What's wrong with the contents of the glibc-kernheaders package? Can you
file specific bugs if you're having problems?

In the long run, the answer is to convince Linus that we _really_ need
the kernel to have a set of header files defining the ABI which are fit
for public consumption, rather than having a horrid mix of private and
exportable bits throughout the contents of the include/ directory. 

In the meantime, some poor mug has to clean the crap up and try to make
something suitable to live in /usr/include/linux -- and unfortunately at
the moment for Fedora that someone is me :)

Unless git is doing something with kernel-private headers that it
shouldn't, this probably wants to be discussed elsewhere -- most likely
in Bugzilla.

-- 
dwmw2

