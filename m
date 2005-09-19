From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange dependency problem installing GIT 0.99.7
Date: Sun, 18 Sep 2005 21:46:46 -0700
Message-ID: <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net>
References: <432E1F28.9060909@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 06:47:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHDYm-0008Si-1v
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 06:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVISErP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 00:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVISErP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 00:47:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49582 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932224AbVISErO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 00:47:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919044648.GOLQ23945.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 00:46:48 -0400
To: Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <432E1F28.9060909@bigpond.net.au> (Peter Williams's message of
	"Mon, 19 Sep 2005 12:15:04 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8834>

Peter Williams <pwil3058@bigpond.net.au> writes:

> So I installed String::ShellQuote from CPAN and tried again with the 
> same result.  So I then rebuilt the rpm on my system and still got the 
> same error message.  So I've installed the rpm using the --nodeps option 
> but would like to test whether it is successfully finding 
> String::ShellQuote.  Which command(s) would exercise this perl package?

$ git grep ShellQuote
git-archimport.perl:42:use String::ShellQuote;

Sorry for the gotcha.  Any RPM experts to offer advice?
