X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 10:58:59 +0100
Message-ID: <20061103095859.GC16721@diana.vm.bytemark.co.uk>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 09:59:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30810>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfvpR-000377-BF for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752789AbWKCJ7E convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 04:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbWKCJ7D
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:59:03 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:22797 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1752789AbWKCJ7B
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 04:59:01 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GfvpD-0004gW-00; Fri, 03 Nov 2006 09:58:59 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-03 09:39:57 +0000, Catalin Marinas wrote:

> On 02/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > That Gnus shows =3D20 suggests that I haven't got the QP encoding
> > 100% right. I haven't had time to look at that yet, and it looks
> > like you may beat me to it.
>
> Well, it might be just the way I read the list (via the gmane news
> gateway) but I have to run some tests.

I believe all the mails I send with mutt are QP-encoded, and they
don't look funny, do they? (You'd see the separator just above my
signature as "--=3D20" if that was the case; it has a trailing
whitespace.)

> However, I'd like the message body to still be 8bit and the QP
> encoding optional (either command line option or [stgit] config
> variable).

Are you sure? Wouldn't it be better to teach StGIT to eat QP-encoded
mails, and use 7bit encoding when the patch is all ascii? (And still
have an option to force 8bit instead of QP if desired, of course.)

I'm really not comfortable with assuming all mail servers are 8-bit
clean, when they're evidently not. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
