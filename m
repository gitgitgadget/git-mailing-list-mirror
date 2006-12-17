X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Subprojects tasks
Date: Mon, 18 Dec 2006 00:27:25 +0100
Message-ID: <200612180027.25308.Josef.Weidendorfer@gmx.de>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612171529.03165.jnareb@gmail.com> <20061217195417.GI12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 23:27:48 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <20061217195417.GI12411@admingilde.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34712>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw5Py-0002zt-24 for gcvg-git@gmane.org; Mon, 18 Dec
 2006 00:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753220AbWLQX1j (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 18:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbWLQX1i
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 18:27:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:38697 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753220AbWLQX1i
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 18:27:38 -0500
Received: (qmail invoked by alias); 17 Dec 2006 23:27:36 -0000
Received: from p549680A1.dip0.t-ipconnect.de (EHLO noname) [84.150.128.161]
 by mail.gmx.net (mp004) with SMTP; 18 Dec 2006 00:27:36 +0100
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Sunday 17 December 2006 20:54, Martin Waitz wrote:
> I added a symlink .git/refs/module/<submodule> -> <submodule>/.git/refs,
> so that the submodule branch is also available as
> refs/module/<submodule>/heads/master in the supermodule.

Ah.
What is "<submodule>" in your implementation?
Is this some encoding of the path where the submodule currently lives
in the supermodule, or are you giving the submodules unique names
in the context of the supermodule?

