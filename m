From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2] Revamp git-cherry(1)
Date: Fri, 22 Nov 2013 20:37:14 +0100
Message-ID: <87li0gi5xx.fsf@linux-k42r.v.cablecom.net>
References: <xmqqli0h4kvj.fsf@gitster.dls.corp.google.com>
	<dde93c10b7f6cb7b8cf94e9a0310c8e05aca2517.1385137650.git.tr@thomasrast.ch>
	<xmqqa9gw1bne.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, a.huemer@commend.com,
	"Michael S. Tsirkin" <mst@kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 20:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjwXw-0008Op-FU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 20:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab3KVThe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 14:37:34 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:50334 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771Ab3KVThd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 14:37:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 1E9224D6580;
	Fri, 22 Nov 2013 20:37:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WYv3V_ETawNC; Fri, 22 Nov 2013 20:37:21 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [89.204.155.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 5AFF54D6414;
	Fri, 22 Nov 2013 20:37:20 +0100 (CET)
In-Reply-To: <xmqqa9gw1bne.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 22 Nov 2013 11:25:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238207>

Junio C Hamano <gitster@pobox.com> writes:

> We are listing those that need to be added to the upstream with "+",
> while listing those that can be dropped from yours if you rebase
> with "-".  Hinting the rationale behind the choice of "+/-"
> somewhere may help as a mnemonic to the readers (see below).
[...]
> And the earlier "why +/-" could be done after this picture,
> perhaps like:
>
> 	Here, we see that the commits A and C (marked with `-`) can
> 	be dropped from your `topic` branch when you rebase it on
> 	top of `origin/master`, while the commit B (marked with `+`)
> 	still needs to be kept so that it will be sent to be applied
> 	to `origin/master`.
>
> or somesuch?

Good idea, thanks.  Will integrate this more "what still needs to be
integrated"-minded wording into a v3.

-- 
Thomas Rast
tr@thomasrast.ch
