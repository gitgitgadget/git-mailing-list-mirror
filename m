X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] git-fetch: ignore dereferenced tags in expand_refs_wildcard
Date: Mon, 04 Dec 2006 17:08:28 -0800
Message-ID: <7vwt57kv3n.fsf@assigned-by-dhcp.cox.net>
References: <1165260874.20055.4.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 01:08:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33277>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOnY-00058l-D2 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967947AbWLEBIb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967946AbWLEBIb
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:08:31 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44793 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967947AbWLEBI3 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 20:08:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205010828.KSSF18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 20:08:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id up8e1V00Q1kojtg0000000; Mon, 04 Dec 2006
 20:08:38 -0500
To: Michael Loeffler <zvpunry@zvpunry.de>
Sender: git-owner@vger.kernel.org

Michael Loeffler <zvpunry@zvpunry.de> writes:

> There was a little bug in the brace expansion which should remove
> the ^{} from the tagname. It used ${name#'^{}'} instead of $(name%'^{}'},
> the difference is that '#' will remove the given pattern only from the
> beginning of a string and '%' only from the end of a string.

Thanks.  Shows that I do not use post 80's shell features ;-).
