X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 11:28:18 +0100
Message-ID: <200611071128.18831.Josef.Weidendorfer@gmx.de>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de> <200611070225.24956.Josef.Weidendorfer@gmx.de> <7vvels6lf4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 10:43:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vvels6lf4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31060>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhOPs-0002T1-HB for gcvg-git@gmane.org; Tue, 07 Nov
 2006 11:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754009AbWKGKmt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 05:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbWKGKmt
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 05:42:49 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:31132 "EHLO
 mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1754009AbWKGKms (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006
 05:42:48 -0500
Received: from dhcp-3s-44.lrr.in.tum.de (dhcp-3s-44.lrr.in.tum.de
 [131.159.35.44]) by mail.in.tum.de (Postfix) with ESMTP id D4F2AAE9; Tue,  7
 Nov 2006 11:41:05 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tuesday 07 November 2006 03:27, Junio C Hamano wrote:
> remotes/origin/next as "next's upstream".  While we are on
> 'next' branch, we might want to refer to "HEAD's upstream".
> 
> I am not sure what the syntax for that should be, though.
> Perhaps "HEAD@upstream"?

I remember an idea floating around was to use a virtual
branch "ORIGIN" which always maps to the upstream of the current
branch.
 
> Unlike the regular extended sha1 expression modifiers such as
> name~n, name^n, and name^{type}, it does not work with arbitrary
> object name; it can only work with a refname.  Which is similar
> to the '@{time}' notation we added when we started using
> ref-log.  Strictly speaking these should not belong to the sha1
> naming layer, but we can have them anyway for the user's
> convenience.

Yes, this makes sense. Branch relations like "upstream" is a
local configuration issue, similar to reflogs.

I vote for "HEAD@up", short form "@up".

