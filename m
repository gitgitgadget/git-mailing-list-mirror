From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Has the git shell revert been done so master should work?
Date: Mon, 25 Aug 2008 13:30:23 -0600
Message-ID: <alpine.LNX.1.10.0808251325540.19079@suse104.zenez.com>
References: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXhux-000470-98
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 21:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbYHYTi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 15:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbYHYTi2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 15:38:28 -0400
Received: from suse104.zenez.com ([198.60.105.164]:19391 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbYHYTi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 15:38:27 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Aug 2008 15:38:27 EDT
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 35130A7C87E; Mon, 25 Aug 2008 13:30:24 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 19048A7C87D
	for <git@vger.kernel.org>; Mon, 25 Aug 2008 13:30:23 -0600 (MDT)
In-Reply-To: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93660>

I was doing it correctly, but this is what I am seeing.

$ git clone git://git.kernel.org/pub/scm/git/git.git git
$ cd git
$ git checkout master
Already on "master"
$ git cherry-pick 4cfc24af
fatal: exec merge-recursive failed.
Automatic cherry-pick failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>' and 
commit the result.
When commiting, use the option '-c 4cfc24a' to retain authorship and 
message.

So I was attempting to do it right, but it just did not work.

BTW, is there a way to get all the messages sent since last night.  Some 
how I lost my subscription to the git email list.  I re-subscribe at 
around 1:30 MDT.  I really would like to get all the email I mised.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
