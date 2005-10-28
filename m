From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Fri, 28 Oct 2005 03:56:42 +0200
Message-ID: <20051028015642.GA31822@vrfy.org>
References: <20051027203945.GC1622@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 03:58:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVJUW-0006Dk-1P
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 03:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVJ1B4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 21:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVJ1B4t
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 21:56:49 -0400
Received: from soundwarez.org ([217.160.171.123]:60382 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S965051AbVJ1B4s (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 21:56:48 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 2D59A6746A; Fri, 28 Oct 2005 03:56:42 +0200 (CEST)
To: Chris Shoemaker <c.shoemaker@cox.net>
Content-Disposition: inline
In-Reply-To: <20051027203945.GC1622@pe.Belkin>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10737>

On Thu, Oct 27, 2005 at 04:39:45PM -0400, Chris Shoemaker wrote:
> 
> I really like gitweb (thanks Kay!), but I thought it would be nice to
> have a visual indication of patch size.  I found this helpful when
> scanning though the shortlogs.

This looks nice, but if the patch size tells you something important,
your commit subjects are probably too short or wrong. :)

> To see what it looks like with the gitweb for gitweb (meta-gitweb?)
> goto:
> 
> http://www.codesifter.com/cgi-bin/gitweb.cgi?p=gitweb.git;a=shortlog
> 
> I rather like the look of what I've hacked up (the enclosed patch),
> but it should be considered as just a prototype: it only affects the
> shortlog, it's horribly inefficient, and I don't really do perl.  :)
> 
> If anyone thinks this is a good feature, then please tell me an
> efficient way to get some heuristic of the patch size.

You may try to use CSS instead of an embedded picture to draw the bar,
just like the RSS logo in the footer, which is simple CSS rendered in the
browser.

Kay
