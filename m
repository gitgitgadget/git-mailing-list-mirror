From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: signing tags: user.name assumed to be gpg uid?
Date: Wed, 30 Dec 2009 14:47:21 +0400
Organization: '
Message-ID: <20091230104720.GA3229@screwed.box>
References: <20091229203637.GA3036@screwed.box> <7vaax1bi3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 11:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPw5u-0000do-Nu
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 11:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbZL3Kry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 05:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbZL3Kry
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 05:47:54 -0500
Received: from ns1.skyriver.ru ([89.108.82.27]:53771 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530AbZL3Krx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 05:47:53 -0500
Received: from localhost (tor-exit.eicat.ca [66.96.16.32])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 515B25AB7;
	Wed, 30 Dec 2009 13:41:51 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7vaax1bi3e.fsf@alter.siamese.dyndns.org>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135877>

Oh Junio want you buy me a mersedes benz?
2009/12/29 13:12:05 -0800 Junio C Hamano <gitster@pobox.com> => To Peter Vereshagin :

JCH> > I notice that after I init and config user.name and user.email the
JCH> > user.comment gets taken from ~/.gpg automatically.
JCH> What is "user.comment"?

My probable suggestion about where the gpg key's comment field should be written for config --global. Sorry, it's not from ~/.gnupg

JCH> > Is it a correct behaviour?
JCH> Yes, matching with user.name/user.email (actually committer information)
JCH> is often the most convenient thing to do.

Is it necessary the pgp comment field to be present on the user.name? It isn't for From: in e-mail messages.

JCH> You can use user.signingkey configuration to use a key that doesn't match
JCH> your name, too.

Thanks!

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
