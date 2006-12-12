X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Colourise git-branch output
Date: Tue, 12 Dec 2006 09:46:29 +0100
Organization: eudaptics software gmbh
Message-ID: <457E6C65.4B6D131@eudaptics.com>
References: <200612120641.52556.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 08:46:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 11
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34069>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu3Gx-0005aY-1h for gcvg-git@gmane.org; Tue, 12 Dec
 2006 09:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750992AbWLLIpp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 03:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWLLIpp
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 03:45:45 -0500
Received: from main.gmane.org ([80.91.229.2]:59943 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1750891AbWLLIpo
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 03:45:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gu3GQ-0000vq-GU for git@vger.kernel.org; Tue, 12 Dec 2006 09:45:26 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 09:45:26 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 12 Dec 2006
 09:45:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> This patch chooses green for local, red for remote and bold green for
> current.

Sorry for chiming in so late, but red and green are usually poor choices
since red-green color-blindness is surprisingly frequent...

Maybe its sufficient to have just the remote branches (dark-)red, and
the rest in the default color, with the current branch bold?

-- Hannes
