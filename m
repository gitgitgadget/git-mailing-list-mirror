From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 12:06:36 +0200
Organization: Harddisk-recovery.com
Message-ID: <20060814100636.GA26859@harddisk-recovery.com>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> <20060814035603.GB18667@spearce.org> <9e4733910608132107j7bca0271g360de3447febbf51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 12:06:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZLG-0008WP-91
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWHNKGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWHNKGj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:06:39 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:1963 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932119AbWHNKGi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 06:06:38 -0400
Received: (qmail 25832 invoked from network); 14 Aug 2006 12:06:36 +0200
Received: from unknown (HELO zurix.bitwizard.nl) (192.168.234.26)
  by abra2.bitwizard.nl with SMTP; 14 Aug 2006 12:06:36 +0200
Received: from erik by zurix.bitwizard.nl with local (Exim 3.36 #1 (Debian))
	id 1GCZLA-00073r-00; Mon, 14 Aug 2006 12:06:36 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608132107j7bca0271g360de3447febbf51@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25335>

On Mon, Aug 14, 2006 at 12:07:45AM -0400, Jon Smirl wrote:
> Since we are encoding C many strings will always be present (if,
> static, define, const, char, include, int, void, while, continue,
> etc).  Do you have any tools to identify the top 500 strings in C
> code? The fixed dictionary would get hardcoded into the git apps.

We are not only encoding C anymore. Git might have started as a tool to
maintain the linux kernel tree, but its use got beyond that.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
