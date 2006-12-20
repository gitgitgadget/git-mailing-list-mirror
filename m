X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit 
 hooks
Date: Wed, 20 Dec 2006 15:18:40 +0100
Organization: eudaptics software gmbh
Message-ID: <45894640.2E0768B5@eudaptics.com>
References: <200612201309.02119.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 14:18:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 9
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34931>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx2HU-0000ge-01 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 15:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965083AbWLTOSt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 09:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWLTOSs
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 09:18:48 -0500
Received: from main.gmane.org ([80.91.229.2]:34265 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S965083AbWLTOSr
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 09:18:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gx2HJ-00042o-Kj for git@vger.kernel.org; Wed, 20 Dec 2006 15:18:41 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 15:18:41 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20 Dec 2006
 15:18:41 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> +               # check if the subdir is a repository
> +               if [ ! -d "$WORKINGTOP$subdir/.git" ]; then
> +                       echo "$subdir is not a git repository, so it can't be a submodule"

You must redirect the message to >&2 otherwise it remains invisible (it
goes into file newgitmodules).

-- Hannes
