From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: that was supposed to be a [PATCH:COGITO] ...
Date: Tue, 20 Sep 2005 18:51:52 +0200
Message-ID: <20050920165152.GO14206@kiste.smurf.noris.de>
References: <112722842995-git-send-email-smurf@smurf.noris.de> <20050920160754.GL14206@kiste.smurf.noris.de> <20050920162233.GB8251@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 18:54:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHlMd-00025h-Ka
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 18:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbVITQw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 12:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbVITQw7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 12:52:59 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:62646 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932670AbVITQw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 12:52:58 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EHlLV-0003dA-7l; Tue, 20 Sep 2005 18:52:05 +0200
Received: (nullmailer pid 28742 invoked by uid 501);
	Tue, 20 Sep 2005 16:51:52 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050920162233.GB8251@pasky.or.cz>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9007>

Updated .gitignore to exclude generated debian/ files.

Building a Debian package generates a few files, which we should ignore.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
--- 
Hi,

Petr Baudis:
> > OK, that was the result of using this file:
> 
> I think the list didn't get it...? I didn't get any mails, at least.

So much the better. ;-)

> Also, it never hurts to Cc' me on Cogito patches. ;-)
> 
Here it is again.

---

 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

2adfcd0b29ad6d9d0c29911d61e557aeac0bd6a9
diff --git a/.gitignore b/.gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,5 @@
 cg-version
 build-stamp
 configure-stamp
+debian/files
+debian/cogito/*

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Conserve energy -- make love more slowly.
