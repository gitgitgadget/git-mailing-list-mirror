From: Junio C Hamano <junkio@cox.net>
Subject: Re: What should I use instead of git show?
Date: Mon, 13 Mar 2006 15:55:27 -0800
Message-ID: <7vmzftq4r4.fsf@assigned-by-dhcp.cox.net>
References: <20060313144747.GA81092@dspnet.fr.eu.org>
	<200603131717.53416.astralstorm@o2.pl>
	<Pine.LNX.4.64.0603130830050.3618@g5.osdl.org>
	<4415FFB8.3000001@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 00:55:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIwt3-000310-MX
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 00:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWCMXza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 18:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWCMXza
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 18:55:30 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33266 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750927AbWCMXza (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 18:55:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313235124.GCEO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 18:51:24 -0500
To: Mark Hollomon <markhollomon@comcast.net>
In-Reply-To: <4415FFB8.3000001@comcast.net> (Mark Hollomon's message of "Mon,
	13 Mar 2006 18:26:48 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17578>

Mark Hollomon <markhollomon@comcast.net> writes:

> I must be misunderstanding this:
>
> 	git whatchanged -p -1 HEAD
>
> in the current git tree results in nothing. only when I get to -5 does it show something.
>
> Is this expected?
>
>> git version
> git version 1.2.4.gea75

In this case what matterks is not the version of your git but
what that HEAD is.  If it is a merge commit, whatchanged -p does
not show anything by default.
