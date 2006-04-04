From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [BUG] git-http-fetch segfault
Date: Tue, 4 Apr 2006 11:49:36 -0700
Message-ID: <20060404184935.GG14967@reactrix.com>
References: <4432A8CC.5020200@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 20:50:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQqb7-0008GP-9g
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 20:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWDDStq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 14:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWDDStq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 14:49:46 -0400
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:22628 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750789AbWDDStq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 14:49:46 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k34Ina2X004238;
	Tue, 4 Apr 2006 11:49:36 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k34Inaas004236;
	Tue, 4 Apr 2006 11:49:36 -0700
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
Content-Disposition: inline
In-Reply-To: <4432A8CC.5020200@o2.pl>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18403>

On Tue, Apr 04, 2006 at 07:11:40PM +0200, Radoslaw Szkodzinski wrote:

> I have some problems cloning stgit repository (maybe something's broken there).
> 
> astralstorm@zen /home/devel $ git clone
> http://homepage.ntlworld.com/cmarinas/stgit.git stgit
> error: Unable to find adad46f365219e9bcc1a212826ca65eaac09729c under
> http://homepage.ntlworld.com/cmarinas/stgit.git/
> Cannot obtain needed blob adad46f365219e9bcc1a212826ca65eaac09729c
> while processing commit 8847a11b3bbf5406f37a360e5466f0e392c56383.

That host name resolves to multiple IP addresses, is it possible that
one of the servers was out of sync?  I tried cloning directly from each
address and couldn't reproduce the problem.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
