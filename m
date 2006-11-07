X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 11:18:27 +0100
Message-ID: <200611071118.28302.Josef.Weidendorfer@gmx.de>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de> <7vd5809fnh.fsf@assigned-by-dhcp.cox.net> <7v7iy89ffs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 11:54:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <7v7iy89ffs.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31064>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhPX4-0007CX-Gt for gcvg-git@gmane.org; Tue, 07 Nov
 2006 12:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754201AbWKGLyO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 06:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbWKGLyO
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 06:54:14 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:5338 "EHLO
 tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1754201AbWKGLyO (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006
 06:54:14 -0500
Received: from dhcp-3s-44.lrr.in.tum.de (dhcp-3s-44.lrr.in.tum.de
 [131.159.35.44]) by mail.in.tum.de (Postfix) with ESMTP id 7DCAE2703; Tue,  7
 Nov 2006 11:31:15 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tuesday 07 November 2006 03:08, you wrote:
> I do not think we want a _new_ command.  It may make sense to
> enrich 'git-branch' for that.

I agree.

Probably similar, git-clone should use git-checkout at the end.

> If "git-checkout -b" does not use 'git-branch' to create a new
> branch in the current code, maybe we should, regardless of the
> usability enhancements under discussion.

Yes.

Josef

PS: This is one of the moments I wished git-branch still was a shell
