From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Whitespace and '&nbsp'
Date: Fri, 27 May 2011 14:14:54 -0700
Message-ID: <BANLkTinwOr5Yzp_N6BNyNK5Y1FcVtdtbUw@mail.gmail.com>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org> <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home> <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
 <7vipswro57.fsf@alter.siamese.dyndns.org> <7vboyorm4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 23:15:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ4Nt-0002HJ-VK
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 23:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab1E0VPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2011 17:15:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36034 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752795Ab1E0VPs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 17:15:48 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4RLFEWP031395
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 27 May 2011 14:15:15 -0700
Received: by wwa36 with SMTP id 36so2237303wwa.1
        for <git@vger.kernel.org>; Fri, 27 May 2011 14:15:14 -0700 (PDT)
Received: by 10.216.237.224 with SMTP id y74mr126242weq.73.1306530914117; Fri,
 27 May 2011 14:15:14 -0700 (PDT)
Received: by 10.216.170.132 with HTTP; Fri, 27 May 2011 14:14:54 -0700 (PDT)
In-Reply-To: <7vboyorm4i.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-102.958 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174648>

On Fri, May 27, 2011 at 12:15 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> The "diff" side would look like this. =A0I am tempted to change all t=
he
> "char *line" to "unsigned char *line", before updating "apply", thoug=
h...

Without actually testing it, it looks reasonable.

I do wonder whether the highlighting might be something that is
independent of whitespace issues. What about mis-formed or
non-printable characters? Right now we depend on "less" doing the
right thing, but I can make "git diff" generate random escape
sequences etc by just putting them in the file, so if I do
GIT_PAGER=3Dcat I can make "git diff" really mess up my terminal if I
wanted to.

Again, I'm not convinced git should really care, but I'm also not
convinced that sbsp is necessarily all about the git whitespace
fixups.

                     Linus
