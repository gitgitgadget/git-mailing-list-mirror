From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-shell.
Date: Sun, 23 Oct 2005 17:52:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510231751040.10477@g5.osdl.org>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net>
 <435B5AE0.1060400@op5.se> <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510231427230.10477@g5.osdl.org> <7vhdb7vk64.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 02:54:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETqaA-0002NH-EP
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 02:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVJXAwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 20:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVJXAwz
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 20:52:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750860AbVJXAwy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 20:52:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9O0qoFC029530
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 23 Oct 2005 17:52:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9O0qn8v004375;
	Sun, 23 Oct 2005 17:52:49 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdb7vk64.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10515>



On Sun, 23 Oct 2005, Junio C Hamano wrote:
>
> This adds a very git specific restricted shell, that can be
> added to /etc/shells and set to the pw_shell in the /etc/passwd
> file, to give users ability to push into repositories over ssh
> without giving them full interactive shell acount.

Did you actually test that it works as somebody's login-shell and can be 
used for pushing?

I think it should add "pull" functionality too, so that you can have 
restricted reading (hey, git may be open source, but not everything that 
is maintained in it necessarily will be..)

			Linus
