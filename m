From: Keith Duthie <keith@no.net.nz>
Subject: Re: pull/merge --no-commit
Date: Fri, 8 Jun 2007 07:12:14 +1200 (NZST)
Message-ID: <alpine.DEB.0.99.0706080658070.6319@sleipnir.no.net.nz>
References: <46678909.10608@alcatel-lucent.com> <7vfy54qqu8.fsf@assigned-by-dhcp.cox.net>
 <46684EFD.1080804@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 21:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwNZM-0006Iu-I6
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 21:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbXFGTWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 15:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbXFGTWi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 15:22:38 -0400
Received: from webmail.woosh.co.nz ([202.74.207.2]:2878 "EHLO
	mail2.woosh.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964853AbXFGTWh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 15:22:37 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2007 15:22:36 EDT
Received: from sleipnir.no.net.nz (203-211-120-198.ue.woosh.co.nz [203.211.120.198]) by woosh.co.nz
 (Rockliffe SMTPRA 6.1.22) with ESMTP id <B0080284512@mail2.woosh.co.nz>;
 Fri, 8 Jun 2007 07:12:32 +1200
In-Reply-To: <46684EFD.1080804@alcatel-lucent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49381>

On Thu, 7 Jun 2007, kurt_p_lloyd wrote:

> Except here's the model that I am trying to follow....
> It seems that 'pull' can be partitioned into 3 separate responsibilities:
>
>   1. Retrieve changes from the remote user's replica (without modifying
>      any /local/ branches).
>   2. Bring changes from "remote" into a local branch (without commit).
>   3. Commit.

I believe you can accomplish step one with a remote tracking branch
("git-remote add localname git://whereever/project.git" to add the branch
to the repository, then "git-remote update localname" to update it to the
current remote state).

-- 
The universe hates you, but don't worry - it's nothing personal.
