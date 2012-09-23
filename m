From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/2] gitk: Better highlighting of search results
Date: Sun, 23 Sep 2012 16:59:47 +1000
Message-ID: <20120923065947.GB15889@bloggs.ozlabs.ibm.com>
References: <1348299625-90207-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Sep 23 09:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFgBa-0008UX-E6
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 09:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617Ab2IWHAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 03:00:16 -0400
Received: from ozlabs.org ([203.10.76.45]:59892 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014Ab2IWHAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 03:00:14 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8A27F2C0093; Sun, 23 Sep 2012 17:00:11 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1348299625-90207-1-git-send-email-stefan@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206219>

On Sat, Sep 22, 2012 at 09:40:23AM +0200, Stefan Haller wrote:
> Here's something that has been bugging me for a long time: when using
> the incremental search feature, it's hard to tell what happens when
> clicking the Search button (or type Ctrl-S) repeatedly. It does have
> the concept of a "current" search hit, and Ctrl-S advances to the next
> one; however, you can't see it because all search hits are highlighted
> in the same way (yellow). So when there are multiple hits visible on
> the current page, it will at some point scroll down to reveal more
> hits, but it's impossible to predict when this will happen.
> 
> To improve this, we highlight the current search in orange and the
> other ones in yellow (like Chrome does it when you search on a Web
> page).

Nice, thanks - applied.

Paul.
