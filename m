From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: More precise tag following
Date: Wed, 31 Jan 2007 21:59:06 +0100
Message-ID: <87abzyzzdx.fsf@morpheus.local>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org> <87bqkf1tey.fsf@morpheus.local> <m3abzz6upz.fsf@localhost.localdomain> <87y7nj161j.fsf@morpheus.local> <m364an6rxp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 22:00:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCMYm-0004Bq-QQ
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 22:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbXAaVAA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 16:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbXAaVAA
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 16:00:00 -0500
Received: from main.gmane.org ([80.91.229.2]:59013 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030571AbXAaU77 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 15:59:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCMYE-00067U-Jz
	for git@vger.kernel.org; Wed, 31 Jan 2007 21:59:30 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 21:59:30 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 21:59:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:fgEXN4vRu9J5i+UbIzZs6Ox+7/A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38297>

Peter Eriksen <s022018@student.dtu.dk> writes:

> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> Peter Eriksen <s022018@student.dtu.dk> writes:
>>=20
>> > David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>> >
>> >> Usage instructions:  Open a file and type M-x git-blame-mode
>> >>=20
>> >> ;;; git-blame.el
>> >
>> > I saved the elisp code in a file .emacs.d/git-blame.el, and loaded=
 it
>> > with M-x load-file.  Then I visited git/cache.h, and typed M-x
>> > git-blame-mode, but the background colours did not change.  What d=
id I
>> > forget to do?
>>=20
>> Probably you forgot to use the latest version :-)
>>=20
>> See my mail with the subject line "git-blame.el".
>
> I saw that mail just after I responded.  The newest version does not
> work either, that is, it does not work in the same way, as the old
> version.  Closing Emacs I can see, that Emacs did fork of "git blame"
> processes.  So it is just the colours, I cannot see.

I think it requires GNU Emacs 21.  If you'are using Emacs 20, try
changing this:

            (overlay-put ovl 'face (list :background
                                         (cdr (assq 'color (cddddr info=
)))))

to

            (overlay-put ovl 'face (cons 'background-color
                                         (cdr (assq 'color (cddddr info=
)))))


--=20
David K=C3=A5gedal
