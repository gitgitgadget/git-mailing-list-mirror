From: Elrond <elrond+kernel.org@samba-tng.org>
Subject: Re: Lazy clone ideas
Date: Fri, 16 Jun 2006 22:59:25 +0000 (UTC)
Message-ID: <loom.20060617T005427-633@post.gmane.org>
References: <e6e1jm$tes$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 17 00:59:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrNI1-0007Hs-Ih
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 00:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWFPW7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 18:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWFPW7k
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 18:59:40 -0400
Received: from main.gmane.org ([80.91.229.2]:14214 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751543AbWFPW7j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 18:59:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FrNHr-0007H3-Qk
	for git@vger.kernel.org; Sat, 17 Jun 2006 00:59:35 +0200
Received: from p54A72967.dip0.t-ipconnect.de ([84.167.41.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 00:59:35 +0200
Received: from elrond+kernel.org by p54A72967.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 00:59:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.167.41.103 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.3) Gecko/20060326 Firefox/1.5.0.3 (Debian-1.5.dfsg+1.5.0.3-2))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21986>

Jakub Narebski <jnareb <at> gmail.com> writes:
> 
> I've started new thread for lazy clone ideas,
> splitting from "Figured out how to get Mozilla into git"
[...]

I like the lazy clone idea, I think, I said that earlier.


> > This would probably require Eric Biederman's "direct access to blob" 
> > patches, I guess, in order to be feasible.

Are those patches allowing the git: protocol to request a list of objects
directly? (Like my "remote git-cat-file" request?)

What's the status of the patch?


> And it would need place to store URI from where to doenload objects
> on-demand: perhaps 'remote alternatives'?

Yep, that would be the next step.
Having direct access to blobs would be needed first though.


    Elrond
