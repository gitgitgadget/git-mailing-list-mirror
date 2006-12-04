X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Mon, 04 Dec 2006 09:56:50 +0100
Message-ID: <87zma4yr71.fsf@mid.deneb.enyo.de>
References: <20061128220605.GA1253@localdomain>
	<871wnget3b.fsf@mid.deneb.enyo.de> <20061204085253.GA31047@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 08:57:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061204085253.GA31047@soma> (Eric Wong's message of "Mon, 4 Dec
	2006 00:52:53 -0800")
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33173>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr9dU-0006hX-4p for gcvg-git@gmane.org; Mon, 04 Dec
 2006 09:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759729AbWLDI5N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 03:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759762AbWLDI5N
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 03:57:13 -0500
Received: from mail.enyo.de ([212.9.189.167]:33040 "EHLO mail.enyo.de") by
 vger.kernel.org with ESMTP id S1759729AbWLDI5N (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 03:57:13 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1Gr9dM-0002s1-QJ; Mon, 04 Dec 2006 09:57:08 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1Gr9d5-0007yM-Pq; Mon, 04 Dec 2006 09:56:51 +0100
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

* Eric Wong:

> Does the following patch help?

Don't think so.  The issue is not timing-related.  I've seen a failure
every 1000 requests, which suggests to me that it's hitting the
