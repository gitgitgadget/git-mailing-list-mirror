From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 12:06:08 -0700
Message-ID: <CA+55aFzsZ6w_a_wPEuBjtDeSDYQviVfy9UmJMxPz4geu4CRthQ@mail.gmail.com>
References: <20110721202722.3765.qmail@science.horizon.com>
 <alpine.LFD.2.00.1107220907370.1762@xanadu.home> <alpine.DEB.2.02.1107221102180.6496@asgard.lang.hm>
 <201107222034.20510.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 21:07:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkL3w-0008BA-6E
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 21:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab1GVTG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jul 2011 15:06:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56683 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753504Ab1GVTG6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 15:06:58 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6MJ6SPA010761
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 22 Jul 2011 12:06:29 -0700
Received: by wwe5 with SMTP id 5so2473044wwe.1
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 12:06:28 -0700 (PDT)
Received: by 10.216.63.17 with SMTP id z17mr2047332wec.98.1311361588077; Fri,
 22 Jul 2011 12:06:28 -0700 (PDT)
Received: by 10.216.155.204 with HTTP; Fri, 22 Jul 2011 12:06:08 -0700 (PDT)
In-Reply-To: <201107222034.20510.jnareb@gmail.com>
X-Spam-Status: No, hits=-102.981 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177656>

On Fri, Jul 22, 2011 at 11:34 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>
> That is IF unknown headers are copied verbatim during rebase. =A0For
> "encoding" header this is a good thing, for "generation" it isn't.

Afaik, they aren't copied verbatim, and never have been. Afaik, the
only thing that has *ever* written commits is "commit_tree()"
(originally "main()" in commit-tree.c). Why is this red herring even
being discussed?

Of course you can always generate bogus commits by writing them by
hand. But that's irrelevant.

                     Linus
