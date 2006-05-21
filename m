From: normalperson@hand.yhbt.net (Eric Wong)
Subject: Re: [PATCH] Make '@' not valid in a ref name.
Date: Sat, 20 May 2006 19:00:38 -0700
Message-ID: <20060521020038.GA22926@hand.yhbt.net>
References: <20060521013751.GA7516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 21 04:00:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhdFK-0000rS-BK
	for gcvg-git@gmane.org; Sun, 21 May 2006 04:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWEUCAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 22:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWEUCAj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 22:00:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40407 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751417AbWEUCAj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 22:00:39 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 71CDD2DC034; Sat, 20 May 2006 19:00:38 -0700 (PDT)
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060521013751.GA7516@spearce.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20425>

Shawn Pearce <spearce@spearce.org> wrote:
> Now that the sha1 expression syntax supports looking up a ref's
> value at a prior point in time through the '@' operator the '@'
> operator should not be permitted in a ref name.

This would break git-archimport (where email addresses are the first
part of the branch/tag names).

-- 
Eric Wong
