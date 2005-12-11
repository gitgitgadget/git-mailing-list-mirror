From: Petr Baudis <pasky@suse.cz>
Subject: Re: Latest cogito broken with bash-3.1
Date: Sun, 11 Dec 2005 01:11:06 +0100
Message-ID: <20051211001106.GV22159@pasky.or.cz>
References: <1134220724.15125.4.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 01:12:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElEo7-0004q3-Hw
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 01:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbVLKALK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 19:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbVLKALK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 19:11:10 -0500
Received: from w241.dkm.cz ([62.24.88.241]:61113 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161072AbVLKALJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 19:11:09 -0500
Received: (qmail 8865 invoked by uid 2001); 11 Dec 2005 01:11:06 +0100
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1134220724.15125.4.camel@blade>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13477>

  Hello,

Dear diary, on Sat, Dec 10, 2005 at 02:18:44PM CET, I got a letter
where Marcel Holtmann <marcel@holtmann.org> said that...
> The cogito is the latest from kernel.org and when calling cg-commit it
> fails with this message:
> 
> cg-commit: line 200: syntax error near unexpected token `('
> cg-commit: line 200: `       eval commitfiles=($(cat $filter | path_xargs git-diff-index -r -m HEAD -- | \'
> 
> I played a little bit with it and it seems all the eval statements are
> broken with this bash version. I have no clue how to fix this, but maybe
> you do.

  it seems like the newer bash is stricter than the older versions in
some obscure regards. Quoting the eval arguments (which is the proper
thing to do anyway) fixed that particular problem; I've hit another
problem during a test commit wrt. whitespace separators - I've fixed
that too, and pushed out.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
