From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: What's in git.git
Date: Sun, 05 Mar 2006 11:47:52 +0100
Message-ID: <87bqwljhgn.fsf@wine.dyndns.org>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
	<46a038f90603050121u6bccbb71ve78de69ae45b96ad@mail.gmail.com>
	<87irqtjjr1.fsf@wine.dyndns.org>
	<46a038f90603050215v7afcbd4crc145e85a4da416a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 12:16:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFrDe-0006Fw-ST
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 12:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWCELQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 06:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWCELQG
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 06:16:06 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:27812 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751476AbWCELQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 06:16:04 -0500
Received: from adsl-62-167-46-204.adslplus.ch ([62.167.46.204] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FFqmI-00084z-VD; Sun, 05 Mar 2006 04:48:02 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 9291B4F90E; Sun,  5 Mar 2006 11:47:52 +0100 (CET)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90603050215v7afcbd4crc145e85a4da416a7@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 5 Mar 2006 23:15:31 +1300")
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17222>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> So I should use a combination of both? Hmmm. Worth exploring, can you
> give us a quick guide on getting started with it? (Or where should I
> read? I'm not that good with emacs)...

To get started with the VC backend, make sure vc-git.el is somewhere
on your emacs load-path, and add GIT to the vc-handled-backends
variable; the easiest is with customize, something like
`M-x customize-variable [RET] vc-handled-backends'.

Once you have done that, when you open a file that's under git
control, the vc-git mode should automatically be turned on, and you
should see a "GIT" indicator in the modeline. Then you can use the
standard VC backend commands (the ones that start with the C-x v
prefix). The Emacs VC mode is documented at:

  http://www.gnu.org/software/emacs/manual/html_node/Version-Control.html

For the git-status mode, simply do a `M-x load-file [RET] git.el', and
then `M-x git-status'. This will prompt you for the directory to view,
and display a list of modified files. From there you can mark files
and perform actions on group of files, like diff, commit, revert, etc.
There isn't a lot of documentation at this point, but a `C-h m' will
show you the list of key bindings, so you can try them all and see
what happens ;-)

> Oh. Ah. Ok! I'll have to try this! So far, I've had good luck
> following this guide:
>
>     http://wiki.gnuarch.org/Process_20_2a_2erej_20files
>
> which is targetted pretty much at dumb emacs users. Like me ;-)

smerge mode is a very simple mode to edit files that contain conflict
markers, in my experience it works pretty well. The nice thing is that
it works directly from the file buffer, so you don't need to jump back
and forth between file and diff.

-- 
Alexandre Julliard
julliard@winehq.org
