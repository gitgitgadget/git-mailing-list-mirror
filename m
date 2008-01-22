From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Files not deleted when merging after a rename
Date: Tue, 22 Jan 2008 08:28:25 +0100
Message-ID: <20080122072825.GA2971@steel.home>
References: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com> <20080121212015.GB5263@steel.home> <d997e2110801211345x6ee35d48s2038fbd773149110@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Desnoyer <mdesnoyer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 08:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHDZ4-0001xY-Uw
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 08:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbYAVH23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 02:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbYAVH23
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 02:28:29 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:25870 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbYAVH22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 02:28:28 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKatAU=
Received: from tigra.home (Fab8e.f.strato-dslnet.de [195.4.171.142])
	by post.webmailer.de (fruni mo33) (RZmta 15.4)
	with ESMTP id c03ffek0M3RF4K ; Tue, 22 Jan 2008 08:28:26 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 24B32277AE;
	Tue, 22 Jan 2008 08:28:26 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 85A8E56D25; Tue, 22 Jan 2008 08:28:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d997e2110801211345x6ee35d48s2038fbd773149110@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71424>

Mark Desnoyer, Mon, Jan 21, 2008 22:45:40 +0100:
> Alex,
> 
> The directory did not have any untracked files in it. Looking a little
> more carefully, I realized that there were subdirectories in foo/bar/.

Were these subdirectories containing exclusively tracked files?
Or is it Winblows and some process was blocking the deletion?
