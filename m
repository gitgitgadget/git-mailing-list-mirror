From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 04 Feb 2008 16:56:32 -0600
Message-ID: <47A79820.50405@nrlssc.navy.mil>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <47A78104.9050909@nrlssc.navy.mil> <alpine.LSU.1.00.0802042128170.8543@racer.site> <47A78CF9.6040001@nrlssc.navy.mil> <alpine.LSU.1.00.0802042218280.8543@racer.site> <47A79541.6070900@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMAFf-0005Jn-Jv
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936AbYBDW4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbYBDW4u
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:56:50 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50061 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbYBDW4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:56:50 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m14MuXHM013823;
	Mon, 4 Feb 2008 16:56:33 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Feb 2008 16:56:33 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47A79541.6070900@nrlssc.navy.mil>
X-OriginalArrivalTime: 04 Feb 2008 22:56:33.0239 (UTC) FILETIME=[2FEA5E70:01C86781]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--10.818900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAyMDIwLTcwMTAwNS03MDIwNDQtNzExOTUzLTcwMjcyNi03?=
	=?us-ascii?B?MDQ0MjUtNzAxNTgzLTcwMDk3MS03MDY4OTEtNzAzNzEyLTcwNTM4?=
	=?us-ascii?B?OC03MDE2MTgtNzA2NDU0LTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72588>

Brandon Casey wrote:
> Johannes Schindelin wrote:

> If your statement above is rephrased to "I _want_ the original repository to
> know that it has conjoined siblings.", then we have a new repository type:
> 
> 	4) conjoined repository (it has multiple sibling repositories each
> 	   with their own working directory, but they all share and modify the
> 	   same .git directory)

By the way, none of the repositories has to "own" the .git directory. This is
made much easier by Lars's new changes. All of the repos could contain a
.git symlink file which points to some other directory.

I'm not saying this would be the common case, just with the .git directory
not residing within _any_ of the repositories/work-dirs it really blurs any
difference between them. They would all be equals, even though some may have
been created _from_ the others. (if that makes sense)

-brandon
