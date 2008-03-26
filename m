From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] mktag.c: improve verification of tagger field and tests
Date: Tue, 25 Mar 2008 19:44:54 -0500
Message-ID: <47E99C86.7090306@nrlssc.navy.mil>
References: <1206490795-13247-1-git-send-email-casey@nrlssc.navy.mil> <47E99B98.1060506@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 01:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeJmI-0008Fe-5S
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 01:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757737AbYCZAo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 20:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761405AbYCZAo5
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 20:44:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57359 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757615AbYCZAo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 20:44:56 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2Q0itGA023280
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 19:44:55 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Mar 2008 19:44:55 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47E99B98.1060506@nrlssc.navy.mil>
X-OriginalArrivalTime: 26 Mar 2008 00:44:55.0051 (UTC) FILETIME=[9BF3A5B0:01C88EDA]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--3.213000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwODQ2LTcxMDc4NC03MDM5NjktNzAwMDczLTEzOTYyOS03?=
	=?us-ascii?B?MDE2OTItNzAzNzIwLTcwNjg5MS03MDA2MjQtNzAwODAyLTcwMzY1?=
	=?us-ascii?B?Ny0xMDU3MDAtMTQ4MDM5LTE0ODA1MS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78238>

Brandon Casey wrote:

>    -tagger field has form: A U Thor <author@example.com> SSSSSSSSS [[+]hhmm]
>                            where the SSSS's are the time stamp and the time
>                            zone is optional

Just to clarify, I'm not implying fixed width for the timestamp here. It's
1 or more digits.

-brandon
