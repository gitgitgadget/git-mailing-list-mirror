From: Darrin Thompson <darrint@progeny.com>
Subject: Re: Merges without bases
Date: Thu, 25 Aug 2005 16:29:38 -0500
Message-ID: <1125005378.4110.25.camel@localhost.localdomain>
References: <1125004228.4110.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 25 23:31:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8PJd-0003ZO-UG
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 23:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVHYVbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVHYVbP
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 17:31:15 -0400
Received: from zealot.progeny.com ([216.37.46.162]:44677 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S964783AbVHYVbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 17:31:14 -0400
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP id 71592636A4
	for <git@vger.kernel.org>; Thu, 25 Aug 2005 16:31:14 -0500 (EST)
To: git@vger.kernel.org
In-Reply-To: <1125004228.4110.20.camel@localhost.localdomain>
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7767>

That didn't come out clearly. Restating:

On Thu, 2005-08-25 at 16:10 -0500, Darrin Thompson wrote:
> Could git-read-tree -m 3-args be made smart enough to treat a 0 as arg 1
> as an implicit empty tree?
> 

Could git-read-tree -m treat an argument of "0" as an implicit empty
tree? It mainly seems useful as the first arg in the three arg -m form.

> Once that is done, git octopus will be able to handle the no merge base
> case.
> 

Once that is done, git octopus could _optionally_ handle the "I can't
find a merge base" case by passing 0 as the merge base to git-read-tree.

--
Darrin
