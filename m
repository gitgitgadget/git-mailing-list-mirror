From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias> --help
Date: Tue, 05 Mar 2013 17:41:07 +0100
Message-ID: <vpqy5e17qak.fsf@grenoble-inp.fr>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com>
	<5136127C.2090402@viscovery.net>
	<20130305165453.6077226c@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r?= =?iso-8859-1?Q?=F0?= Bjarmason 
	<avarab@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCv8n-0000O7-8G
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab3CEQyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 11:54:35 -0500
Received: from mx2.imag.fr ([129.88.30.17]:56523 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291Ab3CEQyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 11:54:35 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r25Gf56Z015237
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Mar 2013 17:41:05 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UCuvL-0001sQ-Gh; Tue, 05 Mar 2013 17:41:07 +0100
In-Reply-To: <20130305165453.6077226c@pc09.procura.nl> (H. Merijn Brand's
	message of "Tue, 5 Mar 2013 16:54:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Mar 2013 17:41:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r25Gf56Z015237
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363106468.00215@msPxk+3tmbE4kQiH3+6MSA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217464>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> A single word that is (already) known to git as being a valid command
> to do --help with. I which case I fully agree.

Just to insist on "that is known to git as being a valid command".

Compare:

$ git foo --help
`git foo' is aliased to `bar'

with

$ git foo --help
No manual entry for gitbar

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
