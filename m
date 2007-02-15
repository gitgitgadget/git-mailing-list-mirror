From: tab@snarc.org (Vincent Hanquez)
Subject: Re: Configuring gitk appearance
Date: Thu, 15 Feb 2007 17:26:46 +0100
Message-ID: <20070215162646.GA25337@snarc.org>
References: <45D48951.2000207@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 18:02:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHk08-0001pN-9f
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 18:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbXBORBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 12:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbXBORBJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 12:01:09 -0500
Received: from hades.snarc.org ([212.85.152.11]:1609 "EHLO hades.snarc.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030237AbXBORBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 12:01:07 -0500
X-Greylist: delayed 1830 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Feb 2007 12:01:07 EST
Received: by hades.snarc.org (Postfix, from userid 1000)
	id 040461B481; Thu, 15 Feb 2007 17:26:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <45D48951.2000207@webdrake.net>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39837>

On Thu, Feb 15, 2007 at 04:24:49PM +0000, Joseph Wakeling wrote:
> Is there any way to configure the appearance of gitk either during or
> after installation?  At present on my system (Ubuntu 6.10) the font used
> is almost illegible.  I'm guessing it is partly due to gitk using GTK+
> v1 instead of v2.

gitk is not using GTK v1 but TCL/TK.

see your ~/.gitk and just change those option (9 to 13 or 15 will do):

set mainfont {Helvetica 9}
set textfont {Courier 9}
set uifont {Helvetica 9 bold}

-- 
Vincent Hanquez
