From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-rebase and reflog
Date: Wed, 30 Apr 2008 12:05:14 -0500
Message-ID: <4818A6CA.5000409@nrlssc.navy.mil>
References: <46dff0320804300904i3402b5e7wf827f6759bc52901@mail.gmail.com>	 <m3d4o7nvt2.fsf@localhost.localdomain> <46dff0320804300956x7e4f34efle39f6cad2e98a2de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:06:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrFkz-0004rR-6v
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173AbYD3RFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782AbYD3RFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:05:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45085 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbYD3RFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:05:24 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m3UH5EIY016298;
	Wed, 30 Apr 2008 12:05:14 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Apr 2008 12:05:14 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <46dff0320804300956x7e4f34efle39f6cad2e98a2de@mail.gmail.com>
X-OriginalArrivalTime: 30 Apr 2008 17:05:14.0592 (UTC) FILETIME=[5B969600:01C8AAE4]
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80849>

Ping Yin wrote:

> If your are right, how can i look over the branch reflog. I know the
> master@{1} syntax, but i want to see master@{1}, master@{2} until
> master@{n} in a single command just as how 'git reflog' shows HEAD@{1}
>  to HEAD@{n}.

Have you checked the documentation for 'git reflog'?

It says:

   The subcommand "show" (which is also the default, in the absence of any
   subcommands) will take all the normal log options, and show the log of
   the reference provided in the command-line (or `HEAD`, by default).

So, 'git reflog show master' should get you what you want.

You may also want to check out the '-g' option to git-log. For example,
'git log -g master'.

-brandon
