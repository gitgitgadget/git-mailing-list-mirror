From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: GPG signing for git commit?
Date: Fri, 17 Apr 2009 18:36:40 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnguhj1o.usr.sitaramc@sitaramc.homelinux.net>
References: <1238793954.19982.14.camel@hyperair-laptop>
 <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain>
 <49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int>
 <20090415192054.GE23604@spearce.org>
 <20090415T220710Z@curie.orbis-terrarum.net>
 <20090416142728.GG23604@spearce.org>
 <slrngufuke.1am.sitaramc@sitaramc.homelinux.net>
 <20090417120110.GC29121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 20:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LusxJ-0007de-S0
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837AbZDQSg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758079AbZDQSg4
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:36:56 -0400
Received: from main.gmane.org ([80.91.229.2]:37806 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbZDQSgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 14:36:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lusvj-0003sg-R7
	for git@vger.kernel.org; Fri, 17 Apr 2009 18:36:51 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 18:36:51 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 18:36:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116767>

On 2009-04-17, Jeff King <peff@peff.net> wrote:
>> If you set GIT_COMMITTER_*, won't it change the SHA of the
>> commit itself?  I always thought so...
>
> No. Pushing will never create a new commit, so there are no new SHA-1s
> calculated. But the reflog entry will contain GIT_COMMITTER_*, and is a
> simple text file.

cool -- I didn't know this.  Thanks!

One last question: where do you set it, in the pre-commit
hook on the server?
