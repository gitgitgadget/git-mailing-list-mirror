X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	TRACKER_ID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit 
 hooks
Date: Wed, 20 Dec 2006 14:29:42 +0100
Organization: eudaptics software gmbh
Message-ID: <45893AC6.910D5748@eudaptics.com>
References: <200612201309.02119.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 13:30:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34926>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx1WT-0008TT-MB for gcvg-git@gmane.org; Wed, 20 Dec
 2006 14:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965020AbWLTNaN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 08:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWLTNaN
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 08:30:13 -0500
Received: from main.gmane.org ([80.91.229.2]:51792 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S965020AbWLTNaM
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 08:30:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gx1WI-0002RT-Cg for git@vger.kernel.org; Wed, 20 Dec 2006 14:30:06 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 14:30:06 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 20 Dec 2006
 14:30:06 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> +WORKINGTOP=$(git-rev-parse --show-cdup)
> +GITMODULES="${WORKINGTOP}.gitmodules"
> +if [ -f "$GITMODULES" ]; then
> +       cat "$GITMODULES" |

useless-use-of-cat-syndrome

> +       while read subdir hash

Wouldn't it be better to have the order of subdir and hash swapped? That
way subdir may contain blanks, and it gives nicer alignment in the file
because of the constant length of the hashes.

-- Hannes
