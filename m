From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 18:01:31 +0200
Message-ID: <vpqsjni6kkk.fsf@bauges.imag.fr>
References: <1316960136073-6829212.post@n2.nabble.com>
	<1316961212.4388.5.camel@centaur.lab.cmartin.tk>
	<7vaa9r2jii.fsf@alter.siamese.dyndns.org>
	<1317073309.5579.9.camel@centaur.lab.cmartin.tk>
	<vpq39fi9gf5.fsf@bauges.imag.fr>
	<69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 18:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8a6U-0001gm-Ls
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 18:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175Ab1I0QBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 12:01:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43774 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940Ab1I0QBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 12:01:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p8RFxWLX011099
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2011 17:59:32 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8a67-0006kH-Sn; Tue, 27 Sep 2011 18:01:31 +0200
In-Reply-To: <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com> (Michael
	Witten's message of "Tue, 27 Sep 2011 15:46:22 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 27 Sep 2011 17:59:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8RFxWLX011099
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317743976.06891@n3mzUp2XkAyF/0L65DyLAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182246>

Michael Witten <mfwitten@gmail.com> writes:

> -This can be useful when you want to publish the tree from a commit
> -without exposing its full history. You might want to do this to publish
> -an open source branch of a project whose current tree is "clean", but
> -whose full history contains proprietary or otherwise encumbered bits of
> -code.

This part used to be just this in v1:

-This can be useful when you want to publish the tree from a commit
-without exposing its full history. You might want to do this to publish
+This can be useful when you want to publish a tree without exposing its
+full history; for instance, you might want to do this to publish
 an open source branch of a project whose current tree is "clean", but
 whose full history contains proprietary or otherwise encumbered bits of
 code.

is it intentionnal that you discarded completely the paragraph? If so,
then I disagree, the paragraph was one of the main motivation for
someone to use --orphan, without it, someone may understand _what_ it
does, but not _why_ it is useful.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
