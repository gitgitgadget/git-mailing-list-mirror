X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] hooks/pre-commit: add example to add Signed-off-by line to message
Date: Wed, 20 Dec 2006 09:29:40 -0800
Message-ID: <7vmz5ifpbv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612201604.12498.andyparkins@gmail.com>
	<Pine.LNX.4.63.0612201717490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 17:29:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612201717490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 20 Dec 2006 17:18:30 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34950>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx5GC-0007Tg-Cv for gcvg-git@gmane.org; Wed, 20 Dec
 2006 18:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965157AbWLTR3m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 12:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWLTR3l
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 12:29:41 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46256 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965158AbWLTR3l (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 12:29:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220172940.DZHW25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 12:29:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 15Uy1W00k1kojtg0000000; Wed, 20 Dec 2006
 12:28:59 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 20 Dec 2006, Andy Parkins wrote:
>
>> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
>
> Acked-by: Johannes E. Schindelin <johannes.schindelin@gmx.de>
>
> Ciao,
> Dscho

Why SQUASH_MSG?  Doesn't it confuse git-explain when it wants to
detect that you are in the middle of a squash merge?
