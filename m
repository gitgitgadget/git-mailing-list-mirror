From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git svn: Supporting multiple branch subdirs?
Date: Thu, 18 Jun 2009 10:28:58 -0400
Message-ID: <4A3A4F2A.1080701@xiplink.com>
References: <4A32CCA5.7040404@xiplink.com> <4A339182.1090204@drmicha.warpmail.net> <4A368509.9070801@xiplink.com> <4A38FCEE.2020002@drmicha.warpmail.net> <4A390AFE.5070703@xiplink.com> <4A3A4945.6050307@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, normalperson@yhbt.net
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 16:29:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHIcf-0003xF-Fd
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 16:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761815AbZFRO3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 10:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764620AbZFRO3D
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 10:29:03 -0400
Received: from smtp162.dfw.emailsrvr.com ([67.192.241.162]:44811 "EHLO
	smtp162.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764959AbZFRO3B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 10:29:01 -0400
Received: from relay6.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id B1385301D2
	for <git@vger.kernel.org>; Thu, 18 Jun 2009 10:29:03 -0400 (EDT)
Received: by relay6.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4871D300A3;
	Thu, 18 Jun 2009 10:28:58 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A3A4945.6050307@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121846>

Michael J Gruber wrote:
> 
> Heck it's perl, so don't even try to understand the code - after all,
> perl only barely missed the final round in the last competition for the
> next cryptographic algorithm!

:)

Hey, I'm not gonna dis something with such great job-security potential!

> That being said, I did some clueless hacking in git-svn.perl and let it
> run against the freebsd repo. Now, how's that:
> 
> ~/src/git/git-svn fetch -r1:10000
> 
> git branch -r
>   releng/2.0.5
>   releng/ALPHA_2_0
>   releng/BETA_2_0
>   stable/2.0.5
>   stable/2.1
>   tags/2.0
>   tags/2.0.5
>   trunk
> 
> The revision graph looks OK as well. The git-svn config which I used is:

Nice!

> [svn-remote "svn"]
>         url = svn://svn.freebsd.org/base
>         fetch = head:refs/remotes/trunk
>         branches = releng/*:refs/remotes/releng/*
>         branchse = stable/*:refs/remotes/stable/*
>         tags = release/*:refs/remotes/tags/*
> 
> No typo there, my git svn knows about "branches" and "branchse" now ;)
> BTW: In fact there is overlap between releng and stable branches in the
> feebsd repo, see 2.0.5.

By "overlap" do you mean single commits that touch both branches?  FreeBSD does that a lot.

But for 2.0.5, it looks to me like the stable/2.0.5 branch was abandoned after the 2.0.5_ALPHA release.

> I'll send a monkey patch in a minute.

Fantastic!  Thanks so much for this.

		M.
