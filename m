X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 14:02:59 +0100
Message-ID: <20061103130259.GA20611@diana.vm.bytemark.co.uk>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 13:03:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30846>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfyhe-00058T-6f for gcvg-git@gmane.org; Fri, 03 Nov
 2006 14:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752807AbWKCNDE convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 08:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbWKCNDE
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 08:03:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3343 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1752807AbWKCNDB
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 08:03:01 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GfyhH-0005OZ-00; Fri, 03 Nov 2006 13:02:59 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-03 12:44:48 +0000, Catalin Marinas wrote:

> On 03/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Are you sure? Wouldn't it be better to teach StGIT to eat
> > QP-encoded mails, and use 7bit encoding when the patch is all
> > ascii? (And still have an option to force 8bit instead of QP if
> > desired, of course.)
>
> Well, I don't have any strong opinion here, as long as QP is more
> widely available. My impression with Gnus was that it cannot handle
> but I think there was an encoding problem.

Most probably, yes. Not supporting QP would count as a serious
deficiency in an e-mail client.

> The initial mail command implementation was inspired from
> sendpatchset but we should probably now use the email Python package
> and let it handle the encoding and decoding (for import).

Or try to use the git plumbing directly, if reasonable. Mail encoding
and decoding isn't my idea of fun -- I just want it to not break. And
I don't see much point in StGIT replicating core GIT functionality
when there's no reason to.

--=20
Karl Hasselstr=F6m, kha@treskal.com
