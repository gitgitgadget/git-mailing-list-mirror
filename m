From: Petr Baudis <pasky@suse.cz>
Subject: Re: New script: cg-clean
Date: Sun, 10 Jul 2005 17:46:18 +0200
Message-ID: <20050710154618.GF24249@pasky.ji.cz>
References: <1120862084.17812.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 10 17:46:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dre0n-0001k0-3a
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 17:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVGJPqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 11:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVGJPqW
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 11:46:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40163 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261961AbVGJPqU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 11:46:20 -0400
Received: (qmail 9593 invoked by uid 2001); 10 Jul 2005 15:46:18 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1120862084.17812.6.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 09, 2005 at 12:34:44AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello, Petr!

Hello,

> Please consider this script for Cogito.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>

the script is definitively interesting, but I have couple of notes
about it first:

(i) -i sounds wrong for anything but being interactive here ;-) What
about -A?

(ii) I'm confused - if -a is all of the above, how do I clean _only_
regular files, and only those not ignored by cg-status?

(iii) Makes it any sense to remove only special files?

(iv) -r implies being recursive, but it has nothing to do with that
here.

(v) Semantically, I think it's quite close to cg-reset. What about
making it part of cg-reset instead of a separate command? I tend to be
careful about command inflation. (That's part of being careful about the
usability in general.) That's just an idea and possibly a bad one, what
do you think?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
