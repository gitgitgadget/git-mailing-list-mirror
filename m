From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-format-patch|git-send-email sucks
Date: Tue, 25 Mar 2008 14:06:36 -0500
Message-ID: <47E94D3C.3080306@nrlssc.navy.mil>
References: <alpine.LNX.1.10.0803251914060.2240@fbirervta.pbzchgretzou.qr> <alpine.LNX.1.10.0803251928500.7062@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:07:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeEUX-0003RB-Q0
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067AbYCYTGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757068AbYCYTGn
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:06:43 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47265 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067AbYCYTGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:06:42 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2PJ6aed017888;
	Tue, 25 Mar 2008 14:06:36 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Mar 2008 14:06:36 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LNX.1.10.0803251928500.7062@fbirervta.pbzchgretzou.qr>
X-OriginalArrivalTime: 25 Mar 2008 19:06:36.0301 (UTC) FILETIME=[58F433D0:01C88EAB]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--7.852000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MTA2My03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwNzQ1MS03MDc4NjYtNzAyNzkxLTcwMTI5Ni03?=
	=?us-ascii?B?MDEyMzItNzAxNTkwLTcxMDIyNC0xODgwMTktNzAwNjE4LTcwNjcx?=
	=?us-ascii?B?OS03MDAzNDUtNzAwMDQwLTcwNzc4OC0xNDgwMzktMTQ4MDUxLTIw?=
	=?us-ascii?B?MDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78206>

Jan Engelhardt wrote:

> To be in the picture, the command issued was:
> 
> rm -f 00*; git-format-patch -C -M --stat=72 --summary -p --thread -n
> origin/symbolic/upstream..HEAD; git-send-email --thread
> --no-signed-off-by-cc --no-chain --to user2@localhost 00*

Maybe adding --suppress-from would help?

See the --suppress-* family in the git-send-email docs along with the
sendemail.suppress* configuration counterparts.

-brandon
