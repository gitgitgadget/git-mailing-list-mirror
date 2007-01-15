From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Mon, 15 Jan 2007 17:58:56 +0100
Message-ID: <877ivo446n.fsf@morpheus.local>
References: <871wm08kcu.fsf@morpheus.local> <7vd55jrj38.fsf@assigned-by-dhcp.cox.net> <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net> <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701131217410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jan 15 23:20:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6aBa-000511-O2
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXAOWUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 Jan 2007 17:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXAOWUL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:20:11 -0500
Received: from main.gmane.org ([80.91.229.2]:51046 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbXAOWUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:20:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H6aBO-0002oT-6m
	for git@vger.kernel.org; Mon, 15 Jan 2007 23:20:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 23:20:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 23:20:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:e6aoAkXFXlQuU59r9tqhV/V7xyk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36893>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 12 Jan 2007, Junio C Hamano wrote:
>
>> Side note.  The previous patch does not help if your commit were
>> made in non UTF-8 with not too recent git; the code assumes that
>> commit messages without the new "encoding" headers are in UTF-8.
>
> Why not just use is_utf8() and warn, or error out, if the message is =
not=20
> UTF-8? (I tend towards the erroring out, since this _is_ a new featur=
e,=20
> and gives undesired results with "old" commits.)

What do you mean? I have an old repository with latin1 commits without
any encoding markers.  I want to be able to use format-patch from that
and at least get a From: line with something readable.  You can't just
barf and say "This isn't UTF-8, go away".

--=20
David K=C3=A5gedal
