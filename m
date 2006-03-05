From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: What's in git.git
Date: Sun, 05 Mar 2006 10:58:26 +0100
Message-ID: <87irqtjjr1.fsf@wine.dyndns.org>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
	<46a038f90603050121u6bccbb71ve78de69ae45b96ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 10:59:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFq1i-00053L-Kh
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 10:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbWCEJ6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 04:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbWCEJ6j
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 04:58:39 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:11423 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1752161AbWCEJ6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 04:58:38 -0500
Received: from adsl-62-167-46-204.adslplus.ch ([62.167.46.204] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FFq0T-0007Mq-1K; Sun, 05 Mar 2006 03:58:35 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 6F3F64F90E; Sun,  5 Mar 2006 10:58:26 +0100 (CET)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90603050121u6bccbb71ve78de69ae45b96ad@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 5 Mar 2006 22:21:46 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 62.167.46.204
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL,SPF_HELO_SOFTFAIL autolearn=no 
	version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17215>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> I'm somewhat confused by the fact that there are two emacs modes, both
> by Alexandre. Which one should I use? Also -- the killer app for
> emacs+git would be to leverage the great patch-editing mode in emacs.

You can use both. The VC backend is a per-file mode, that's handy when
you are editing a file and want a quick diff/revert/commit of just
that file; the commands are executed directly from the buffer
containing the file. When making bigger changes, you should use the
git-status mode (the one in git.el), which is a tree browser that
gives you a view of the whole project.

> Can we get a new merge conflict mode that generates .rej files? Emacs
> is superb at dealing with conflicts formatted that way. OTOH, it may
> be able to deal smartly with diff3-style conflicts if it knows how to
> talk with the VC backend -- I think the cvs mode can do that.

What emacs mode do you use to resolve conflicts?  From the git-status
buffer, if you edit a file with 'f' it will automatically turn on
smerge mode if there are conflicts, or you can edit it in ediff merge
mode with 'd E' like under pcl-cvs. Is that what you mean?

-- 
Alexandre Julliard
julliard@winehq.org
