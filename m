From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Mon, 07 Sep 2009 10:06:36 +0200
Message-ID: <vpq4orfgovn.fsf@bauges.imag.fr>
References: <20090902080305.GA11549@neumann>
	<20090902081917.GA5447@coredump.intra.peff.net>
	<20090904070216.GA3996@darc.dnsalias.org>
	<20090905061804.GB29863@coredump.intra.peff.net>
	<7v8wgt98ms.fsf@alter.siamese.dyndns.org>
	<20090905084641.GA24865@darc.dnsalias.org>
	<vpqfxb0s177.fsf@bauges.imag.fr> <20090906181621.GA23412@localhost>
	<vpqpra3p92g.fsf@bauges.imag.fr> <20090907073322.GA6021@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:07:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZGM-00072z-Q9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbZIGIHf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 04:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbZIGIHc
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:07:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59228 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbZIGIHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:07:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8784G2H000670
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Sep 2009 10:04:16 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MkZFE-0006lF-TD; Mon, 07 Sep 2009 10:06:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MkZFE-0007a0-Re; Mon, 07 Sep 2009 10:06:36 +0200
In-Reply-To: <20090907073322.GA6021@neumann> ("SZEDER =?iso-8859-1?Q?G=E1b?=
 =?iso-8859-1?Q?or=22's?= message of "Mon\, 7 Sep 2009 09\:33\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Sep 2009 10:04:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8784G2H000670
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252915457.87825@EUo+PbMTKVnqopyipzSl1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127898>

SZEDER G=E1bor <szeder@ira.uka.de> writes:

>> I don't have particular feeling about "git grep", probably because I
>> don't use it much. One argument in favour of keeping the current
>> behavior is the consistancy with plain "grep".
>
> I'm not sure how important should be the consistency with plain grep
> in this case.  After all, plain grep does not work without pathspec a=
t
> all

Yes, right, forget what I wrote, except the "I don't have particular
feeling about 'git grep'" part ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
