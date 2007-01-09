From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible bug in 'git status' exit code is 1 instead of 0
Date: Tue, 09 Jan 2007 10:12:26 -0800
Message-ID: <7vhcv0m5md.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550701090945u5a240fe9xf46cc40b030e1ba7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 19:12:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4LSZ-00013u-Qi
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 19:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbXAISM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 13:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXAISM2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 13:12:28 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64057 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbXAISM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 13:12:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109181227.YOHX20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 13:12:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 96Bc1W01B1kojtg0000000; Tue, 09 Jan 2007 13:11:37 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550701090945u5a240fe9xf46cc40b030e1ba7@mail.gmail.com>
	(Marco Costalba's message of "Tue, 9 Jan 2007 18:45:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36381>

"Marco Costalba" <mcostalba@gmail.com> writes:

> bash-3.1$ pwd
> /home/marco/programmi/git
> bash-3.1$ git status; echo $?
> # On branch refs/heads/origin
> nothing to commit (use "git add file1 file2" to include for commit)
> 1
> bash-3.1$ git --version
> git version 1.5.0.rc0.g244a7

I think that's normal and has been the way for git-commit to
detect if there is anything to commit.
