From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] filter-branch docs: remove brackets so not to imply revision
 arg is optional
Date: Thu, 31 Jan 2008 10:29:56 -0600
Message-ID: <47A1F784.3080202@nrlssc.navy.mil>
References: <47A109A7.1070502@nrlssc.navy.mil>	<47A11935.6000707@nrlssc.navy.mil> <7v7ihqhjq9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 17:34:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKcMb-0006EW-G2
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 17:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbYAaQdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 11:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759272AbYAaQdf
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 11:33:35 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56260 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbYAaQde (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 11:33:34 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0VGTvLa020324;
	Thu, 31 Jan 2008 10:29:57 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 31 Jan 2008 10:29:57 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7v7ihqhjq9.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 31 Jan 2008 16:29:57.0229 (UTC) FILETIME=[845D21D0:01C86426]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--6.106100-0-4-1
X-TM-AS-Category-Info: : 4:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtMTg3MDY3LTcwMzQxNy03MDk1ODQtNzEwMjA3LTEwNTcwMC03?=
	=?us-ascii?B?MDYwNDEtMTg4MDE5LTcwMTQ1NS03MDIwMzctNzEwOTg5LTcwMzcy?=
	=?us-ascii?B?MC03MDAwNDAtNzAwMTUxLTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72132>

Junio C Hamano wrote:
> I think this is good for 1.5.4.  I am not sure about the
> "assuming HEAD" one.  Personally I am not very fond of the
> idiot-proofing, but there may be many idiots around here, so...


I see you applied both this patch _and_
"filter-branch: assume HEAD if no revision supplied"

The latter patch _does_ make the revision arg optional, so this
"filter-branch docs" patch is unnecessary.

-brandon
