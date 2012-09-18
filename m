From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH/RFC] Port to HP NonStop
Date: Tue, 18 Sep 2012 10:11:34 +0200
Message-ID: <000401cd9575$38a98b40$a9fca1c0$@schmitz-digital.de>
References: <000201cd9569$d16515e0$742f41a0$@schmitz-digital.de> <7vvcfbojbl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDsuZ-0001hG-2O
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 10:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615Ab2IRILx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 04:11:53 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:49843 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411Ab2IRILu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 04:11:50 -0400
Received: from DualCore (dsdf-4d0a151d.pool.mediaWays.net [77.10.21.29])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MH3Pq-1TIoru205C-00DKCi; Tue, 18 Sep 2012 10:11:48 +0200
In-Reply-To: <7vvcfbojbl.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIRcf9f0L091TtL1apGSHAm+T2aRAItWLL2lvaa+eA=
Content-Language: de
X-Provags-ID: V02:K0:OH8BmHAcnUD8113/4Xolq0YEnoM+MonbETJZPSgwTFP
 qx8YTRnc5hRzPRBJTriwGiPkfx69Krab8osSMzaeRl0uZD8JqC
 +ixY9iP0h5OnH3e0mPejG0Dqb9YvGemZ1QRrQCDGxQr043Pt3S
 mJrWKs6Yc0ejl8fhEbtfK+w96wm3GFdIIB1oVi6Yz8eR/yWj49
 rdp7xf0gfn/vOk204ndEM8suH0yaYDiquKkbKCu71jKjqiUL5I
 R3/DWMO1FpvfU4nKgB+oPBwvVzdCxaEjv1tw7KU5lIoA09iyGl
 3kl2oL6ckdveAmAbZd2f3vfEKpeeE9jgzBrgf3RD/fLaLWQD5x
 2i3jr6aTt/ACPu2cFQMX4gfSEPJnDgFXsgNrTvT+1x7eqCnrlp
 mKsxYcbogKCsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205811>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 18, 2012 9:57 AM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH/RFC] Port to HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Needs a different link order in Makefile: libintl before libiconv.
> > This may affect other platforms, so needs some checking.
> 
> It will, and it needs customization, not checking.

How?

> > Also I'm not really sure how to best #ifdef the #include <strings.h>
> > and the typedef (u)intptr_t.
> 
> For now, nobody needs these, so enclosing in TANDEM is fine. When
> another platform is found to need the same change, which might be
> unlikely, new symbols that NONSTOP_KERNEL and that other platform
> share can be introduced to replace these #ifdefs.

OK, I'm fine with that. So the git-compat-util.h part of my patch can go in as posted, right?
With or without the comments?

Bye, Jojo
