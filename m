From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: GSoC 2009 Prospective student
Date: Mon, 23 Feb 2009 00:46:29 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngq3sf4.fl1.sitaramc@sitaramc.homelinux.net>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com>
 <20090222204334.GY4371@genesis.frugalware.org>
 <alpine.LFD.2.00.0902221709460.5511@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 01:48:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbOzQ-0002xO-QT
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 01:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbZBWAqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 19:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbZBWAqj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 19:46:39 -0500
Received: from main.gmane.org ([80.91.229.2]:48465 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577AbZBWAqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 19:46:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LbOxy-0002V3-1e
	for git@vger.kernel.org; Mon, 23 Feb 2009 00:46:38 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 00:46:38 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 00:46:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111069>

On 2009-02-22, Nicolas Pitre <nico@cam.org> wrote:
> Restartable clone is _hard_.  Even I who has quite a bit of knowledge in 
> the affected area didn't find a satisfactory solution yet.

I'm sorry I have not followed the earlier discussion.  I
have a question.  I know the rsync transport is not much
used, and I myself have never used it.  But can there not be
a 'sorry, this repo is not yet open' flag that prevents
local git operations while the clone is going on, and then
the actual clone itself merely does an rsync of the
corresponding files?  Because rsync is quite restartable.

I can see that this would be a problem if the remote were to
'git repack' in between 2 attempts by the client, because
the actual tree inside .git/objects would change, but that
is hardly a common occurrence I would think.

I'm sorry if I'm being naive and missing a lot of important
nuances -- but I was looking at it from a "if I had to do it
in shell how would I do it' mindset.

Or perhaps by 'restartable clone' you also mean 'restartable
fetch', etc, in which case of course you can't lock out the
repo if a fetch dies partway.

It is not necessary to reply in detail; even a gmane or
other link will do if this was already shot down :-)
