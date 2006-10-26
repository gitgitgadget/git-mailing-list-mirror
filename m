X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] New stg command: assimilate
Date: Thu, 26 Oct 2006 10:32:36 +0200
Message-ID: <20061026083236.GA13780@diana.vm.bytemark.co.uk>
References: <20061022130559.17015.51385.stgit@localhost> <20061022130802.17015.50188.stgit@localhost> <20061025163231.GA30478@diana.vm.bytemark.co.uk> <b0943d9e0610250941jfd5d11fk467ab586773ba205@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 08:32:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0610250941jfd5d11fk467ab586773ba205@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30151>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0fT-0000Xz-T7 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965239AbWJZIcj convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 04:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWJZIcj
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:32:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:9228 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S965239AbWJZIcj
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:32:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gd0fE-0003ae-00; Thu, 26 Oct 2006 09:32:36 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-10-25 17:41:50 +0100, Catalin Marinas wrote:

> On 25/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > I just realized, by means of an infinite loop, that "patchname"
> > should be replaced with just "name" in the body of this function.
> > Would you like me to resend the patch?
>
> I can do it, no need to resend. I'll push the patch tonight and you
> can check it (I also fixed the "reversed" call as it is not
> available in my Python implementation).

Aahh, I avoided using set() (and had to settle for a decidedly less
elegant dict-with-arbitrary-values) precisely so that the code
wouldn't require Python 2.4, but reversed() is also a new feature of
2.4.

--=20
Karl Hasselstr=F6m, kha@treskal.com
