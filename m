From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Gitk strangeness..
Date: Mon, 27 Mar 2006 18:52:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603271848190.15714@g5.osdl.org>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603271802030.15714@g5.osdl.org> <17448.40941.256361.866229@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 28 04:53:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO4KY-0006Xn-6P
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 04:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWC1CxG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 21:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWC1CxG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 21:53:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751193AbWC1CxF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 21:53:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2S2r0DZ023471
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Mar 2006 18:53:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2S2qxWA011612;
	Mon, 27 Mar 2006 18:52:59 -0800
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17448.40941.256361.866229@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18104>



On Tue, 28 Mar 2006, Paul Mackerras wrote:
> 
> I think the best thing to do is to change git-rev-list.  One
> possibility would be to add an option to make git-rev-list omit
> parents that are not in the requested set, which would mean that gitk
> would not draw the open-circle commits any more.

I love the open circles. I often want to know what the previous commit 
was. For example, I use gitk mainly for "gitk ORIG_HEAD..", and then I see 
the thing that the newly merged stuff was based on (ie was it a major 
release, or some random point).

> The other option would be to make git-rev-list list the open-circle
> commits explicitly, with an indication that they are not in the
> requested set but are parents of commits in the requested set.

Hmm. That shouldn't be hard to do, but what would be syntax be?

		Linus
