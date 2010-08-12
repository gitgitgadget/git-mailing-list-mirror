From: Raja R Harinath <harinath@hurrynot.org>
Subject: case where diff output needs improving? (was Re: [PATCH v2 0/7] tests: use skip_all=* to skip tests)
Date: Thu, 12 Aug 2010 11:52:35 +0530
Message-ID: <87zkwsxsd0.fsf_-_@hariville.hurrynot.org>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
	<1281553450-26467-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 08:30:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjRJ7-0003UM-9f
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 08:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754Ab0HLGaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 02:30:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:58167 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758744Ab0HLGaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 02:30:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OjRIz-0003RG-1W
	for git@vger.kernel.org; Thu, 12 Aug 2010 08:30:21 +0200
Received: from 117.192.132.159 ([117.192.132.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 08:30:21 +0200
Received: from harinath by 117.192.132.159 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 08:30:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.132.159
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:4PaiMWqJFohzVEiEVRz3uyk+9VY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153346>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

[snip]    =20
>     diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
>     index 10e2db3..ab0c2f0 100755
>     --- a/t/t4016-diff-quote.sh
>     +++ b/t/t4016-diff-quote.sh
>     @@ -14 +14 @@ P2=3D'pathname with SP'
>     -if P3=3D'pathname
>     +P3=3D'pathname
>     @@ -16 +16 @@ with LF'
>     -: 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"
>     +if : 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"

Assuming this was from a git invocation, it seems that 'diff' could jus=
t
show line 15 instead of '@@ -16, +16 @@' above.

- Hari
