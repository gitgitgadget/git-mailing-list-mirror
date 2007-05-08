From: Steven Grimm <koreth@midwinter.com>
Subject: Deprecate git-svnimport?
Date: Tue, 08 May 2007 00:16:36 -0700
Message-ID: <464023D4.5060101@midwinter.com>
References: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net>	 <463F6A95.30207@midwinter.com> <9fb1551c0705072048u3ff85ea7n5166596855b8f322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 09:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlJvm-0007S1-Ea
	for gcvg-git@gmane.org; Tue, 08 May 2007 09:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbXEHHQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 03:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755512AbXEHHQN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 03:16:13 -0400
Received: from tater.midwinter.com ([216.32.86.90]:55410 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755466AbXEHHQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 03:16:13 -0400
Received: (qmail 25977 invoked from network); 8 May 2007 07:16:12 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 8 May 2007 07:16:12 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <9fb1551c0705072048u3ff85ea7n5166596855b8f322@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46547>

On 5/7/07, Steven Grimm <koreth@midwinter.com> wrote:
> Try git-svn rather than git-svnimport. The latter, AFAIK, is no longer
> really maintained. ...

I said that because in the time I've been using git and reading this 
list, I think I've seen a grand total of one patch to git-svnimport, a 
ton of them to git-svn, and an occasional new user posting about 
git-svnimport failing to do something that git-svn would have done if 
they'd used it instead.

It looks like git-svnimport hasn't been updated to the 1.5.x remote 
branch naming convention (it still calls the svn head tracking branch 
"origin" if its manpage is to be believed).

Originally it looked like git-svn was what you used if you wanted to 
track just one svn branch bidirectionally, and git-svnimport was how you 
tracked multiple svn branches read-only. But now that git-svn has good 
handling of multi-branch svn repositories, I wonder if git-svnimport 
still serves a purpose. Should it perhaps be deprecated and removed in a 
future release? Or is it still useful for things that git-svn doesn't 
handle?

-Steve
