From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 12:00:52 -0700
Message-ID: <CA+55aFyWTxE0Pc=+i7ZsSbATgEG+gDta6880Bq83wBk1OXTgVQ@mail.gmail.com>
References: <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net> <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
 <CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com> <20110715184211.GH8453@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 15 21:01:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhndy-0004Mo-KC
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293Ab1GOTBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jul 2011 15:01:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38294 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753980Ab1GOTBl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:01:41 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FJ1CES017678
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 12:01:13 -0700
Received: by wwe5 with SMTP id 5so1562631wwe.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 12:01:12 -0700 (PDT)
Received: by 10.216.243.203 with SMTP id k53mr3048336wer.87.1310756472094;
 Fri, 15 Jul 2011 12:01:12 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 12:00:52 -0700 (PDT)
In-Reply-To: <20110715184211.GH8453@thunk.org>
X-Spam-Status: No, hits=-102.888 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177212>

On Fri, Jul 15, 2011 at 11:42 AM, Ted Ts'o <tytso@mit.edu> wrote:
>
> My original main issue was simply that "git tag --contains" and "git
> branch --contains" was either (a) incorrect, or (b) slower than
> popping up gitk and pulling the information out of the GUI. =A0The
> reason for (b) is because of gitk.cache.

With "original issue" I actually meant the case that caused us to add
the "slop" commit (7d004199d1). But I was too lazy to try to find the
archives from March 2008..

                  Linus
