From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Cleanup commit messages with git-stripspace
Date: Sun, 5 Jun 2005 00:10:12 +0200
Message-ID: <20050604221012.GB7084@pasky.ji.cz>
References: <20050604161531.GO12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 00:08:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DegnU-0006LU-Kf
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 00:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFDWKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 18:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVFDWKX
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 18:10:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16016 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261282AbVFDWKS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 18:10:18 -0400
Received: (qmail 25423 invoked by uid 2001); 4 Jun 2005 22:10:13 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050604161531.GO12615@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jun 04, 2005 at 06:15:31PM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Besides removing empty lines from the beginning and end (like the
> current sed command) git-stripspace will also turn multiple consecutive
> empty lines into just one empty line.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

I tried hard to prevent this exact behavior since I think this is Bad
Thing (tm), but after all, what the hell... The sed expression has some
portability problems associated.

Thanks, applied.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
