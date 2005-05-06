From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: tool to diff cache <-> working directory
Date: Fri, 6 May 2005 04:07:59 +0200
Message-ID: <20050506020759.GA11506@cip.informatik.uni-erlangen.de>
References: <20050506002347.GU20994@cip.informatik.uni-erlangen.de> <7vhdhhf88u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 04:01:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTs9k-0004yf-RE
	for gcvg-git@gmane.org; Fri, 06 May 2005 04:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVEFCIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 22:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVEFCIF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 22:08:05 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43997 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262179AbVEFCIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 22:08:00 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4627xS8016807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 02:07:59 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4627xeM016806
	for git@vger.kernel.org; Fri, 6 May 2005 04:07:59 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhdhhf88u.fsf@assigned-by-dhcp.cox.net>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

>     git-diff-tree tree1 tree2           two trees
>     git-diff-cache --cached tree1	  cache and tree
>     git-diff-cache tree1		  tree and working directory
>     git-diff-files                      cache and working directory

that makes it clear. Thanks.

> So git-diff-files is not just similar to but exactly is what you
> want if I read your question correctly.

Yes, it is. :-)

> Yes there is a way, git-write-blob, but why would you want to do
> that?

I thought there would be no cache<->working directory delta generation.
And I need a way to see if there are unchecked-in deltas in the working
tree. So I thought about looking at the 'git-diff-cache --cached tree1'
and comparing it with the self generated SHAs of the working tree. But
now, that there is such a tool, I am perfectly fine.

Thanks,
	Thomas
