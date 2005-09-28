From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 08:21:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509280819000.3308@g5.osdl.org>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
 <Pine.LNX.4.58.0509251153090.3308@g5.osdl.org> <7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 17:25:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKdkn-0002XX-33
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 17:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVI1PVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 11:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVI1PVq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 11:21:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751073AbVI1PVp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 11:21:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8SFLf4s015334
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Sep 2005 08:21:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8SFLea5002728;
	Wed, 28 Sep 2005 08:21:40 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9432>



On Tue, 27 Sep 2005, Junio C Hamano wrote:
>
> This uses the git-update-ref command in scripts for safer updates.

Looks good.

git-resolve might want to verify the old head. On the other hand, it looks 
like it's being phased out, so maybe nobody cares?

		Linus
