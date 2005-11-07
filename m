From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Notes on http-push
Date: Mon, 7 Nov 2005 11:07:49 -0800
Message-ID: <20051107190749.GB4070@reactrix.com>
References: <Pine.LNX.4.63.0511071926240.14149@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 20:08:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZCLi-0003K7-6z
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 20:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbVKGTH6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 14:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbVKGTH5
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 14:07:57 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:54488 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965285AbVKGTHx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 14:07:53 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA7J7nBl008154;
	Mon, 7 Nov 2005 11:07:49 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA7J7nFx008152;
	Mon, 7 Nov 2005 11:07:49 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511071926240.14149@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11277>

On Mon, Nov 07, 2005 at 07:34:34PM +0100, Johannes Schindelin wrote:

> - if you init your test by git-clone'ing from a http repo, be sure to
> 	add a slash to the URL, else git-push will tell you erroneously
> 	that the server does not do DAV locking. (Probably http-push.c 
> 	should be fixed to add the slash when needed.)

In the -fetch counterparts, the trailing slash is added by git-fetch.sh,
does this belong in the get_remote_url() function in
git-parse-remote.sh?  I've only pushed with DAV, so I'm not sure whether
that would break anything else.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
