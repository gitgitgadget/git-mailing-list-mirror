From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: added possibility to supply more than one --listen argument to git-daemon
Date: Mon, 23 Aug 2010 18:54:34 +0200
Message-ID: <1282582475-3545-1-git-send-email-alexander@sulfrian.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 18:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnaIW-00033T-AG
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 18:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab0HWQyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 12:54:54 -0400
Received: from animux.de ([78.46.93.45]:47638 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab0HWQyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 12:54:53 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id E3232829AF62; Mon, 23 Aug 2010 18:54:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr2 (2008-06-10) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.5-gr2
Received: from laptop (unknown [93.214.40.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 383D2829AF60;
	Mon, 23 Aug 2010 16:54:50 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Mon, 23 Aug 2010 18:54:48 +0200
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154237>

Hi list,

I have written a patch to allow more than one --listen argument to the
git daemon. The current situation is, that the daemon silently ignores
all --listen arguments beside the last one. So there is no possibility
to let on server listen on many addresses without let it bind to all.

Even if that is currently not a problem with ipv4 addresses, in the
future that problem gets even worse. I wanted git-daemon to listen on
an ipv4 address and an ipv6 address. That is currently not possible
without running two instances. So I created that patch.

I already send this patch as [PATCH/RFC] to the list earlier. But
because nobody has send any reply yet, I am resending it as [PATCH]
ready for inclusion now.

Thanks,
Alex
