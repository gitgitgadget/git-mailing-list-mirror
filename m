From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: recur status on linux-2.6
Date: Sat, 19 Aug 2006 12:46:30 +0200
Message-ID: <20060819104630.GA5213@c165.ib.student.liu.se>
References: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 12:46:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEOLg-0006XQ-T8
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 12:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWHSKqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 06:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWHSKqd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 06:46:33 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:62401 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750759AbWHSKqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 06:46:32 -0400
Received: from c165 ([213.114.27.99] [213.114.27.99])
          by mxfep01.bredband.com with ESMTP
          id <20060819104630.HNRJ5813.mxfep01.bredband.com@c165>;
          Sat, 19 Aug 2006 12:46:30 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GEOLW-0001T3-00; Sat, 19 Aug 2006 12:46:30 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25711>

On Sun, Aug 13, 2006 at 03:54:19PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> I tested git-merge-recur vs. git-merge-recursive on the linux-2.6 
> repository last night. It contains 2298 two-head merges. _All_ of them 
> come out identically with -recur as compared to -recursive (looking at 
> the resulting index only).

After the latest updates to git-merge-recur it passes all the tests I
have too.
 
> That was the good news. The bad news is: it _seems_, that -recur is only 
> about 6x faster than -recursive, not 10x, and this number becomes smaller, 
> the longer the merge takes. So I see a startup effect here, probably.	

That is a quite nice improvement anyway :)

- Fredrik
