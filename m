From: Petr Baudis <pasky@suse.cz>
Subject: Re: qiuestion about Git and Cogito
Date: Thu, 22 Mar 2007 18:57:22 +0100
Message-ID: <20070322175722.GP18276@pasky.or.cz>
References: <45FFFA94.4040105@mail.nih.gov> <20070320155623.GH4489@pasky.or.cz> <46002BEE.5020300@mail.nih.gov> <46028B45.2010802@mail.nih.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francois Lang <flang@mail.nih.gov>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HURXc-0004pP-Ek
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 18:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934163AbXCVR5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934158AbXCVR5d
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 13:57:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51653 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934163AbXCVR5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 13:57:33 -0400
Received: (qmail 19897 invoked by uid 2001); 22 Mar 2007 18:57:22 +0100
Content-Disposition: inline
In-Reply-To: <46028B45.2010802@mail.nih.gov>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42874>

On Thu, Mar 22, 2007 at 02:57:25PM CET, Francois Lang wrote:
> Interesting...for me, when I do what you suggested, i.e.,
> 
> cg-log -r master..origin
> 
> it does not tell me what has been locally committed but not yet pushed.
> 
> To get that behavior, I need to do
> 
> cg-log -r origin..master.
> 
> Does that make sense to you, or am I confused? I do work on master and 
> push to origin.

Oh, of course - I got it swapped in my head. :-)

It isn't the most intuitive syntax, admittedly, but I couldn't think of
anything better. The way to think about it is "show me the commits
that appeared between origin and master", where

	a - b - c - d - e
	 origin ^
	         master ^

thus it will show the locally committed but not yet pushed d and e. This
maps nicely to the range syntax if you think about it, but it isn't
terribly intuitive. :-(

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
