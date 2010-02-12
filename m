From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Maintaining a fork workflows
Date: Fri, 12 Feb 2010 07:37:31 -0500
Message-ID: <87k4uid3zo.fsf@troilus.org>
References: <f7b87f7c1002120123t376f3f14ma3f3bcb21ae2836@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christos Trochalakis <yatiohi@ideopolis.gr>
X-From: git-owner@vger.kernel.org Fri Feb 12 13:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfumC-00058D-IU
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab0BLMhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 07:37:36 -0500
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:57781 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751837Ab0BLMhf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 07:37:35 -0500
Received: from source ([74.125.92.24]) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS3VLjiw4YIbOAwWU6JYenWzRuURJb2ET@postini.com; Fri, 12 Feb 2010 04:37:34 PST
Received: by qw-out-2122.google.com with SMTP id 3so410790qwe.3
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 04:37:33 -0800 (PST)
Received: by 10.224.118.206 with SMTP id w14mr646255qaq.366.1265978253725;
        Fri, 12 Feb 2010 04:37:33 -0800 (PST)
Received: from graviton.troilus.org (pool-72-83-66-147.washdc.east.verizon.net [72.83.66.147])
        by mx.google.com with ESMTPS id 20sm2186889qyk.13.2010.02.12.04.37.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 04:37:32 -0800 (PST)
In-Reply-To: <f7b87f7c1002120123t376f3f14ma3f3bcb21ae2836@mail.gmail.com>
	(Christos Trochalakis's message of "Fri, 12 Feb 2010 11:23:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139696>

Christos Trochalakis writes:

> Hello, I have created a light fork of an upstream project and I am not
> quite sure which "syncing with upstream" workflow fits better.
>
> I can think of 3 solutions
> 1. the obvious one, merge the upstream changes on the forked branch
> and make the necessary modifications on the merge commit
> 2. Rebase upstream commits on top of the fork & make a commit with the
> necessary modifications
> 3. Cherrypick & modify upstream commits
>
> Which practice is considered better?

I would recommend #1 if you expect other people to base work on your
tree, and #2 if you don't.  #1 preserves both tree's histories, rather
than occasionally rewriting your tree's history like #2 does.  #3 at
best hides the relationship between the upstream history and the
cherry-picked commits, which is why it isn't a serious contender to me.

Michael Poole
