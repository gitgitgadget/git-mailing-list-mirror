X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 11:53:49 +0100
Message-ID: <20061103105349.GA18651@diana.vm.bytemark.co.uk>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk> <20061103102119.GO20017@pasky.or.cz> <454B1BC3.1070203@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 10:54:17 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <454B1BC3.1070203@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30822>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfwga-0007AD-90 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753210AbWKCKyF convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 05:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbWKCKyF
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:54:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:58637 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1753210AbWKCKyC
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:54:02 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GfwgH-0004v1-00; Fri, 03 Nov 2006 10:53:49 +0000
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On 2006-11-03 11:36:51 +0100, Andreas Ericsson wrote:

> Petr Baudis wrote:
>
> > Dear diary, on Fri, Nov 03, 2006 at 11:01:42AM CET, I got a letter
> > where Karl Hasselstr=F6m <kha@treskal.com> said that...
> >
> > > On 2006-11-03 10:58:59 +0100, Karl Hasselstr=F6m wrote:
> > >
> > > > I believe all the mails I send with mutt are QP-encoded,
> > >
> > > I just checked, and that one certainly was.
> >
> > Are you sure? As far as I can see, it's 8bit.
>
> 8bit here too.

Spooky. When I get copies of my own mails via the git list, they are
QP-encoded; but when I bcc myself directly, I get them in 8bit. But
you all say you get them still 8bit-encoded. I'm not sure I even
_want_ to know what is happening there.

One thing is certain, though: When I sent 8bit-encoded patches from
StGIT to this list, the vger mail server added headers saying that it
didn't like 8bit, and had re-encoded the mail (to what, I don't recall
just now). It warned that in doing so, it had to make assumptions
about the charset used. The assumption it had made was that the text
was latin1, which is not so good when it is in fact utf8.

This all just strengthens my belief that StGIT should go to great
legths to avoid stepping on mail servers' toes.

--=20
Karl Hasselstr=F6m, kha@treskal.com
