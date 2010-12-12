From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: [RFC/PATCH] RE: git calls SSH_ASKPASS even if DISPLAY is not set
Date: Sun, 12 Dec 2010 13:32:53 +0100
Message-ID: <1292157174-4033-1-git-send-email-alexander@sulfrian.net>
References: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 12 13:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRlNK-00041O-3C
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 13:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab0LLMty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 07:49:54 -0500
Received: from animux.de ([78.46.93.45]:33636 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab0LLMtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 07:49:53 -0500
X-Greylist: delayed 1002 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2010 07:49:53 EST
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id 0E44182E6015; Sun, 12 Dec 2010 13:33:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=7.0 tests=ALL_TRUSTED,AWL
	autolearn=disabled version=3.3.1
Received: from laptop (unknown [93.214.50.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 79B0182E6003
	for <git@vger.kernel.org>; Sun, 12 Dec 2010 12:33:08 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Sun, 12 Dec 2010 13:33:07 +0100
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163479>

Hi,
I prepared a patch to fix this behaviour. It is a simple patch that
adds another check for the DISPLAY environment variable.

But I do not know, if this behaviour breaks something...


Thanks,
Alex
