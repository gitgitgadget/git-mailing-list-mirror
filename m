From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Hint for rebase in progress
Date: Fri, 18 Feb 2011 10:07:41 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4D5E36DD.7060307@atlas-elektronik.com>
References: <AANLkTikY-e7pD1nnbnz_m41wn0AbyF7Fj4z8K6WuznOL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 10:08:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqMJt-0002cr-Qr
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 10:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213Ab1BRJHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 04:07:47 -0500
Received: from mail96.atlas.de ([194.156.172.86]:42699 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757972Ab1BRJHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 04:07:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id B2BAF10084;
	Fri, 18 Feb 2011 10:07:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id 5soye2MV2amE; Fri, 18 Feb 2011 10:07:37 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 18 Feb 2011 10:07:37 +0100 (CET)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 1365A2716A;
	Fri, 18 Feb 2011 10:07:37 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTikY-e7pD1nnbnz_m41wn0AbyF7Fj4z8K6WuznOL@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167187>

On 2/18/2011 9:12 AM, Jeenu V wrote:
> I was once in the middle of an interactive rebase, editing a commit
> and happened to do a git status. I could see that Git warns in red
> color "Not currently on any branch". Similarly, git branch said "* (no
> branch)". Having gone this far, wouldn't it be helpful for Git to also
> remind "Rebase in progress" or something like that, some where in
> these hints? Since git status is meant to display the current status
> of the tree, I think it's only apt for it to report so.
> 
> Because, once in a active rebase session, I think there's no command
> which tells user that an interactive session is in progress (or is
> there?); gitk doesn't help either. If the user happens to take a break
> or something, it might be bit perplexing to figure out where he was,
> why it was (seeing the working directory headless).
> 

Look in $OFFICIAL-GIT-REPO/contrib/completion/git-completion.bash.
Set your 'PS1' as explained there and you will see at your command
prompt if you're currently rebasing.

HTH,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: URA Redneck if you own a homemade fur coat.
