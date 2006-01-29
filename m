From: Junio C Hamano <junkio@cox.net>
Subject: Re: No merge strategy handled the merge (git version 1.1.GIT)
Date: Sun, 29 Jan 2006 15:50:19 -0800
Message-ID: <7vhd7mh9vo.fsf@assigned-by-dhcp.cox.net>
References: <43DB4D16.6050807@drugphish.ch>
	<20060129120344.GB4815@c165.ib.student.liu.se>
	<43DD52ED.7090503@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 00:50:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3MJP-0008L3-4g
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 00:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWA2XuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 18:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWA2XuW
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 18:50:22 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9470 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932089AbWA2XuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 18:50:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129234901.PHL6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 18:49:01 -0500
To: Roberto Nibali <ratz@drugphish.ch>
In-Reply-To: <43DD52ED.7090503@drugphish.ch> (Roberto Nibali's message of
	"Mon, 30 Jan 2006 00:42:37 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15251>

Roberto Nibali <ratz@drugphish.ch> writes:

> ... "not reading code before commenting" omitted ...
> On top of that "-D" did/does
> not seem to be documented...

Well, initially, not documenting it was done somewhat
deliberately, because -D is an operation that would lose
information.  Running the command with -d option would reveal
its existence after telling the user why we do not let it be
deleted by default.
