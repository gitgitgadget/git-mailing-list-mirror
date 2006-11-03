X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 14:25:46 +0100
Message-ID: <20061103132546.GA21202@diana.vm.bytemark.co.uk>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com> <20061103130259.GA20611@diana.vm.bytemark.co.uk> <b0943d9e0611030516v43a25b76y4c07f82b33411a6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 13:26:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611030516v43a25b76y4c07f82b33411a6e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30849>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfz3Q-00029G-AF for gcvg-git@gmane.org; Fri, 03 Nov
 2006 14:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752977AbWKCNZs convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 08:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbWKCNZs
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 08:25:48 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:22543 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1752977AbWKCNZr
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 08:25:47 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gfz3K-0005Ws-00; Fri, 03 Nov 2006 13:25:46 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-03 13:16:08 +0000, Catalin Marinas wrote:

> On 03/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Or try to use the git plumbing directly, if reasonable. Mail
> > encoding and decoding isn't my idea of fun -- I just want it to
> > not break. And I don't see much point in StGIT replicating core
> > GIT functionality when there's no reason to.
>
> As I said in my reply to Junio, I really like to keep the e-mail
> templates functionality of StGIT. This is not available in
> git-format-patch.

=46air enough. How about e-mail importing -- is there a good reason to
not use the git plumbing there?

--=20
Karl Hasselstr=F6m, kha@treskal.com
