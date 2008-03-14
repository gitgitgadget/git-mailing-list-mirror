From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/t6000lib.sh: tr portability fix fix
Date: Fri, 14 Mar 2008 16:00:59 -0500
Message-ID: <47DAE78B.6050602@nrlssc.navy.mil>
References: <20080312213831.GJ26286@coredump.intra.peff.net> <47DAE469.7080409@nrlssc.navy.mil> <20080314205415.GA17728@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: armstrong.whit@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:03:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaH3K-0007fn-Nf
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114AbYCNVCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 17:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755739AbYCNVCS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:02:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34686 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbYCNVCR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 17:02:17 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2EL0xj5005054;
	Fri, 14 Mar 2008 16:01:00 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Mar 2008 16:00:59 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080314205415.GA17728@coredump.intra.peff.net>
X-OriginalArrivalTime: 14 Mar 2008 21:00:59.0598 (UTC) FILETIME=[8140F6E0:01C88616]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15784001
X-TM-AS-Result: : Yes--9.473000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMTE4Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTE4ODAxOS03MDMwOTYtNzA5NTg0LTcxMTQzMi03?=
	=?us-ascii?B?MDM3ODgtNzAyMDIwLTcwMDYxOC03MDA2ODUtNzAwNzU2LTcwMjM1?=
	=?us-ascii?B?OC0xNDgwMzktMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77283>

Jeff King wrote:
> On Fri, Mar 14, 2008 at 03:47:37PM -0500, Brandon Casey wrote:
>> If the dashdash notation is not portable, then
>> backslashing each dash also works. i.e. '\-\-\-\-..

> I wonder if there are
> systems that will get confused about it being a range.

Oh, now I understand _why_ backslashing the dashes worked. When your
email arrived I was still trying to figure out why

  echo hello | tr aeiou '\-\-\-\-\-'

correctly converted the e and o into dashes. Because tr must have a
way for the user to escape the range notation. I don't use tr very
often.

-brandon
