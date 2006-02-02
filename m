From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The merge from hell...
Date: Thu, 2 Feb 2006 00:08:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
 <Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Len Brown <len.brown@intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:09:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4ZXA-0004M0-Mj
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 09:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423371AbWBBIJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 03:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423372AbWBBIJi
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 03:09:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423371AbWBBIJh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 03:09:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k12886DZ024636
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Feb 2006 00:08:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k12885Bf009231;
	Thu, 2 Feb 2006 00:08:06 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15495>



On Wed, 1 Feb 2006, Linus Torvalds wrote:
> 
> I _think_ your version of the rule ("pluses and minuses in all the same 
> columns") ends up being exactly the same as my rule ("only two different 
> versions").

Actually, I take that back.

My version of the rule was not just that there were only two versions: the 
merge _result_ had to match one of the versions in one of the branches 
too.

That's important. It's important because you _can_ actually have a merge 
where both branches have the exact same content, but some evil merger 
ended up editing just the merge result.

So there are literally just two versions, but one of the versions _only_ 
exists in the merge result. Such a thing must always be considered a 
conflict, since basically the merge result is obviously "interesting".

That requirement can still be rewritten as a slight variation of your 
version, I think: "the pluses and minuses are all in the same columns, and 
the final column has to match one other column"

Maybe I'm not thinking clearly. Somebody else should double-check my 
thinking. My brain is tired, and I'm going to bed.

			Linus
