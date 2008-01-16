From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 17:16:56 -0600
Message-ID: <478E9068.1040602@nrlssc.navy.mil>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.44.0801152006260.944-100000@demand>	<7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>	<alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>	<7vodblo6c9.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>	<7v7ii9o2ld.fsf@gitster.siamese.dyndns.org>	<478E893F.4070100@nrlssc.navy.mil> <7vy7apmlci.fsf@gitster.siamese.dyndns.org> <478E8E6B.80702@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:19:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHXS-000592-Dw
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbYAPXRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756823AbYAPXRz
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:17:55 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50118 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820AbYAPXRx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:17:53 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GNGuRr030016;
	Wed, 16 Jan 2008 17:16:56 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 17:16:56 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <478E8E6B.80702@nrlssc.navy.mil>
X-OriginalArrivalTime: 16 Jan 2008 23:16:56.0216 (UTC) FILETIME=[E3049980:01C85895]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--3.708400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3NS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMTQ1NS03MDgxNzktNzAyMDg0LTcwNDI1Ny03?=
	=?us-ascii?B?MDI0NzQtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70771>

Brandon Casey wrote:
> I think you should consider how to handle fdopen on the lock
> descriptor

This happens in
builtin-pack-refs.c:pack_refs
fast-import.c:dump_marks

-brandon
