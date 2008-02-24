From: John Goerzen <jgoerzen@complete.org>
Subject: git-push with --all --tags
Date: Sun, 24 Feb 2008 16:12:36 -0600
Message-ID: <slrnfs3quk.aqm.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 23:13:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTP6D-0001p4-L4
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbYBXWM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 17:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbYBXWM5
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:12:57 -0500
Received: from main.gmane.org ([80.91.229.2]:42836 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbYBXWM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:12:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JTP5a-0007SJ-AY
	for git@vger.kernel.org; Sun, 24 Feb 2008 22:12:54 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 22:12:54 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 22:12:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74966>

Hi,

I am using git 1.5.4.2, and noticed that this command:

git push --all --tags

exits with a syntax display.  However, that display -- and the
git-push manpage -- don't tell me why this is invalid.  Moreover, git
push with one of --all or --tags works.  It seems it would be more
efficient when pushing to a remote, when I want to to both, to be able
to specify --all --tags.

Also, is there a way I can specify that certain args are the default
to push for a given repo?  I looked in git-config(1) but didn't find
anything.  I may want --all or --mirror as a default on some repos.

Thanks,

-- John
