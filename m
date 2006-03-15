From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Wed, 15 Mar 2006 14:51:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
References: <20060314211022.GA12498@localhost.localdomain>
 <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain>
 <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org> <7vek13ieap.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Qingning Huo <qhuo@mayhq.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 15 23:51:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJeqD-0000Pi-Nz
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 23:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWCOWvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 17:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWCOWvi
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 17:51:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932540AbWCOWvh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Mar 2006 17:51:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2FMpVDZ010411
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 15 Mar 2006 14:51:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2FMpURE006443;
	Wed, 15 Mar 2006 14:51:31 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek13ieap.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17621>



On Wed, 15 Mar 2006, Junio C Hamano wrote:
> 
> If we do the dash-form for consistency's sake, we should do
> PATH="`git --exec-path`:$PATH" in git-setup-sh when/before we do
> so.

Yes. That would make sense too. Then git-setup-sh would look more like 
what the builtin git.c does.

		Linus
