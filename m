From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: how to reset to remote repo
Date: Mon, 23 Feb 2009 12:49:25 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngq56ql.q4m.sitaramc@sitaramc.homelinux.net>
References: <20090223105546.GA7425@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 13:51:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbaH6-0008Qv-7P
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 13:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbZBWMti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 07:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbZBWMth
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 07:49:37 -0500
Received: from main.gmane.org ([80.91.229.2]:53827 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbZBWMth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 07:49:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LbaFb-0002MH-QW
	for git@vger.kernel.org; Mon, 23 Feb 2009 12:49:35 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 12:49:35 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 12:49:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111134>

On 2009-02-23, bill lam <cbill.lam@gmail.com> wrote:
> I cloned some public git repos and made some local patches. Later I
> pulled updates again and that merged with my patches. Now I want to
> throw away my patches, how do I get a clean working repo that is a
> 100% clone of the remote repo?

git reset --hard origin/master

This is a very simple question, and may be quicker on irc
:-)
