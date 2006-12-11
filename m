X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 10:26:22 +0100
Message-ID: <200612111026.23656.Josef.Weidendorfer@gmx.de>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org> <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 09:26:41 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33984>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GthQl-0006aS-00 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 10:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762667AbWLKJ0g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 04:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762671AbWLKJ0g
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 04:26:36 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:53289 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1762667AbWLKJ0f (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 04:26:35 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id E7B872138; Mon, 11
 Dec 2006 10:26:33 +0100 (MET)
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

On Monday 11 December 2006 01:15, Marco Costalba wrote:
> 		guiUpdateTimer.start(100, true);

What is the result with	"guiUpdateTimer.start(0, true);" ?
There is no need to put in any time interval at all, because
the timeout is a normal event which will be queued in the GUI
event queue.

If there were X events in the mean time, they are queued and handled
before your timeOut function is called again. So the GUI will be
responsive, even if you have a 0 ms timer. 

