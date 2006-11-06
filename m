X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe -C -C -C
Date: Mon, 06 Nov 2006 09:25:04 -0800
Message-ID: <7v3b8webdb.fsf@assigned-by-dhcp.cox.net>
References: <junkio@cox.net>
	<200611061646.kA6GkHgi009592@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 17:43:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611061646.kA6GkHgi009592@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Mon, 06 Nov 2006 13:46:17 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31019>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh8Df-0000Ty-Qh for gcvg-git@gmane.org; Mon, 06 Nov
 2006 18:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753494AbWKFRZH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 12:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbWKFRZH
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 12:25:07 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36765 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1753494AbWKFRZG
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 12:25:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061106172505.LXTM18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 12:25:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id jVR91V00h1kojtg0000000; Mon, 06 Nov 2006
 12:25:10 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Three -C options makes the command to look for copied lines from _any_
>> existing file in the parent commit, not just changed files.
>
> IMHO, this is horrible UI.
>
> -C        is one thing
> -C -C     is another
> -C -C -C  is still another?

I think of it as "-v" vs "-v -v" vs "-v -v -v" some programs use
to give you increasing levels of verbosity.

Triple-C version is a kind of joke and not to be integrated
(although it seems to work as advertised, it is inpractically
slow), so it really is between -C vs -C -C, but certainly I am
open to better ways of specifying the current -C/-C -C options.
