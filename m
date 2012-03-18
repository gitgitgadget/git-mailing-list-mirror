From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: use a tabbed dialog to edit preferences
Date: Mon, 19 Mar 2012 10:07:09 +1100
Message-ID: <20120318230709.GC26977@bloggs.ozlabs.ibm.com>
References: <87ty547arf.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9PUS-0007tU-35
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 00:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab2CRX0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 19:26:16 -0400
Received: from ozlabs.org ([203.10.76.45]:37743 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640Ab2CRX0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 19:26:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id CD604B709E; Mon, 19 Mar 2012 10:26:09 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <87ty547arf.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193396>

On Tue, Dec 13, 2011 at 02:56:49PM +0000, Pat Thoyts wrote:
> This commit converts the user preferences dialog into a tabbed property
> sheet grouping general properties, colours and font selections onto
> separate pages. The previous implementation was exceeding the screen
> height on some systems and this avoids such problems and permits extension
> using new pages in the future.
> 
> If themed Tk is unavailable or undesired a reasonable facsimile of the
> tabbed notebook widget is used instead.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Thanks, applied.

> I have done this patch against the git-core version of gitk as gitk's
> own repository on kernel.org has not re-appeared. Is this likely to get
> resurrected or should I perhaps make a github fork for any future work
> on gitk?

My gitk repository is now at git://ozlabs.org/~paulus/gitk.git.

Paul.
