From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] ls-files: Don't require exclude files to end with a newline.
Date: Sun, 19 Mar 2006 22:29:11 +0100
Message-ID: <20060319212911.GD18185@pasky.or.cz>
References: <8764mccaji.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 19 22:29:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL5SP-0001bS-Jb
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 22:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWCSV27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 16:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWCSV27
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 16:28:59 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60124 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750920AbWCSV26 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 16:28:58 -0500
Received: (qmail 4896 invoked by uid 2001); 19 Mar 2006 22:29:11 +0100
To: Alexandre Julliard <julliard@winehq.org>
Content-Disposition: inline
In-Reply-To: <8764mccaji.fsf@wine.dyndns.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17722>

Dear diary, on Sat, Mar 18, 2006 at 11:27:45AM CET, I got a letter
where Alexandre Julliard <julliard@winehq.org> said that...
> Without this patch, the last line of an exclude file is silently
> ignored if it doesn't end with a newline.
> 
> Signed-off-by: Alexandre Julliard <julliard@winehq.org>

$ echo -en "a\nb" | wc -l
1

In UNIX, a line is a string terminated by a newline, therefore the blob
past the last newline character is not really a line at all. ;-)

Perhaps a warning might be in order. Why don't you just add the trailing
newline to the file?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
