From: David Brown <git@davidb.org>
Subject: Re: Referring a commit-id remote repo.
Date: Mon, 1 Oct 2007 08:24:12 -0700
Message-ID: <20071001152412.GA1036@old.davidb.org>
References: <20071001041635.GA22102@old.davidb.org> <Pine.LNX.4.64.0710011122500.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 17:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcN8A-0003r2-QS
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 17:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbXJAPYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 11:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbXJAPYO
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 11:24:14 -0400
Received: from mail.davidb.org ([66.93.32.219]:40323 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbXJAPYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 11:24:13 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IcN80-00013f-Hy; Mon, 01 Oct 2007 08:24:12 -0700
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710011122500.28395@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59620>

On Mon, Oct 01, 2007 at 11:25:13AM +0100, Johannes Schindelin wrote:
>On Sun, 30 Sep 2007, David Brown wrote:
>
>> The question I have: is there any way I can look at this particular 
>> commit ID on the remote repo?  I couldn't come up with any way to get 
>> git fetch to retrieve it.
>
>Unless you have push access, no.  And this is very much by design.  For 
>example, when somebody mistakenly pushed a secret (like what lines in the 
>kernel infringe on M$ patents, if any) it should be possible to rebase (in 
>a hurry), force a push, and have the safe feeling that nobody can fetch 
>the secret any longer.

I've found the commits in the 'master' branch, and it looks like the
developer had done a rebase on Sept 3.  I've informed the person asking me
the question to use these commit IDs, and hopefully they won't be doing any
rebasing on their master branch.

Dave
