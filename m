From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 14:23:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808271420210.3363@nehalem.linux-foundation.org>
References: <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org>
 <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net> <20080826210631.GC3812@1wt.eu> <48B5B7F3.4080803@pobox.com> <20080827202707.GA25233@coredump.intra.peff.net>
 <48B5BB35.8090606@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYSX5-0002hF-5t
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYH0VZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbYH0VZV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:25:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35028 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752549AbYH0VZU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 17:25:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7RLNPtB019037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Aug 2008 14:23:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7RLNORx023189;
	Wed, 27 Aug 2008 14:23:25 -0700
In-Reply-To: <48B5BB35.8090606@pobox.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.929 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93956>



On Wed, 27 Aug 2008, Jeff Garzik wrote:
> 
> I use it to spit out a patch for a specific commit:
> 
> 	git-diff-tree -p $COMMIT

Use

	git show $COMMIT

instead, which is shorter and gives you the log too, and uses a pager by 
default. And defaults to HEAD, so you don't even need to say $COMMIT if 
you want to see the top one. IOW, much nicer is so many ways.

Yeah, the "much nicer" obviously does mean "different". If you _rely_ on 
the fact that you don't get a pager (you just want to scroll youself), or 
you really don't want to see what the commit message was all about, then 
'git diff-tree' is obviously "better".

But at least personally, I really don't know when I last wanted to have 
anything else than 'git show' for showing a commit.

			Linus
