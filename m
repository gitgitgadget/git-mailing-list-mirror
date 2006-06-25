From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/7] Git.pm: Introduce ident() and ident_person() methods
Date: Sun, 25 Jun 2006 03:57:51 +0200
Message-ID: <20060625015751.GB21864@pasky.or.cz>
References: <20060625015421.29906.50002.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 03:58:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJsp-00088v-Nu
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWFYB5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWFYB5x
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:57:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16315 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964892AbWFYB5w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:57:52 -0400
Received: (qmail 30205 invoked by uid 2001); 25 Jun 2006 03:57:51 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060625015421.29906.50002.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22577>

> diff --git a/git-send-email.perl b/git-send-email.perl
> index e794e44..79e82f5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl

BTW, please tell me if you want to redo the patches without any script
updates (and how large portion of the patches to resend; my stg stack
now has 28 patches and I'm finally using it for some real workload!)
- given that the plan is to have the converted scripts only in pu
(or entirely outside your tree) but full-fledged Git.pm in tree.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
