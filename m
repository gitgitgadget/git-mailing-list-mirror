From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra
 requirements
Date: Wed, 2 Nov 2011 22:09:41 +0000
Message-ID: <20111102220941.GA3925@dcvr.yhbt.net>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
 <20111102182015.GA11401@elie.hsd1.il.comcast.net>
 <1320260449-sup-479@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Wed Nov 02 23:09:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLj0F-0006l8-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 23:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab1KBWJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 18:09:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51649 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968Ab1KBWJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 18:09:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18D8217C2;
	Wed,  2 Nov 2011 22:09:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1320260449-sup-479@pinkfloyd.chass.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184675>

Ben Walton <bwalton@artsci.utoronto.ca> wrote:
> Sorry for the clumsy patch.

I don't have much time to help you fix it, but I got numerous errors on
SVN 1.6.x (svn 1.6.12).  Can you make sure things continue to work on
1.6 and earlier, also?

Maybe just enable the escaping for file:// on >= SVN 1.7

Here are the tests that failed for me:

make[1]: *** [t9100-git-svn-basic.sh] Error 1
make[1]: *** [t9103-git-svn-tracked-directory-removed.sh] Error 1
make[1]: *** [t9104-git-svn-follow-parent.sh] Error 1
make[1]: *** [t9105-git-svn-commit-diff.sh] Error 1
make[1]: *** [t9107-git-svn-migrate.sh] Error 1
make[1]: *** [t9108-git-svn-glob.sh] Error 1
make[1]: *** [t9109-git-svn-multi-glob.sh] Error 1
make[1]: *** [t9110-git-svn-use-svm-props.sh] Error 1
make[1]: *** [t9111-git-svn-use-svnsync-props.sh] Error 1
make[1]: *** [t9114-git-svn-dcommit-merge.sh] Error 1
make[1]: *** [t9116-git-svn-log.sh] Error 1
make[1]: *** [t9117-git-svn-init-clone.sh] Error 1
make[1]: *** [t9118-git-svn-funky-branch-names.sh] Error 1
make[1]: *** [t9120-git-svn-clone-with-percent-escapes.sh] Error 1
make[1]: *** [t9125-git-svn-multi-glob-branch-names.sh] Error 1
make[1]: *** [t9127-git-svn-partial-rebuild.sh] Error 1
make[1]: *** [t9128-git-svn-cmd-branch.sh] Error 1
make[1]: *** [t9130-git-svn-authors-file.sh] Error 1
make[1]: *** [t9135-git-svn-moved-branch-empty-file.sh] Error 1
make[1]: *** [t9136-git-svn-recreated-branch-empty-file.sh] Error 1
make[1]: *** [t9141-git-svn-multiple-branches.sh] Error 1
make[1]: *** [t9145-git-svn-master-branch.sh] Error 1
make[1]: *** [t9146-git-svn-empty-dirs.sh] Error 1
make[1]: *** [t9150-svk-mergetickets.sh] Error 1
make[1]: *** [t9151-svn-mergeinfo.sh] Error 1
make[1]: *** [t9153-git-svn-rewrite-uuid.sh] Error 1
make[1]: *** [t9154-git-svn-fancy-glob.sh] Error 1
make[1]: *** [t9155-git-svn-fetch-deleted-tag.sh] Error 1
make[1]: *** [t9156-git-svn-fetch-deleted-tag-2.sh] Error 1
make[1]: *** [t9157-git-svn-fetch-merge.sh] Error 1
make[1]: *** [t9159-git-svn-no-parent-mergeinfo.sh] Error 1
make[1]: *** [t9161-git-svn-mergeinfo-push.sh] Error 1
