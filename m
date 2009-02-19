From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 11:50:53 +0200
Message-ID: <871vtudabm.fsf@iki.fi>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 10:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5aE-0003Pa-Lz
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 10:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbZBSJu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 04:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZBSJu6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 04:50:58 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:53142 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546AbZBSJu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 04:50:57 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48FC5AC905453B5D; Thu, 19 Feb 2009 11:50:54 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1La5YT-0000pl-Ve; Thu, 19 Feb 2009 11:50:53 +0200
In-Reply-To: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> (John Tapsell's message of "Thu\, 19 Feb 2009 09\:21\:49 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110653>

On 2009-02-19 09:21 (UTC), John Tapsell wrote:

>   I often do 'git rebase -i HEAD~10' to rebase. Since afaics it
> doesn't matter if you go back 'too far' I just always use HEAD~10 even
> if it's just for the last or so commit.
>
>   Would there be any objections to making  'git rebase -i' default to
> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
> helps a bit with making it easier to use.

I think it's better to use aliases for this kind of personal things:

    git config --global alias.my-rebase "rebase -i HEAD~10"

Now you can do:

    git my-rebase
