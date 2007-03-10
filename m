From: Junio C Hamano <junkio@cox.net>
Subject: Re: git's is_inside_git_dir too strict?
Date: Fri, 09 Mar 2007 17:11:41 -0800
Message-ID: <7vzm6l2982.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com>
	<Pine.LNX.4.63.0703062232570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<fcaeb9bf0703070417n5d3fb168jc7efd4642ad38c92@mail.gmail.com>
	<20070309120001.GA32300@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 02:11:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPq7n-0007Ew-2O
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 02:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767707AbXCJBLn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 20:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767708AbXCJBLn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 20:11:43 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43018 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767707AbXCJBLm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 20:11:42 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310011142.SCSM321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 20:11:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YpBh1W0041kojtg0000000; Fri, 09 Mar 2007 20:11:41 -0500
In-Reply-To: <20070309120001.GA32300@moooo.ath.cx> (Matthias Lederhofer's
	message of "Fri, 9 Mar 2007 13:00:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41830>

Matthias Lederhofer <matled@gmx.net> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> By the way, is it plausible to add --git-workdir option to specify
>> working directory? With that option, I won't need to chdir to the
>> working directory, run git commands and chdir back.
>
> http://article.gmane.org/gmane.comp.version-control.git/38382
> Since I did not need this feature that much and no one replied that
> there is any interest I did not look any further into it.

FWIW, I was once in favor of that, and currently I am neutral.
I vaguely recall that I suggested something like that back when
I was still a contributor.  The proposal was shot down by people
on the list, but I do not recall the details of why.
