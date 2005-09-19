From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 09:32:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509190924280.9106@g5.osdl.org>
References: <20050919134838.GC2903@pasky.or.cz> <7vll1trqiq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:34:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOZe-00025J-1j
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVISQcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVISQcz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:32:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932440AbVISQcz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 12:32:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JGWhBo019447
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 09:32:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JGWcCY001062;
	Mon, 19 Sep 2005 09:32:41 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll1trqiq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8884>



On Mon, 19 Sep 2005, Junio C Hamano wrote:
> 
> What do popular MUAs do to come up with the real-name fields?
> Don't they face the same problem, trying to using GECOS?

Since I have my pine installed in git, I could git grep it. It says

    /* full name is all chars up to first ',' (or whole gcos, if no ',') */
    /* replace any & with logname in upper case */

I don't know why the & rule, but there you have it..

The Perl User::pwent module seems to agree, btw (also about '&'):

   "Interpretation of the gecos field varies between systems, but
    traditionally holds 4 comma-separated fields containing the user's
    full name, office location, work phone number, and home phone number.  

    An & in the gecos field should be replaced by the user's properly
    capitalized login name."

I still worry about names of the type "Torvalds, Linus", but maybe that's 
just not an issue.

		Linus
