From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 18:53:25 +0200
Message-ID: <vpq8vpa2agq.fsf@bauges.imag.fr>
References: <1316960136073-6829212.post@n2.nabble.com>
	<1316961212.4388.5.camel@centaur.lab.cmartin.tk>
	<7vaa9r2jii.fsf@alter.siamese.dyndns.org>
	<1317073309.5579.9.camel@centaur.lab.cmartin.tk>
	<vpq39fi9gf5.fsf@bauges.imag.fr>
	<69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
	<vpqsjni6kkk.fsf@bauges.imag.fr>
	<CAMOZ1Buf5KxbN59o8QK_dMmF_SEY_Ckuz4DALorZpwuL9gx-Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 18:53:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8auj-00005z-T4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 18:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701Ab1I0Qxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 12:53:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40074 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab1I0Qxo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 12:53:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8RGpGe2027849
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2011 18:51:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8auL-0007ZR-LZ; Tue, 27 Sep 2011 18:53:25 +0200
In-Reply-To: <CAMOZ1Buf5KxbN59o8QK_dMmF_SEY_Ckuz4DALorZpwuL9gx-Pg@mail.gmail.com>
	(Michael Witten's message of "Tue, 27 Sep 2011 16:13:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Sep 2011 18:51:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8RGpGe2027849
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317747079.06503@F7nj8fBMF2FznJhEZz+/vg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182250>

Michael Witten <mfwitten@gmail.com> writes:

> I think that the last paragraph provides enough context to understand
> its usefulness.

The last paragraph tells the user how to commit something different from
what is already here, which is pretty much the opposite.

IOW, I see two uses for --orphan:

1) Publish the same tree without its history

2) Start a different project, but for some reason you wanted it to leave
   in the same repository and you didn't want a "git init".

The next paragraph documents 2), but your removed paragraph was
documenting 1). Reading the new version, it feels like the user is
encourraged to modify the index, while it's just an option.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
