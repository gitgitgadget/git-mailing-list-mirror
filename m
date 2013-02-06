From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 09:11:17 +0100
Message-ID: <vpqa9rhaml6.fsf@grenoble-inp.fr>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Michal Nazarewicz <mpn@google.com>,
	git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 09:12:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U306v-0005Xl-3i
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 09:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab3BFILm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 03:11:42 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55605 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab3BFILl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 03:11:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r168BHsr026430
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 09:11:17 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U306A-0000mS-7W; Wed, 06 Feb 2013 09:11:18 +0100
In-Reply-To: <7v6226pdb7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2013 15:10:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Feb 2013 09:11:19 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r168BHsr026430
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360743081.38725@tf3uOH5dXiM65fLMAssubw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215565>

Junio C Hamano <gitster@pobox.com> writes:

> I see a lot of rerolls on the credential helper front, but is there
> anybody working on hooking send-email to the credential framework?

Not answering the question, but git-remote-mediawiki supports the
credential framework. It is written in perl, and the credential support
is rather cleanly written and doesn't have dependencies on the wiki
part, so the way to go for send-email is probably to libify the
credential support in git-remote-mediawiki, and to use it in send-email.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
