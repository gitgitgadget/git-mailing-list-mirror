From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Thu, 18 Jun 2015 09:00:16 +0200
Message-ID: <vpqioalfqm7.fsf@anie.imag.fr>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
	<vpqtwu6sf4r.fsf@anie.imag.fr>
	<xmqqoake4akt.fsf@gitster.dls.corp.google.com>
	<xmqqd20u48at.fsf@gitster.dls.corp.google.com>
	<5581A3A3.1070908@web.de> <vpqh9q6gsdt.fsf@anie.imag.fr>
	<xmqqpp4u6swo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	"Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 09:00:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ToO-0005x4-MV
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 09:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbbFRHA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 03:00:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51567 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbbFRHA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 03:00:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5I70FZt017447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2015 09:00:15 +0200
Received: from anie.imag.fr (ensi-vpn-247.imag.fr [129.88.57.247])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5I70Gs9023922;
	Thu, 18 Jun 2015 09:00:16 +0200
In-Reply-To: <xmqqpp4u6swo.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 17 Jun 2015 12:23:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 18 Jun 2015 09:00:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5I70FZt017447
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435215616.91472@ypCOUYUr1qOKnT9twHD4uw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271935>

Junio C Hamano <gitster@pobox.com> writes:

> I think "restore" also by definition has to go back to _some_
> existing version, not a future yet-to-be-created one, so "restore to
> some previous state" is superfluous;

That's why I found "restore recorded state" not too bad.

> "restore working tree files"

Not a native, but to me "restore file" sounds like "the file is damaged,
it needs to be restored/repaired".

In any case,

  Switch branches or restore working tree files

is an improvement over the existing to me, so my bikeshedding should not
be used to reject this proposal.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
