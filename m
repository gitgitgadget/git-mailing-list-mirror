From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-status and empty directories
Date: Sun, 26 Mar 2006 23:37:33 +0200
Message-ID: <20060326213733.GT18185@pasky.or.cz>
References: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 23:37:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNcvM-0003RU-GT
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 23:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWCZVhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 16:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWCZVhV
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 16:37:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:13527 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932137AbWCZVhV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 16:37:21 -0500
Received: (qmail 9402 invoked by uid 2001); 26 Mar 2006 23:37:33 +0200
To: Jim MacBaine <jmacbaine@gmail.com>
Content-Disposition: inline
In-Reply-To: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18060>

  Hi,

Dear diary, on Mon, Feb 27, 2006 at 03:43:32PM CET, I got a letter
where Jim MacBaine <jmacbaine@gmail.com> said that...
> Many packages put empty directories under /etc, and although only a
> few of those directories are actually needed, the automatic removal of
> those packages will fail if I remove the empty directories manually.  
> Equally, the removal will fail, if I put a .placeholder file into
> those direrectories and cg-add it.  Is there a simple way out?

  BTW, with Cogito-0.17.1 the simple way out should be cg-status -S
which restores the original behaviour.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
