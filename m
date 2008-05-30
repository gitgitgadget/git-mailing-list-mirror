From: Petr Baudis <pasky@suse.cz>
Subject: Re: perl/Git.pm: Writing a test suite
Date: Fri, 30 May 2008 12:03:06 +0200
Message-ID: <20080530100306.GF18781@machine.or.cz>
References: <483FB034.3050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 12:04:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K21Sr-0006Cc-GM
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 12:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbYE3KDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 06:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYE3KDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 06:03:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45379 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbYE3KDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 06:03:08 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2D3341E4C02B; Fri, 30 May 2008 12:03:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <483FB034.3050507@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83285>

  Hi,

On Fri, May 30, 2008 at 09:43:48AM +0200, Lea Wiemann wrote:
> Git.pm doesn't currently have a test suite, and I think it should get one.
>
> Since Git.pm makes calls to the git binary, it would seem sensible to me to 
> create mock output for the external calls, like Grit (a Ruby API) does it, 
> here: http://github.com/mojombo/grit/tree/master/test/fixtures  (Having a 
> complete test repository to test against like Ruby/Git (another API) at 
> http://repo.or.cz/w/rubygit.git?a=tree;f=tests/files;hb=HEAD is probably 
> too brittle and makes it hard to test edge cases.)

  I think this is bad idea; you should test not just Git.pm
functionality, but equally importantly also its integration with
(current version of) Git. If Git's output/behaviour changes in some
subtle way, you want to see if it breaks Git.pm.

> I haven't done testing in perl before, so if someone wants to exchange 
> ideas and/or help me get this set up, please post here or message me on IRC 
> (lea_w/lea_1 on #git at Freenode).

  There are two possible ways, either using the Git test suite
infrastructure, or the Perl test suite infrastructure. I'm ambivalent
about which one to choose, both have their advantages; I wonder what
others' opinion is. I would personally go with the Perl test suite in
this case but can't support it with much more than just a gut feeling.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
