From: Josef Wolf <jw@raven.inka.de>
Subject: How to push to http(s) repository with authentication?
Date: Mon, 20 Oct 2008 20:25:02 +0200
Message-ID: <20081020182502.GH9707@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 00:20:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrzXV-00063M-VB
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 20:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYJTSaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 14:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYJTSaX
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 14:30:23 -0400
Received: from quechua.inka.de ([193.197.184.2]:45168 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYJTSaX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 14:30:23 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1KrzWH-0007mR-Kf; Mon, 20 Oct 2008 20:30:21 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 00AAF3ABA4; Mon, 20 Oct 2008 20:25:02 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98724>

Hello,

I have set up a repository as described in

  http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt

over SSL with basic authentication.  DAV access works fine with konqueror,
cadaver and and curl, using this .curlrc:

   $ cat ~/.curlrc
   --cacert /etc/cacerts/myca.pem
   --user   user
   $ curl https://repo.host.org/git/test/HEAD
   Enter host password for user 'user':
   ref: refs/heads/master
   $

But when called from git, this file seems to be ignored.  I have checked
google, but the only hint I could find was to put credentials into
~/.netrc.  IMHO, this is a bad workaround, since this implies to have
unencrypted passwords lying around on the disk.

Any hints?

PS: I have asked a similar question a couple of days ago.  Here is a link
    to my original mail with more information how I set up the server:

      http://marc.info/?l=git&m=122426078301793&w=2
