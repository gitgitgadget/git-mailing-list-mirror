From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 00/29] Teach guilt import-commit how to create legal
 patch names, and more
Date: Tue, 13 May 2014 16:54:44 -0400
Message-ID: <20140513205443.GB4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <20140513204546.GB11391@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Per Cederqvist <cederp@opera.com>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 13 22:54:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJik-0002IC-3P
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbaEMUyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:54:39 -0400
Received: from josefsipek.net ([64.9.206.49]:1538 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbaEMUyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:54:37 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id D441555654;
	Tue, 13 May 2014 16:54:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140513204546.GB11391@thunk.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248849>

On Tue, May 13, 2014 at 04:45:47PM -0400, Theodore Ts'o wrote:
> On Tue, May 13, 2014 at 10:30:36PM +0200, Per Cederqvist wrote:
...
> >  - Changed behavior: by default, guilt no longer changes branch when
> >    you push a patch.  You need to do "git config guilt.reusebranch
> >    false" to re-enable that.  This patch sets the default value of
> >    guilt.reusebranch to true; it should in my opinion change to false
> >    a year or two after the next release.
> 
> We've been living with the "origin" -> "guilt/origin" branch change
> for a year already, and in fact, these days I've gotten used to the
> new behavior.  Is it really worth it to change the default?

So, at first I was skeptical about the branch name prefix change.  I've used
it for about a year now, and I love it.  When I first read Per's idea to
change the default to the old-style, I was a bit sad but I understand the
motivation.

I'm open to either mode being the default since it's easy enough for me to
change it for me (thanks, ~/.gitconfig) but I think more people should
benefit from the added safety against accidental git-push.  (I also like
being able to use guilt/master..master to get only the commits I care
about.)  Thoughts?

Jeff.

-- 
Intellectuals solve problems; geniuses prevent them
		- Albert Einstein
