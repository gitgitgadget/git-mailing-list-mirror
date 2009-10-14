From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD was
Date: Wed, 14 Oct 2009 23:52:25 +0000 (UTC)
Message-ID: <loom.20091015T013728-831@post.gmane.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 01:54:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyDfN-0008IR-6I
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 01:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762168AbZJNXxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 19:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762166AbZJNXxj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 19:53:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:50074 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756973AbZJNXxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 19:53:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MyDeI-0006ls-Ru
	for git@vger.kernel.org; Thu, 15 Oct 2009 01:52:55 +0200
Received: from 63.112.0.74 ([63.112.0.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 01:52:54 +0200
Received: from raible by 63.112.0.74 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 01:52:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.112.0.74 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.25 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130352>

Junio C Hamano <gitster <at> pobox.com> writes:

> It won't help to alleviate my irritation if I need to give -f to each and
> every invocation of "git commit" while detached, though.

I'm missing something fundamental here, I think.
I simply don't see the advantage of branching after committing
over branching before committing.

At worst, a temporary is cheap, eh?  So what is the value
of even allowing committing while HEAD is detached
(aside from the historical argument)?
