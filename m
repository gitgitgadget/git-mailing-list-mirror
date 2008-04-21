From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 21 Apr 2008 11:10:30 -0500
Message-ID: <480CBC76.7020303@nrlssc.navy.mil>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 18:12:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnycc-0005ZT-E6
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 18:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759950AbYDUQLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 12:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759940AbYDUQLM
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 12:11:12 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44326 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759866AbYDUQLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 12:11:11 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m3LGAcwQ015242;
	Mon, 21 Apr 2008 11:10:38 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 21 Apr 2008 11:10:30 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 21 Apr 2008 16:10:30.0923 (UTC) FILETIME=[38A6B5B0:01C8A3CA]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15862003
X-TM-AS-Result: : Yes--3.857500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTgzMzUxOC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDYzMC03MDIwNDQtNzA1OTAxLTcxMTYxMi03?=
	=?us-ascii?B?MTE4NjMtNzA1NDUwLTcwMzc4OC03MDEyMjAtNzAwMzk4LTE0ODAz?=
	=?us-ascii?B?OS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80028>

Junio C Hamano wrote:

> * bc/filter-branch (Wed Mar 26 10:47:09 2008 -0500) 1 commit
>  - filter-branch.sh: support nearly proper tag name filtering
> 
> Instead of discarding signed tags, this demotes them to simply annotated,
> which is technically not that different from signed tags.

I just want to point out that this patch is not exclusively about signed
tags.

The patch is about retaining annotated tags rather than demoting them to
light-weight tag references as is done currently for _all_ annotated tags,
signed and unsigned. When rewriting signed tags, the signature is stripped
so that we don't write a tag with a bogus signature.

-brandon
