From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-pack-refs --prune
Date: Thu, 21 Sep 2006 08:19:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609210815100.4388@g5.osdl.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
 <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org> <7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609180934360.4388@g5.osdl.org> <7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 17:23:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQQKb-0007mk-1g
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 17:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWIUPTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 11:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWIUPTO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 11:19:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751261AbWIUPTN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 11:19:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8LFJ5nW030437
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Sep 2006 08:19:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8LFJ4fW012015;
	Thu, 21 Sep 2006 08:19:05 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.992 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.151 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27478>



On Thu, 21 Sep 2006, Junio C Hamano wrote:
> 
> Ok, so I did these and the result is a 4-patch series.

Looks good to me. I would have combined 2/3, since the bulk of them is the 
calling conversion change, and they both add a new argument to the same 
function, so combining them would make just one patch that isn't even 
noticeably larger than either of the two originals, but that's just a 
small nitpick.

Having callback data is clearly good, and the "flags" may end up being 
useful for other things in the future too (ie if we add attributes to 
branches, we could at some point have "hidden" and "read-only" etc flags)

		Linus
