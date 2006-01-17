From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-files and fakeroot
Date: Mon, 16 Jan 2006 18:36:39 -0800
Message-ID: <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net>
References: <43CC5231.3090005@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 03:37:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EygiZ-0001E4-Nh
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 03:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWAQCgm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 21:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAQCgl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 21:36:41 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1017 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751316AbWAQCgl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 21:36:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117023446.LIK17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 21:34:46 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <43CC5231.3090005@michonline.com> (Ryan Anderson's message of
	"Mon, 16 Jan 2006 21:10:57 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14772>

Ryan Anderson <ryan@michonline.com> writes:

> I've been trying to track down a strange issue with building kernels
> (and scripts/setlocalversion) and finally realized the problem was the
> when run under fakeroot, git-diff-files thinks everything is changed
> (deleted, I believe)

BTW, Ryan, I suspect this is where you try to append "-dirty" to
the version number.  But I wonder why you are doing the build
under fakeroot to begin with?  Wasn't the SOP "build as
yourself, install as root"?
