From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: GnuPG commit signature verification ignores GPG's status-fd and status-file options
Date: Tue, 9 Apr 2013 17:22:54 +0200
Message-ID: <87vc7vlodt.fsf@linux-k42r.v.cablecom.net>
References: <5164027C.4020007@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Not Sure <kuerzn@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 17:23:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPaNy-00043Z-3U
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 17:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765434Ab3DIPW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 11:22:57 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:31575 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761860Ab3DIPW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 11:22:57 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Apr
 2013 17:22:52 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 9 Apr 2013 17:22:54 +0200
In-Reply-To: <5164027C.4020007@googlemail.com> (Not Sure's message of "Tue, 09
	Apr 2013 13:58:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220577>

Not Sure <kuerzn@googlemail.com> writes:

> Starting with the newest git version 1.8.2.1, the signature checking
[...]
> Missing from output is the machine parsable GPG information:
>
> [GNUPG:] SIG_ID sorvifhoerui/asidunb 2013-04-09 23947273
> [GNUPG:] GOODSIG 433811111111111324 User <usermail>
> [GNUPG:] VALIDSIG ddddddddddddddddddfsjidjfv 2013-04-09 aoidfjidh0 0 4 0
> 1 2 00 oshidvoo444444ddddddddd
> [GNUPG:] TRUST_ULTIMATE

I suspect that's because since b60b756 (gpg-interface: check good
signature in a reliable way, 2013-02-14), Git parses the above output.

Also, in e290c4b (pretty printing: extend %G? to include 'N' and 'U',
2013-03-31) which is currently in master, this was fixed:

> Note: The git-log format specifiers %GG, %G?, %GK, ... do not provide
> enough information

Is anything else missing?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
