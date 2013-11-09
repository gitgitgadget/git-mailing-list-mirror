From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Sat, 09 Nov 2013 15:24:37 +0100
Message-ID: <87fvr5ps9m.fsf@linux-k42r.v.cablecom.net>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Nov 09 15:24:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf9T7-0006Dg-Dk
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 15:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab3KIOYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 09:24:50 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52417 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966Ab3KIOYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 09:24:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 469064D659C;
	Sat,  9 Nov 2013 15:24:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xeDbpwnB96lP; Sat,  9 Nov 2013 15:24:38 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 8D7D44D6585;
	Sat,  9 Nov 2013 15:24:37 +0100 (CET)
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 09 Nov 2013 08:05:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237577>

Christian Couder <chriscool@tuxfamily.org> writes:

> Christian Couder (86):
>   strbuf: add has_prefix() to be used instead of prefixcmp()
>   diff: replace prefixcmd() with has_prefix()
>   fast-import: replace prefixcmd() with has_prefix()
[...]
>   builtin/update-ref: replace prefixcmd() with has_prefix()
>   builtin/upload-archive: replace prefixcmd() with has_prefix()
>   strbuf: remove prefixcmp() as it has been replaced with has_prefix()

All of your subjects except for the first and last say "prefixcm*d*". :-)

-- 
Thomas Rast
tr@thomasrast.ch
