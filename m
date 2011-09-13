From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: teach git-svn to populate svn:mergeinfo
Date: Tue, 13 Sep 2011 08:18:15 +0000
Message-ID: <20110913081815.GA19445@dcvr.yhbt.net>
References: <20110907133605.07ecad1b@robyn.woti.com>
 <20110909222159.GA6530@dcvr.yhbt.net>
 <20110912102422.21aa6570@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 10:18:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3OCG-0007kB-KR
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 10:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419Ab1IMISR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 04:18:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58496 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963Ab1IMISQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 04:18:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84DF1F432;
	Tue, 13 Sep 2011 08:18:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110912102422.21aa6570@robyn.woti.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181274>

Bryan Jacobs <bjacobs@woti.com> wrote:
> Thanks for the help and review. I'll let you do the cleanup and push
> the resulting patch when you feel it's ready (as you suggested), rather
> than iterating again for these small changes.

OK, it's pushed to "master" on git://bogomips.org/git-svn.git
as commit 1e5814f3def08452aef4caa703f074ba7d167867.

On a side note, if you have more changes you want to make (and have free
time :)  git-svn.perl would really benefit from being split into
separate .pm files for ease-of-maintenance.
