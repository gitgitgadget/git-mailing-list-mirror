From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: [PATCH/RFC] added possibility to supply more than one --listen argument to git-daemon
Date: Tue, 10 Aug 2010 20:56:01 +0200
Message-ID: <1281466562-28105-1-git-send-email-alexander@sulfrian.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:04:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiu7D-0005iZ-Ur
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977Ab0HJTDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 15:03:55 -0400
Received: from animux.de ([78.46.93.45]:44084 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932973Ab0HJTDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:03:53 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2010 15:03:52 EDT
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id EBAC08188EE9; Tue, 10 Aug 2010 20:56:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr2 (2007-05-02) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.1-gr2
Received: from laptop (unknown [93.214.54.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id C884080D1460
	for <git@vger.kernel.org>; Tue, 10 Aug 2010 18:56:07 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Tue, 10 Aug 2010 20:56:06 +0200
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153140>

Hi list,

I have written a patch to allow more than one --listen argument to the
git daemon. The current situation is, that the daemon silently ignores
all --listen arguments beside the last one. So there is no possibility
to let on server listen on many addresses without let it bind to all.

Even if that is currently not a problem with ipv4 addresses, in the
future that problem gets even worse. I wanted git-daemon to listen on
an ipv4 address and an ipv6 address. That is currently not possible
without running two instances. So I created that patch.

What do you think?

Thanks,
Alex


PS: This is my first patch for git.git, so please point out if I done
    something technically wrong.
