From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] diff: don't run pager if user asked for a diff style exit code
Date: Mon, 13 Aug 2007 12:23:16 +0200
Message-ID: <86d4xrka23.fsf@lola.quinscape.zz>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com> <46BF478F.7030603@lsrfire.ath.cx> <13516449-DEDB-41A1-8880-42CB124A6C0A@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 12:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKX6B-0005rr-B2
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 12:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938099AbXHMKXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Aug 2007 06:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938071AbXHMKXh
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 06:23:37 -0400
Received: from main.gmane.org ([80.91.229.2]:48998 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937809AbXHMKXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 06:23:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IKX50-0001Hx-Gq
	for git@vger.kernel.org; Mon, 13 Aug 2007 12:23:22 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 12:23:22 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 12:23:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:XyPasfUjyxMv62QZJIqXvHeQrf8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55757>

Wincent Colaiuta <win@wincent.com> writes:

> El 12/8/2007, a las 19:46, Ren=E9 Scharfe escribi=F3:
>
>> Push pager setup down into builtin-diff.c and don't start the pager
>> if --exit-code or --quiet (which implies --exit-code) was specified.
>
> Great stuff, Ren=E9. The change looks much simpler than I thought it =
=20
> would.

Personally, I'd start the pager only when the first diff or stat gets
output, anyway.  For a summary message or even a silent exit, a pager
is annoying, regardless of whether --exit-code was specified.

--=20
David Kastrup
