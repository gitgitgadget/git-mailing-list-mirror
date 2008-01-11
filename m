From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Fri, 11 Jan 2008 16:47:17 -0600
Message-ID: <4787F1F5.2010905@nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDSfH-00017s-3a
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 23:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761737AbYAKWrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 17:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761054AbYAKWrY
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 17:47:24 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38422 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbYAKWrX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 17:47:23 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0BMlHfX022749;
	Fri, 11 Jan 2008 16:47:19 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Jan 2008 16:47:17 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <4787E981.7010200@nrlssc.navy.mil>
X-OriginalArrivalTime: 11 Jan 2008 22:47:17.0406 (UTC) FILETIME=[EAB2FBE0:01C854A3]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15652001
X-TM-AS-Result: : Yes--11.811500-0-2-1
X-TM-AS-Category-Info: : 2:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1NzA0Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDQ3Ni03MDA5NzEtNzA5MjUxLTcwNDQzMC03?=
	=?us-ascii?B?MTE2MjQtNzAxMjMyLTcwNDI1Ny03MDI1OTgtNzAwMTA4LTcwMDA3?=
	=?us-ascii?B?NC03MDQ4MjAtNzAzNTIzLTcwMDA1Ny0xMzk3MDQtMTQ4MDM5LTE0?=
	=?us-ascii?B?ODA1MS0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70218>



It's reproduceable for me by amending the commit.

Any suggestions?

-brandon



Brandon Casey wrote:
> I got this message from git-commit:
> 
> $ git commit -a
> <edit message, :wq>
> fatal: Out of memory? mmap failed: Bad file descriptor
> Create commit <my_prompt_string>
> 
> The exit status was 128.
> Looks like the commit was successful though.
> The partial message 'Create commit ' comes from print_summary()
> in builtin-commit.c which is _after_ the actual commit.
> 
> $ git --version
> git version 1.5.4.rc2.84.gf85fd-dirty
> 
> It was compiled with NO_CURL=1. The dirtiness comes from the
> patches I submitted for relink earlier today.
> 
> The other possible clue is that this repo is on NFS.
> 
> -brandon
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
