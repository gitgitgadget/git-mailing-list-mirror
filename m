From: Nicolas Kuttler <wp@nkuttler.de>
Subject: git svn fetch -> fatal: refs/remotes/trunk: not a valid SHA1
Date: Sun, 12 Dec 2010 17:19:28 +0100
Message-ID: <20101212161928.GE30395@nicolaskuttler.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 12 17:44:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRp27-00031y-MU
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 17:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab0LLQoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 11:44:18 -0500
Received: from www.nicolaskuttler.de ([83.169.19.64]:39452 "EHLO
	www.nicolaskuttler.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0LLQoR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 11:44:17 -0500
X-Greylist: delayed 1487 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2010 11:44:17 EST
Received: from nicolas by www.nicolaskuttler.de with local (Exim 4.69)
	(envelope-from <nicolas@nicolaskuttler.de>)
	id 1PRoe0-0008JZ-AS
	for git@vger.kernel.org; Sun, 12 Dec 2010 17:19:28 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163484>

Hello,

I'm using git version 1.7.2.3 and get the
"fatal: refs/remotes/trunk: not a valid SHA1" error while fetching from
an svn repository.

$ mkdir test
$ cd test
$ git svn init -s http://svn.wp-plugins.org/zero-conf-mail
$ git svn fetch -r246566

r246566 = 92e8abc50bf56cc1774e0e2688a280bc379a4817
(refs/remotes/tags/0.6.1)
fatal: refs/remotes/trunk: not a valid SHA1
update-ref refs/heads/master refs/remotes/trunk: command returned error: 128

The problem seems to be that r246566 was created by a "git svn tag foo"
command, fetching r246565 is works just fine. I didn't test if native
svn tagging produces the same error but can do this if relevant. It
could also be specific to the wordpress svn repository, I haven't tested
that either.

Thanks,

Nicolas

P.S. Please CC me as I'm not on the list.

--
Nicolas Kuttler
wp@nkuttler.de

http://www.nkuttler.de
http://www.nicolaskuttler.de (deutsch)
