X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Tue, 5 Dec 2006 08:41:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612050841160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061111121625.8988.45195.stgit@localhost> 
 <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com> 
 <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com> 
 <20061204153705.GA8644@diana.vm.bytemark.co.uk> 
 <e5bfff550612041034g727a1bebg464f7c523c0fac7f@mail.gmail.com>
 <b0943d9e0612041413p4f303176x3d0fa95afd1c4a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 07:42:06 +0000 (UTC)
Cc: Marco Costalba <mcostalba@gmail.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <b0943d9e0612041413p4f303176x3d0fa95afd1c4a1@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33314>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrUwF-0006MB-CN for gcvg-git@gmane.org; Tue, 05 Dec
 2006 08:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967508AbWLEHmA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 02:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967496AbWLEHmA
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 02:42:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:56687 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S967508AbWLEHl7
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 02:41:59 -0500
Received: (qmail invoked by alias); 05 Dec 2006 07:41:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp017) with SMTP; 05 Dec 2006 08:41:57 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Catalin Marinas wrote:

> I'll first move the message back to stdout.

In other parts of git, the progress message is only printed if output goes 
to a tty. Why not do the same?

Ciao,
Dscho
