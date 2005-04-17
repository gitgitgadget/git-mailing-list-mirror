From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 21:59:35 +0200
Message-ID: <20050417195935.GI1461@pasky.ji.cz>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org> <Pine.LNX.4.21.0504171131230.30848-100000@iabervon.org> <20050417174736.GA1461@pasky.ji.cz> <20050417122517.4b12faea.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 22:51:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGjL-00021E-UJ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVDQUB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVDQUAF
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:00:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26262 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261459AbVDQT7k (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:59:40 -0400
Received: (qmail 12990 invoked by uid 2001); 17 Apr 2005 19:59:35 -0000
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050417122517.4b12faea.pj@sgi.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 09:25:17PM CEST, I got a letter
where Paul Jackson <pj@sgi.com> told me that...
> Petr wrote:
> > BTW, I'd just use access(F_OK) instead of stat() it I don't care about
> 
> I recommend _only_ using it when you require exactly the above real vs.
> effective id behaviour.

Does this distinction have any effect when doing F_OK?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
