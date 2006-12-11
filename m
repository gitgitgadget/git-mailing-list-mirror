X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Mon, 11 Dec 2006 13:13:34 +0100
Message-ID: <200612111313.34292.Josef.Weidendorfer@gmx.de>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <19476830-E30A-42B7-AD9B-4C417D830C8E@mac.com> <457D3573.2010001@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 12:14:06 +0000 (UTC)
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <457D3573.2010001@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33997>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtk2g-0001Cr-KA for gcvg-git@gmane.org; Mon, 11 Dec
 2006 13:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762852AbWLKMNs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 07:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762864AbWLKMNr
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 07:13:47 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:55343 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1762852AbWLKMNr (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 07:13:47 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id E62FD20E9; Mon, 11
 Dec 2006 13:13:45 +0100 (MET)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Monday 11 December 2006 11:39, Andreas Ericsson wrote:
> > Import/export scripts literally require wrapping every single GIT 
> > command with a script that changes directory a few times, reads from a 
> > different checked-out tree, and permutes some extended-attribute data 
> > slightly before storing it in the underlying GIT tree.  Even without 
> > adding any new functionality whatsoever that doubles the amount of code 
> > just for finding your repository and checking command-line arguments, 
> > and that's a crazy trade-off to make in any situation.
> > 
> 
> GIT_DIR=/some/where/else/.git git log -p

Doing this everytime you want to run a git command *is* a lot of time
wasted for typing.

The .gitlink proposal would come in handy here: you have a simple
file instead of .git/, which links to the real repository.

