From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Unknown option: no-signed-off-by-cc (git-send-email)
Date: Mon, 03 Mar 2008 13:17:56 -0600
Message-ID: <47CC4EE4.1050106@nrlssc.navy.mil>
References: <47CC21F7.3020204@freescale.com> <47CC4423.8020109@freescale.com> <47CC456B.6000203@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:19:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGBc-00084e-6O
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbYCCTSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 14:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYCCTSK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:18:10 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39601 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbYCCTSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 14:18:09 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m23JHua1011162;
	Mon, 3 Mar 2008 13:17:56 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 3 Mar 2008 13:17:56 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47CC456B.6000203@freescale.com>
X-OriginalArrivalTime: 03 Mar 2008 19:17:56.0384 (UTC) FILETIME=[493A2200:01C87D63]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15764001
X-TM-AS-Result: : Yes--15.307000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAxMjkyLTcwNzMyMS03MDQ0MjEtNzA3NDkwLTcwMzc4OC0x?=
	=?us-ascii?B?MDY0MjAtNzAwMTA3LTE4ODE5OC03MDUzODgtNzAwNjE4LTcwNTEw?=
	=?us-ascii?B?Mi03MDA2MjQtMTA1MDQwLTcwMjA0Mi0xNDgwMzktMTQ4MDUxLTIw?=
	=?us-ascii?B?MDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75973>

Timur Tabi wrote:
> Jon Loeliger wrote:
> 
>> Except that the "no" and "signed" are not separated by "-".
> 
> From the man page:
> 
>        --no-signed-off-by-cc
>               Do  not add emails found in Signed-off-by: lines to the cc list.
> 
> However, when I removed the "-", it worked.  So thanks for that.
> 
> It *used* to work with the "-", so I consider it a bug.
> 

git-send-email.txt does still mention --no-signed-off-by-cc, and additionally
--no-chain-reply-to, --no-suppress-from, and --no-thread.

Shouldn't either work? This is from the Getopt::Long man page:

       !   The option does not take an argument and may be negated, i.e. pre-
           fixed by "no". E.g. "foo!" will allow "--foo" (a value of 1 will
           be assigned) and "--nofoo" and "--no-foo" (a value of 0 will be
           assigned). If the option has aliases, this applies to the aliases
           as well.

Looks like --no-signed-off-by-cc or --nosigned-off-by-cc should work, no?

-brandon

