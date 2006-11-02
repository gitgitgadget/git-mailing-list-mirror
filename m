X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/6] remove .keep pack lock files when done with refs update
Date: Wed, 01 Nov 2006 21:27:54 -0800
Message-ID: <7vzmbav2n9.fsf@assigned-by-dhcp.cox.net>
References: <11624187853116-git-send-email-nico@cam.org>
	<11624187853865-git-send-email-nico@cam.org>
	<1162418786895-git-send-email-nico@cam.org>
	<1162418786390-git-send-email-nico@cam.org>
	<11624187871572-git-send-email-nico@cam.org>
	<11624187883225-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 05:29:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11624187883225-git-send-email-nico@cam.org> (Nicolas Pitre's
	message of "Wed, 01 Nov 2006 17:06:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30687>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfV7Q-0004Sg-S3 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 06:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752644AbWKBF15 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 00:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWKBF14
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 00:27:56 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:14569 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1752644AbWKBF14
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 00:27:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061102052755.WXND22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Thu, 2
 Nov 2006 00:27:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hhTz1V00h1kojtg0000000 Thu, 02 Nov 2006
 00:28:00 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> --- a/git-fetch.sh
> +++ b/git-fetch.sh
> @@ -51,7 +51,7 @@ do
>  		verbose=Yes
>  		;;
>  	-k|--k|--ke|--kee|--keep)
> -		keep=--keep
> +		keep=-k -k
>  		;;
>  	--reflog-action=*)
>  		rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`

Micronit.  This cannot be right without quoting.

