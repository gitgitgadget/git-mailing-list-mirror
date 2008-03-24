From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: filter-branch --all?
Date: Mon, 24 Mar 2008 16:33:00 -0500
Message-ID: <47E81E0C.8050609@nrlssc.navy.mil>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241152050.4353@racer.site> <7viqzc18j9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241609540.4353@racer.site> <263C0D8D-0454-402A-B65C-08E91F7BD5C7@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JduIj-0000Fp-JS
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 22:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYCXVdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 17:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbYCXVdK
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 17:33:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37349 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbYCXVdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 17:33:09 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2OLX2UJ000424;
	Mon, 24 Mar 2008 16:33:03 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Mar 2008 16:33:00 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <263C0D8D-0454-402A-B65C-08E91F7BD5C7@orakel.ntnu.no>
X-OriginalArrivalTime: 24 Mar 2008 21:33:00.0776 (UTC) FILETIME=[A27EF680:01C88DF6]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--12.558000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3My03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDYzMC03MDE0NTUtNzA0OTgwLTcwMDc1Ni03?=
	=?us-ascii?B?MDIwNTctNzAwOTQ5LTcwNDQxMi03MDUzODgtNzA1MTAyLTE0ODAz?=
	=?us-ascii?B?OS0xNDgwNTEtMjAwNDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78102>

Eyvind Bernhardsen wrote:
> On 24. mars. 2008, at 16.10, Johannes Schindelin wrote:
> 
> [Regarding filter-branch rewriting tags]
> 
>> You can say "--all", and I actually expect quite a few people to do
>> exactly that.  And then you cannot really say "the user explicitely asked
>> to have that signed tag rewritten".
> 
> 
> Sorry to hijack the thread.  I've seen you mention using "--all" to
> filter-branch everything before, but I can't get it to work:
> 
> 
>     % git filter-branch --all

Try

    git filter-branch -- --all

It is actually an option to rev-parse.

-brandon
