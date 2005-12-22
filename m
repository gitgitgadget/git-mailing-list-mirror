From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] whatchanged: customize diff-tree output
Date: Wed, 21 Dec 2005 22:48:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512212245440.4827@g5.osdl.org>
References: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvexhr6rc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 07:48:56 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpKFq-0004qu-7L
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 07:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVLVGsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 01:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVLVGsm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 01:48:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965023AbVLVGsl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2005 01:48:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBM6mWDZ021177
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Dec 2005 22:48:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBM6mVHt027552;
	Wed, 21 Dec 2005 22:48:31 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvexhr6rc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13934>



On Wed, 21 Dec 2005, Junio C Hamano wrote:
> 
> How about doing something like this patch first, and then decide
> what the default should be?
> 
> I would recommend "--pretty -r --name-status -M" as the default.
> But I am not particularly interested in imposing my preference
> over that of Linus to the end users.

I'm certainly ok with the short format by default. And making it 
configurable per repo sounds fine, although at the same time I wonder if 
that perhaps confuses people more (something that works in one project one 
way works subtly differently in another project..)

		Linus
