X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: multiple branches or  multiple repositories
Date: Thu, 02 Nov 2006 18:38:01 -0800
Message-ID: <7vlkmtmf06.fsf@assigned-by-dhcp.cox.net>
References: <eie7ae$ib6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 02:38:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eie7ae$ib6$1@sea.gmane.org> (Han-Wen Nienhuys's message of "Fri,
	03 Nov 2006 02:51:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30769>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfowe-0003Ui-5w for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750991AbWKCCiE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWKCCiE
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:38:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11437 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1750991AbWKCCiC
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:38:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103023802.WAHJ6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:38:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2dg1V00g1kojtg0000000 Thu, 02 Nov 2006
 21:37:41 -0500
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> We're in the process of converting the LilyPond CVS repository at
> savannah.gnu.org to GIT.  One of the questions we need to deal with,
> is how handle modules.
>
> There seem to be two approaches:
>
>  - for each module, create a separate git repository.  Inside the
> repository, each subproject has its own branching
>
>  - put each module as a separate branch in a shared repository.
>
> I think the first option is the most natural one, but are there any
> issues, besides namespace pollution to the second option?

As the layout for a distribution point, the second one may be
easier to handle (one place to remotely sync with), but in all
other aspects the first option should be easier to deal with
day-to-day.

