From: Lars Stoltenow <penma@derf.homelinux.org>
Subject: Re: [PATCH] git-daemon: Worked around uclibc buffer problem
Date: Fri, 10 Oct 2008 15:33:29 +0200
Message-ID: <20081010133329.GA26129@derf.homelinux.org>
References: <20081009213448.GA11204@derf.homelinux.org> <alpine.LFD.2.00.0810092010370.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 16:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoIXi-00010P-2M
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 16:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbYJJN7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 09:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756827AbYJJN7W
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 09:59:22 -0400
Received: from p508BE248.dip.t-dialin.net ([80.139.226.72]:57795 "EHLO
	aneurysm.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756585AbYJJN7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 09:59:21 -0400
X-Greylist: delayed 1549 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Oct 2008 09:59:21 EDT
Received: from penma by aneurysm.local with local (Exim 4.69)
	(envelope-from <penma@derf.homelinux.org>)
	id 1KoI7V-0006pS-39
	for git@vger.kernel.org; Fri, 10 Oct 2008 15:33:29 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810092010370.26244@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97933>

On Thu, Oct 09, 2008 at 08:16:03PM -0400, Nicolas Pitre wrote:
> What is your client version?  From v1.6.0.2 and later (with commit 
> 6b9c42b4da) this shouldn't matter as things are properly handled on the 
> receiving end.

Yah, looks good. I did test it with 1.6.0.1 and some 1.5.* versions on
the client side only. With 1.6.0.2, it works with the unfixed daemon too.
