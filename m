From: "Tom Sgouros" <tomfool@as220.org>
Subject: mysterious error message
Date: Thu, 25 Sep 2008 17:33:38 -0400
Message-ID: <20593.1222378418@as220.org>
Reply-To: "Tom Sgouros" <tomfool@as220.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 23:43:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiyce-0002ay-Ip
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 23:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbYIYVmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 17:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbYIYVmb
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 17:42:31 -0400
Received: from as220.org ([198.7.230.15]:46932 "EHLO ironzilla.as220.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175AbYIYVma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 17:42:30 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Sep 2008 17:42:30 EDT
Received: from localhost (localhost [127.0.0.1])
	by ironzilla.as220.org (Postfix) with ESMTP id 7DE4CAAB17
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 17:33:42 -0400 (EDT)
X-Virus-Scanned: amavisd-new at as220.org
Received: from ironzilla.as220.org ([127.0.0.1])
	by localhost (as220.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tlMDozHdWbc0 for <git@vger.kernel.org>;
	Thu, 25 Sep 2008 17:33:38 -0400 (EDT)
Received: from as220.org (localhost [127.0.0.1])
	by ironzilla.as220.org (Postfix) with ESMTP id 7FC7CAAB13
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 17:33:38 -0400 (EDT)
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96806>


Hello all:

I receive the following error message when I try to do a 'git push':

  tomfool@toms-box:hpl$ git push
  updating 'refs/heads/master'
    from ad4ae7925d3dd23798e7c5b733d2d8f930f7410f
    to   5b5f5fae014a4f3535fa10b0f6e28b4bf3225dc3
   Also local refs/remotes/origin/master
  Generating pack...
  Done counting 10 objects.
  Deltifying 10 objects...
  error: pack-objects died with strange error
  unpack eof before pack header was fully read
  ng refs/heads/master n/a (unpacker error)
  error: failed to push to 'ssh://tomfool@as220.org/home/tomfool/hpl.git'
  tomfool@toms-box:hpl$

I haven't been able to interpret this message, and haven't found it in
the documentation, and google has let me down, too.  Can anyone tell me
what is causing it?

I'm a new git user, and this is a new git archive.  I've successfully
done a couple of git push operations before, though.  The connection I'm
making is via ssh.  I'm working on a Mac OS X (10.4.9) machine over here
and the server to which I'm trying to push is a Linux box
(2.6.22-gentoo-r6).

Many thanks,

 -tom

-- 
 ------------------------
 tomfool at as220 dot org
 http://sgouros.com  
 http://whatcheer.net
