X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Tue, 28 Nov 2006 14:00:36 +0100
Message-ID: <200611281400.37191.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 13:01:06 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32519>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp2Zq-00043x-7I for gcvg-git@gmane.org; Tue, 28 Nov
 2006 14:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755972AbWK1NAl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756991AbWK1NAk
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 08:00:40 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:4768 "EHLO
 mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1755972AbWK1NAk (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006
 08:00:40 -0500
Received: from dhcp-3s-45.lrr.in.tum.de (dhcp-3s-45.lrr.in.tum.de
 [131.159.35.45]) by mail.in.tum.de (Postfix) with ESMTP id D34B92236; Tue, 28
 Nov 2006 14:00:38 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tuesday 28 November 2006 07:59, Junio C Hamano wrote:
> Once I am done, I can ask "git diff" and expect it to show my
> local changes I have no intention of committing for now
> ...
> 
> And at that point, I trust "git commit" to do the right thing --
> the damn thing I just checked with "git diff --cached" _is_ what
> will be committed.

I think the difference behavior between "git commit" and "git diff" is
a little bit confusing.

Currently, we have
* "git diff" shows what "git commit -a" would commit
* "git diff --cached" shows what "git commit" would commit

IMHO, "git diff" should show what's in the staging area,
and we should introduce "git diff -a" as a way to see the full
changes.

