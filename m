From: Junio C Hamano <junkio@cox.net>
Subject: Re: attempting to clone the git repo
Date: Thu, 08 Mar 2007 10:40:38 -0800
Message-ID: <7v649ba89l.fsf@assigned-by-dhcp.cox.net>
References: <2fb03ecb0703080849m41ac8158y4895f2bc811934f5@mail.gmail.com>
	<Pine.LNX.4.63.0703081828500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Kilroy <lemonkandy@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 19:41:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPNYA-0005gu-0m
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 19:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015AbXCHSkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 13:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933010AbXCHSkk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 13:40:40 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51348 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933015AbXCHSkk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 13:40:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308184040.GEDO2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 13:40:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YJge1W00c1kojtg0000000; Thu, 08 Mar 2007 13:40:39 -0500
In-Reply-To: <Pine.LNX.4.63.0703081828500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 8 Mar 2007 18:29:11 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41768>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 8 Mar 2007, Andrew Kilroy wrote:
>
>> I'm attempting to clone the git repository using git-1.5.0.3 in my workplace.
>> Port 9418's blocked by the firewall, so I'm trying via http:
>> 
>>    $ git clone http://git.kernel.org/pub/scm/git/git.git
>
> Add a "/" to the end:
>
> $ git clone http://git.kernel.org/pub/scm/git/git.git/

I've always thought that for http transfer the hostname was not
git.kernel.org but www.kernel.org, as in:

	git clone http://www.kernel.org/pub/scm/git/git.git/
