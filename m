From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: 'show' pretty %B without a diff
Date: Mon, 20 Dec 2010 14:12:15 +0300
Organization: '
Message-ID: <20101220111214.GD10354@external.screwed.box>
References: <20101220073842.GC10354@external.screwed.box>
 <7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 12:12:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUdfU-0003Hm-GQ
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 12:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab0LTLMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 06:12:35 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:50022 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789Ab0LTLMe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 06:12:34 -0500
Received: from localhost (unknown [199.48.147.41])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 248A15A89;
	Mon, 20 Dec 2010 13:54:32 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163992>

Hey Mr(s) Junio show some good to me!
2010/12/20 01:05:17 -0800 Junio C Hamano <gitster@pobox.com> => To Peter Vereshagin :

JCH> > I'd like to output a comment in my script.
JCH> > Thus, I try: 'git show --format="%B" commitId'
JCH> > There is always diff in the end of the output. No matter what format I specify, even when it is empty.
JCH> > How can I avoid diff output in the 'git show'?
JCH> 
JCH> The best answer to "avoid" it would be not to use "git show"; after all
JCH> the command is about showing the change it introduces when it is used on a
JCH> commit.
JCH> 
JCH> Especially if you are doing a script, you probably should be using
JCH> "cat-file commit" anyway, no?

cat-file doesn't seem to support formatting option?
Also, it outputs 4 more unwanted fields than just the %B... used with the -p is
the only what looks like the what I asked. Is it appropriate in a general case
to skip the everything on that output till the first empty line? cause I'm not
sure those are always 4 and not-empty lines.

Thanks anyway, it's just better than nothing. Although I wish the -p for
cat-file to behave like the simlar-minded --pretty of the 'show'. (=

Or the Git.pm just to have a functionality to get the %B of the commit.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
--
http://vereshagin.org
