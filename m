From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] User Manual: add a chapter for submodules
Date: Wed, 19 Sep 2007 23:00:22 +0200
Message-ID: <20070919210022.GJ3619MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0709181405120.6203@juice.ott.cti.com>
 <20070919174250.GC16235@genesis.frugalware.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 23:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY6eu-00039J-27
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 23:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbXISVAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 17:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbXISVAZ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 17:00:25 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:47789 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbXISVAY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 17:00:24 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JOM00DMHVOMPT@psmtp08.wxs.nl> for git@vger.kernel.org; Wed,
 19 Sep 2007 23:00:23 +0200 (MEST)
Received: (qmail 23118 invoked by uid 500); Wed, 19 Sep 2007 21:00:22 +0000
In-reply-to: <20070919174250.GC16235@genesis.frugalware.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58735>

On Wed, Sep 19, 2007 at 07:42:50PM +0200, Miklos Vajna wrote:
> +Submodules maintain their own identity; the submodule support just stores the
> +submodule repository location and commit ID, so other developers who clone the
> +superproject can easily clone all the submodules at the same revision.

[..]

> +-------------------------------------------------
> +$ mkdir super
> +$ cd super
> +$ git init
> +$ echo hi > super.txt
> +$ git add super.txt
> +$ git commit -m "Initial commit of empty superproject"
> +$ for i in a b c d
> +do
> +	git submodule add ~/git/$i
> +done
> +-------------------------------------------------

You may want to warn the reader not to use local URLs here if they
plan to publish their superproject.

> +It's not safe to run `git submodule update` if you've made changes within a
> +submodule. They will be silently overwritten:

This is only true if they didn't follow your advise of checking out
a branch first.

skimo
