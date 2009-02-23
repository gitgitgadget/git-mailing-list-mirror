From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: how to reset to remote repo
Date: Mon, 23 Feb 2009 15:50:51 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngq5her.6l3.sitaramc@sitaramc.homelinux.net>
References: <20090223105546.GA7425@b2j>
 <slrngq56ql.q4m.sitaramc@sitaramc.homelinux.net>
 <20090223145722.GB7422@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 16:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbd6c-0004km-G1
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 16:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbZBWPvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 10:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755473AbZBWPvG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:51:06 -0500
Received: from main.gmane.org ([80.91.229.2]:42519 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111AbZBWPvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:51:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lbd5B-0001gQ-99
	for git@vger.kernel.org; Mon, 23 Feb 2009 15:51:01 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 15:51:01 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 15:51:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111145>

On 2009-02-23, bill lam <cbill.lam@gmail.com> wrote:
> On Mon, 23 Feb 2009, Sitaram Chamarty wrote:
>> git reset --hard origin/master
>> 
>> This is a very simple question, and may be quicker on irc
>> :-)
>
> Does it always work?  For example if I already made several patches
> interleaved with several fetch/update, or if I rebase to remove the
> orgin/master?

I'm not sure why a rebase of any kind would remove a remote
brancg but you can always do 'git fetch' first if you
accidentally messed up origin/master.
