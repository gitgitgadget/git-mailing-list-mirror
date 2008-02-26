From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
 threads for packing
Date: Tue, 26 Feb 2008 16:50:39 -0600
Message-ID: <47C497BF.8080900@nrlssc.navy.mil>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil> <20080226074933.GA3485@coredump.intra.peff.net> <47C435DC.2070508@nrlssc.navy.mil> <20080226212118.GA32530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 27 00:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU8rQ-0007ds-Iw
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 00:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbYBZXEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 18:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbYBZXEo
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 18:04:44 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39834 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYBZXEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 18:04:43 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1QModPx021771;
	Tue, 26 Feb 2008 16:50:40 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Feb 2008 16:50:39 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080226212118.GA32530@sigill.intra.peff.net>
X-OriginalArrivalTime: 26 Feb 2008 22:50:39.0312 (UTC) FILETIME=[020BE500:01C878CA]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15750001
X-TM-AS-Result: : Yes--6.753700-0-2-1
X-TM-AS-Category-Info: : 2:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMTE4Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDc1Ni0xMDUyNTAtNzA1MTAyLTEwNTQwMC0x?=
	=?us-ascii?B?MDYzOTAtNzAyMDIwLTcwMzg3OC03MDc3NjAtNzAxNTk0LTcxMDU3?=
	=?us-ascii?B?MS03MDQ5MjctNzAxOTA3LTcwODE3OS03MDIxMTMtNzAxMjk4LTcw?=
	=?us-ascii?B?MzcxMi03MDY4OTEtNzAwMTMzLTE4NzA2Ny03MDMwODgtMTQ4MDM5?=
	=?us-ascii?B?LTIwMDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75188>

Jeff King wrote:

> I don't think it's worth printing output so verbose that the user can
> manually check that every config option was respected.

It's hard coming up with examples that someone cannot take to the N'th
degree and make look ridiculous. Maybe impossible.

> At any rate, I think your reasoning is not a good guideline for user
> output.

My reasoning was that I liked it. I thought it was interesting and useful
to show the number of threads that pack-objects was using. The example I
gave was to show how it could be useful to non-developers since Junio
suggested that the information was primarily of interest for git developers
and he didn't think that end users would care.

In any case, I'm not attached to the patch. I am thankful for Nicolas's
patch though, since it forced me to learn the relationship between progress
and pack_to_stdout.

-brandon
