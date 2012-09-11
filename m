From: Brice Goglin <brice.goglin@gmail.com>
Subject: git-svn mergeinfo
Date: Tue, 11 Sep 2012 14:01:01 +0200
Message-ID: <504F27FD.6020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 14:01:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBP9k-0000Ua-Hw
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 14:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150Ab2IKMBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 08:01:21 -0400
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:52329
	"EHLO mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932143Ab2IKMBU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 08:01:20 -0400
X-IronPort-AV: E=Sophos;i="4.80,404,1344204000"; 
   d="scan'208";a="155329079"
Received: from unknown (HELO [193.50.110.66]) ([193.50.110.66])
  by mail4-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-CAMELLIA256-SHA; 11 Sep 2012 14:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205224>

Hello,

I am using git 1.7.10.4 from Debian. I just tried svn.pushmergeinfo and
it seems to have worked fine, great.

Now I am trying to understand what the doc says about this:
"Currently, this can only be done when dcommitting non-fast-forward
merges where all parents but the first have already been pushed into SVN."

"all parents but the first have already been pushed into SVN" means that
merging A into B requires to dcommit in A first, right?
"non-fast-forward" means that both branches got some commits since the
last merge, right?

Could we add an example after the above doc sentence? Something like
"For instance, if merging SVN branch B into A, make sure you dcommit A
first, and check that both A and B got new commits since the last merge
(or since B was created from A)".

Brice
