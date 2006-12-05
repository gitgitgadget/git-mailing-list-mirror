X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Tue, 5 Dec 2006 10:06:08 +0100
Message-ID: <20061205090608.GA25002@diana.vm.bytemark.co.uk>
References: <20061111121625.8988.45195.stgit@localhost> <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com> <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com> <20061204153705.GA8644@diana.vm.bytemark.co.uk> <e5bfff550612041034g727a1bebg464f7c523c0fac7f@mail.gmail.com> <b0943d9e0612041413p4f303176x3d0fa95afd1c4a1@mail.gmail.com> <Pine.LNX.4.63.0612050841160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 5 Dec 2006 09:06:22 +0000 (UTC)
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612050841160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33323>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWFl-0006ty-Dq for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967481AbWLEJGO convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006 04:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967575AbWLEJGO
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:06:14 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2922 "EHLO
 diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S967481AbWLEJGM (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 04:06:12 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GrWFc-0006Ww-00; Tue, 05 Dec 2006 09:06:08 +0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 2006-12-05 08:41:57 +0100, Johannes Schindelin wrote:

> On Mon, 4 Dec 2006, Catalin Marinas wrote:
>
> > I'll first move the message back to stdout.
>
> In other parts of git, the progress message is only printed if
> output goes to a tty. Why not do the same?

That sounds like a good idea for two reasons:

  1. It will address all concerns raised in this thread (I think).

  2. It will remove an unnecessary difference between git and stgit.

--=20
Karl Hasselstr=F6m, kha@treskal.com
