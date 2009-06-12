From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git cannot find "git pull"?
Date: Thu, 11 Jun 2009 19:44:28 -0700
Message-ID: <7v7hzidvcj.fsf@alter.siamese.dyndns.org>
References: <4A319CE1.6040201@garzik.org>
	<20090612011737.GB5076@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 04:45:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEwli-00014A-3K
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 04:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbZFLCoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 22:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbZFLCoh
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 22:44:37 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49114 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbZFLCoh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 22:44:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090612024439.RBLR17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jun 2009 22:44:39 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2qkU1c00E4aMwMQ03qkfXV; Thu, 11 Jun 2009 22:44:39 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=0MMDW3Mb48cA:10 a=F1brEb3fTY8A:10
 a=ybZZDoGAAAAA:8 a=Q3xF5HEJDsvBGoBtwOMA:9 a=9tUPXbXGww7tnBATU7HmQ-OuyScA:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <20090612011737.GB5076@inocybe.localdomain> (Todd Zullinger's message of "Thu\, 11 Jun 2009 21\:17\:38 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121382>

Todd Zullinger <tmz@pobox.com> writes:

> It is notable that Fedora 11 is the first Fedora release that follows
> the git 1.6.x defaults and installs most git binaries outside of PATH.
> I don't think that would cause this, and I haven't had any troubles
> running these packages for many months, but that's never stopped
> really obvious bugs in the past...

I do not follow distro packaged versions of git, but it may help to double
check your spec changes against the output of

    $ git log -p v1.5.6..v1.6.2.2 -- git.spec.in

to see which paths need to be updated.

Of course, you might not be using a specfile remotely similar to what we
have in-tree (I believe it was originally done by Chris Wright who is
listed as one of the persons who have something to do with Fedora packaged
versions of git in your maintainers list), so this may not be a helpful
tip at all, in which case I apologize...
