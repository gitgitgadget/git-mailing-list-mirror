From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] filter-branch: assume HEAD if no revision supplied
Date: Wed, 30 Jan 2008 18:20:59 -0600
Message-ID: <47A1146B.5040601@nrlssc.navy.mil>
References: <47A0D0F0.1020800@nrlssc.navy.mil> <alpine.LSU.1.00.0801302034310.23907@racer.site> <7vk5lrgh56.fsf@gitster.siamese.dyndns.org> <47A109A7.1070502@nrlssc.navy.mil> <alpine.LSU.1.00.0801310013010.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 31 01:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKNDz-00016o-Uq
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 01:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbYAaAXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 19:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756214AbYAaAXo
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 19:23:44 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42396 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147AbYAaAXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 19:23:43 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0V0L0VF012186;
	Wed, 30 Jan 2008 18:21:00 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 18:21:00 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0801310013010.23907@racer.site>
X-OriginalArrivalTime: 31 Jan 2008 00:21:00.0321 (UTC) FILETIME=[2810F910:01C8639F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--8.974000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAxNzQ2LTcwMTQ1NS03MDI1NTEtNzA3MzYxLTcwMDk3MC03?=
	=?us-ascii?B?MDM3MTItNzA4MjU3LTE0ODAzOS0xNDgwNTEtMjAwNDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72081>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 30 Jan 2008, Brandon Casey wrote:
> 
>> Junio C Hamano wrote:

<snip>
>>> (unless you are trying to rewrite the history with grafts).
>> That's what I was trying to do :)
> 
> But then you would have to keep the test for $#, but enhance it like this:
> 
> case "$#,$filter_env,$filter_tree,$filter_index,$filter_parent,\
> $filter_msg,$filter_commit,$filter_tag_name,$filter_subdir" in
> 0,,,,,cat,'git commit-tree "$@"',)
> 	usage
> esac

I meant I was trying to rewrite the history with grafts. :)

-brandon
