X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Mon, 11 Dec 2006 11:47:44 +0100
Message-ID: <200612111147.44964.Josef.Weidendorfer@gmx.de>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com> <7vd56s8t9w.fsf@assigned-by-dhcp.cox.net> <7vslfm23co.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 10:48:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vslfm23co.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33990>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtihU-0008G9-VF for gcvg-git@gmane.org; Mon, 11 Dec
 2006 11:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762777AbWLKKr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 05:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762778AbWLKKr6
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 05:47:58 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:54264 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1762777AbWLKKr5 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 05:47:57 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 15FE82138; Mon, 11
 Dec 2006 11:47:56 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Monday 11 December 2006 10:23, Junio C Hamano wrote:
> A script to be driven when the user says "git add --interactive"
> is introduced.

Cool.
Just allowing to unstage files this way makes me happy, thanks.

I just tried to work with this thing to separate my recent
"branch.*.localmerge" changes to the simple version I posted
afterwards.

I noted that I need to manually change a few dependent hunks,
so this "one hunk at a time" and not being able to edit changes
in a hunk does not fit my workflow.
Just as a sidenote: after deciding to not apply hunks, you
lose them in this WIP, as you will find nothing in "unstaged" mode
afterwards :-(

Despite not having a patch for it right now, it would work out
better for me to open the editor with the patch for one
file, and allow to edit it to *replace* the staged version.

Neverless, thanks for this WIP,
