From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 02 Oct 2007 10:01:25 +0200
Message-ID: <878x6mc5d6.fsf@morpheus.local>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <7v3awunjup.fsf@gitster.siamese.dyndns.org> <49137EAF-BB73-40DC-973C-E60C14B3FA7F@zib.de> <vpq641qroae.fsf@bauges.imag.fr> <7vlkamm16s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 10:02:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iccha-0004IM-PN
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 10:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbXJBIBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 04:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbXJBIBu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 04:01:50 -0400
Received: from main.gmane.org ([80.91.229.2]:37741 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590AbXJBIBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 04:01:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IcchC-00031n-2V
	for git@vger.kernel.org; Tue, 02 Oct 2007 08:01:34 +0000
Received: from c83-253-242-75.bredband.comhem.se ([83.253.242.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 08:01:34 +0000
Received: from davidk by c83-253-242-75.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 08:01:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-242-75.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:DfayfOT6JKlEypq4NVpbfbmm1zw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59671>

Junio C Hamano <gitster@pobox.com> writes:

>  * not to do the autostash, but fail as we have always done,
>    when "git rebase base other" form was used, first instructing
>    rebase to switch to another branch;

I don't like the idea of automatic stashing on a rebase.  It makes it
harder to understand what is happening, and figuring out were things
went if everything wasn't successful.

--=20
David K=C3=A5gedal
