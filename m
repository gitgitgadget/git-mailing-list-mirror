From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git_config_set() for mean cases
Date: Wed, 16 Nov 2005 12:21:55 -0800
Message-ID: <7vhdac738c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511161045310.16596@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 21:24:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTn6-00044t-6l
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVKPUV5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 15:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbVKPUV5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:21:57 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61074 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030365AbVKPUV4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 15:21:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116202102.MORB17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 15:21:02 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511161045310.16596@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 16 Nov 2005 10:47:37 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12051>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> There were problems when the keys=B4 case didn=B4t match, and also wh=
en the
> section was in the same line as the key.
>
> This patch also adds a test case, so you see that it works now.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Why do you spell apostrophe with 0xb4 not ASCII 0x27?  Not that
it matters because I'll apply it with -u flag to git-am to
convert it to UTF-8 in the log message, but I am just curious.
