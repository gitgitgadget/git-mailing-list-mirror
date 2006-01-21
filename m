From: Petr Baudis <pasky@suse.cz>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 20:48:26 +0100
Message-ID: <20060121194826.GK28365@pasky.or.cz>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:47:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0OhV-0006zJ-Vu
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWAUTq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWAUTq5
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:46:57 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47815 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932306AbWAUTq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 14:46:57 -0500
Received: (qmail 30139 invoked by uid 2001); 21 Jan 2006 20:48:26 +0100
To: dave morgan <morgad@eclipse.co.uk>
Content-Disposition: inline
In-Reply-To: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15009>

Dear diary, on Sat, Jan 21, 2006 at 03:08:27PM CET, I got a letter
where dave morgan <morgad@eclipse.co.uk> said that...
>                 sed -e
> 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \
> 
> s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
> \
>                        $file > $file.new; \
>                 cat $file.new > $file; rm $file.new; \
>         done
> sed: -e expression #1, char 145: unterminated address regex

(145 is the total expression length.) Now, I'm at loss - this works here
and I can see nothing wrong on the regexp - does anyone have any idea?

What is your sed version?

> net result - a pile of zero length files in /home/david/bin/   :-(
> 
> can I just copy the cg-files from to cogito directory over?

No, you would have to also set $COGITO_LIB and $COGITO_SHARE (or put
cg-X* scripts to your bin directory as well).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
