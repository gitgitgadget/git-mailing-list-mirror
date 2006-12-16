X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Subprojects tasks
Date: Sat, 16 Dec 2006 21:35:53 +0100
Message-ID: <20061216203553.GA25274MdfPADPa@greensroom.kotnet.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 16 Dec 2006 20:36:48 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34639>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvgGw-0002PS-Vs for gcvg-git@gmane.org; Sat, 16 Dec
 2006 21:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932618AbWLPUgk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 15:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWLPUgk
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 15:36:40 -0500
Received: from psmtp12.wxs.nl ([195.121.247.24]:42404 "EHLO psmtp12.wxs.nl"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932618AbWLPUgj
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 15:36:39 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by psmtp12.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.07
 (built Jun 24 2005)) with SMTP id <0JAD006FGVVTV0@psmtp12.wxs.nl> for
 git@vger.kernel.org; Sat, 16 Dec 2006 21:35:54 +0100 (MET)
Received: (qmail 4963 invoked by uid 500); Sat, 16 Dec 2006 20:35:53 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Dec 16, 2006 at 10:32:36AM -0800, Junio C Hamano wrote:
> I suspect the hardest part is "rev-list --objects" (now most of
> it is found in revision.c).  [..]  But I think the updated
> code needs to know that "link" needs to be unwrapped and
> contained "commit" needs to be injected back to the ancestry
> walking machinery.

Do we want "link" to be unwrapped, though ?

> Once you have "rev-list --objects", you should be able to drive
> pack-objects with its output.

Wouldn't we then run into the scalability problems Linus was
concerned about ?

