From: Tzafrir Cohen <tzafrir.cohen@xorcom.com>
Subject: git-svn: Cannot lock the ref 'refs/remotes/tags/autotag_for_.'.
Date: Tue, 9 Feb 2010 23:39:29 +0200
Organization: Xorcom*
Message-ID: <20100209213929.GL3599@xorcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 22:49:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NexxN-0003UZ-Dp
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 22:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab0BIVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 16:49:11 -0500
Received: from local.xorcom.com ([62.90.10.53]:51931 "EHLO local.xorcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab0BIVtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 16:49:09 -0500
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2010 16:48:59 EST
Received: by local.xorcom.com (Postfix, from userid 1000)
	id 4418B7C1DCF; Tue,  9 Feb 2010 23:39:29 +0200 (IST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Forced-Service: Sadly Using Gmail [tm]
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139445>

Hi

I'm using git-svn for watching over SVN repositories in
svn.asterisk.org . The largest one there is
http://svn.asterisk.org/svn/asterisk .

This worked fine up until recently. I was using Debian Stable with Git
1.5.6 .

Recently I upgraded my system to Debian Testing with Git 1.6 (I
currently have 1.6.6.1-1). Today I tried to update the repository (git
svn rebase --fetch-all) and got the following error:

  fatal: Cannot lock the ref 'refs/remotes/tags/autotag_for_.'.

IIRC it followed an automatic garbage-collection in the repository.

I decided to re-clone the SVN repository (I was planning on doing that
for quite some time, with a proper AUTHORS file this time. But it's a
repo of some 200,000 revisions and takes a few days to clone)

I eventually got the same error.

The specific revision that triggered it:

  http://svnview.digium.com/svn/asterisk?view=revision&revision=47394

Should git-svn mangle SVN tag names to be legal git ref names? Or just
panic before it makes the git repo invalid?

Is there a way for me to skip some tags? I can avoid that specific tag.

Please CC your replies to me as I don't actively follow this list.

-- 
               Tzafrir Cohen
icq#16849755              jabber:tzafrir.cohen@xorcom.com
+972-50-7952406           mailto:tzafrir.cohen@xorcom.com
http://www.xorcom.com  iax:guest@local.xorcom.com/tzafrir
