From: Tobi <listaccount@e-tobi.net>
Subject: git-svn commit count vs- revision count
Date: Mon, 27 Jul 2009 10:45:10 +0200
Message-ID: <4A6D6916.2040509@e-tobi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 10:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVLqw-0004Sl-Pv
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 10:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbZG0Ipd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 04:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755167AbZG0IpT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 04:45:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54622 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbZG0IpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 04:45:14 -0400
Received: from [192.168.30.21] (pD9513A58.dip0.t-ipconnect.de [217.81.58.88])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MKv5w-1MVLpY02ju-000k9t; Mon, 27 Jul 2009 10:45:14 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
X-Provags-ID: V01U2FsdGVkX1/ugpwj98LnI0xZN/5S3KZMLHTT6FsA2PYnm6F
 v97QvurklkflE5EAs8PJbokioJpU4lVwJk1pp+LhVNRMhO+4ys
 1e7ExQVHsotCGfFvtFsDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124157>

Hi!

I've `git-svn clone`ed a pretty large repository, which took about 3 days
even with with local access to the SVN repository. To check that
everything went ok, I listed the root commits with `git fsck --root
--full` and verfied, that these are indeed root commits with no branch point.

So far so good... what's puzzling me is, that `git rev-list --all | wc -l`
says I have 40731 commits, but the SVN repository only has 21875 revisons.

Shouldn't these numbers be the same? The only explanation I have, is, that
git-svn imported one or more branches or tags, where it failed to find the
correct branch point in the history. Is there a way to figure out, if
there went something wrong and possibly fix it?

Thx,

Tobias
