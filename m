From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Tue, 9 May 2006 21:21:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605092117240.3718@g5.osdl.org>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 06:21:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdgCu-0005KJ-Ok
	for gcvg-git@gmane.org; Wed, 10 May 2006 06:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWEJEVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 00:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWEJEVR
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 00:21:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964804AbWEJEVQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 00:21:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4A4L8tH008354
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 21:21:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4A4L7QM001680;
	Tue, 9 May 2006 21:21:07 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19870>



On Tue, 9 May 2006, Junio C Hamano wrote:
> 
> Junio C Hamano:
>       binary patch.
>       binary diff: further updates.

Btw, am I just smoking stuff, or is this going to be fundamentally 
problematic for "git-apply -R" if we ever want to support that?

I think the new binary diff is non-reversible. That's ok right now, since 
we don't actually support patching in reverse (if you want to get the 
reverse patch, you need to _diff_ it in reverse and then patch it that 
way).

But at least in theory we might well want to do "-R" eventually.

Hmm? Or did I just mis-understand the format?

		Linus
