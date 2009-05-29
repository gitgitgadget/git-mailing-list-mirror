From: Eric Raible <raible@gmail.com>
Subject: Re: WISH: Extending git commit --amend
Date: Fri, 29 May 2009 08:09:58 +0000 (UTC)
Message-ID: <loom.20090529T080514-262@post.gmane.org>
References: <e5bfff550905282348gf29aa16o6eec88423bb5ce23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 10:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9xAa-0005wI-4J
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 10:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbZE2IKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 04:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbZE2IKS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 04:10:18 -0400
Received: from main.gmane.org ([80.91.229.2]:60372 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254AbZE2IKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 04:10:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M9xAP-0003F4-9y
	for git@vger.kernel.org; Fri, 29 May 2009 08:10:17 +0000
Received: from adsl-67-119-194-173.dsl.pltn13.pacbell.net ([67.119.194.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2009 08:10:17 +0000
Received: from raible by adsl-67-119-194-173.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 May 2009 08:10:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.119.194.173 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120257>

Marco Costalba <mcostalba <at> gmail.com> writes:

> [snip]
> I find myself wanting to amend not tip of the branch, but an older
> commit (typically to change log message). As example if I have this
> 
> D---E---F---G master
> 
> And I want to amend revision E currently I do
> 
> [snip]
> 
> Thanks in advance
> Marco
> 

git rebase --interactive E^
Then change the commit for E from 'pick' to 'edit'.
Then follow the directions.

- Eric
