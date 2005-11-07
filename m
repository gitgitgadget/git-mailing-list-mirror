From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Tags not transferred with git pull?
Date: Mon, 7 Nov 2005 11:44:08 +0100
Organization: Harddisk-recovery.com
Message-ID: <20051107104408.GA7283@harddisk-recovery.com>
References: <20051104155314.GB23790@harddisk-recovery.nl> <20051104155914.GA9567@ferdyx.org> <20051104160503.GC23790@harddisk-recovery.com> <7vll04tdsz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 11:44:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ4U3-0003oC-Bt
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 11:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVKGKoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 05:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVKGKoM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 05:44:12 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:12133 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751294AbVKGKoM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 05:44:12 -0500
Received: (qmail 11206 invoked by uid 501); 7 Nov 2005 11:44:08 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll04tdsz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11260>

On Fri, Nov 04, 2005 at 11:26:20AM -0800, Junio C Hamano wrote:
> Sorry for the confusion.  The barebone Porcelainish shipped with
> git-core does not fetch and store tags unconditionally under the
> same name as the remote has without being told; you need to
> explicitly tell it to 'git fetch --tags'.
> 
> What was added recently was a low level support for Cogito to
> implement the automatic tracking.  This is supposed to (I do not
> offhand know if the Cogito side has been updated to do so
> already) work a bit differently.  Instead of grabbing all tags
> and all objects reachable from them, as you fetch commits from
> the remote, the automatic tracking fetches tags that point at
> them.  What this means is that the tags on the remote branch you
> are tracking would be fetched automatically but tags on a remote
> branch you are not interested in are not.

Thanks for the explanation.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
