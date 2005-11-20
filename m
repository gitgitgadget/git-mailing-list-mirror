From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: HTTP basic authentication support
Date: Sun, 20 Nov 2005 10:38:02 +0200
Message-ID: <87u0e71zpx.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Nov 20 09:39:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdkiY-0005xs-9U
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 09:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVKTIiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 03:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVKTIiO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 03:38:14 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:17827 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751163AbVKTIiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 03:38:13 -0500
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep02-app.kolumbus.fi
          with ESMTP
          id <20051120083803.BZPD1115.fep02-app.kolumbus.fi@litku.valo.iki.fi>
          for <git@vger.kernel.org>; Sun, 20 Nov 2005 10:38:03 +0200
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12374>

I keep some personal files in a git repository. Now I want to have the
repository in an HTTP server so that I can access it everywhere I go.
Since I don't want to share the repository with the whole world, I
would like to use the HTTP basic authentication, just to give a little
protection. But it seems that git doesn't support it, yet. Or did I miss
something?

I made a test repository which requires basic authentication. Login is
foo and password bar.

git clone doesn't work:

$ git clone http://foo:bar@www.valo.iki.fi/kalle/tmp/auth.git/ auth  
defaulting to local storage area
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?
$ 

But curl works:

$ curl http://foo:bar@www.valo.iki.fi/kalle/tmp/auth.git/info/refs
4cb663bd2b92d57c5e1ba0bfa9bf65c2e50ff46a        refs/heads/master
$ 

I'm using git updated an hour ago.

-- 
Kalle Valo
