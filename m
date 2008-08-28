From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 09:37:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org> <7v63pmkozh.fsf@gitster.siamese.dyndns.org> <1219907659.7107.230.camel@pmac.infradead.org>
 <7vtzd5fta0.fsf@gitster.siamese.dyndns.org> <1219912327.7107.245.camel@pmac.infradead.org> <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com> <20080828115408.GA30834@hera.kernel.org> <94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com>
 <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Al Viro <viro@hera.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 18:41:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYkXc-0000Vf-CX
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 18:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYH1QjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 12:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbYH1QjG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 12:39:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33845 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753138AbYH1QjF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 12:39:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7SGbL47027073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 09:37:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7SGbKww002706;
	Thu, 28 Aug 2008 09:37:20 -0700
In-Reply-To: <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.927 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94081>



On Thu, 28 Aug 2008, Felipe Contreras wrote:
> 
> If the git-foo was supposed to be deprecated in 1.6.0

Itw as deprecated over a _year_ ago.

> When it becomes truly obsolete, then people can rely on git exec-dir,
> which will be disabled by default.

It _is_ obsolete, but there's a trivial compatibility thing.

Are you happy now? How hard is it to really understand?

		Linus
