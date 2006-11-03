X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 12:35:36 +0100
Message-ID: <20061103113536.GA19382@diana.vm.bytemark.co.uk>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <20061103100142.GD16721@diana.vm.bytemark.co.uk> <20061103102119.GO20017@pasky.or.cz> <454B1BC3.1070203@op5.se> <20061103105349.GA18651@diana.vm.bytemark.co.uk> <7vslh0bwsm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 11:36:47 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vslh0bwsm.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30829>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfxLc-0000w8-W1 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 12:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753233AbWKCLft convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 06:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbWKCLft
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 06:35:49 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:21006 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1753233AbWKCLfs
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 06:35:48 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GfxKj-00056I-00; Fri, 03 Nov 2006 11:35:37 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 2006-11-03 03:21:29 -0800, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > This all just strengthens my belief that StGIT should go to great
> > legths to avoid stepping on mail servers' toes.
>
> I wonder if this can be solved by simply reusing the machinery
> format-patch already has. If calling it as a standalone script does
> more unnecessary things than what StGIT wants, we should certainly
> be able to separate the only necessary part out to suit StGIT's
> needs.

Yes, I agree. Mail code tends to not be so beautiful that you want to
maintain more copies of it than absolutely necessary.

Of course, the same reasoning applies when importing mails into stgit.

--=20
Karl Hasselstr=F6m, kha@treskal.com
