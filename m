From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: Add support for gravatar-ssl
Date: Thu, 09 Aug 2012 21:36:46 +0200
Message-ID: <20120809193655.7418D13F8069@mailgw.unict.it>
References: <20120809184210.GA27795@goeswhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: Chris West <git@goeswhere.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 21:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzYdU-000372-SC
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 21:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759468Ab2HITnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 15:43:07 -0400
Received: from smtpout1.unict.it ([151.97.0.51]:56801 "EHLO mailgw.unict.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759376Ab2HITnF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 15:43:05 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2012 15:43:05 EDT
X-Sender: DMI@vger.kernel.org
Received: from mbox.dmi.unict.it (mbox.dmi.unict.it [151.97.252.131])
	by mailgw.unict.it (Postfix) with ESMTPS id 7418D13F8069;
	Thu,  9 Aug 2012 21:36:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mbox.dmi.unict.it (Postfix) with ESMTP id 2CD81239C;
	Thu,  9 Aug 2012 21:36:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mbox.dmi.unict.it
Received: from mbox.dmi.unict.it ([127.0.0.1])
	by localhost (mbox.dmi.unict.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Q5B7jCGQzoC; Thu,  9 Aug 2012 21:36:54 +0200 (CEST)
Received: from oblomov.localnet (unknown [151.74.177.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: bilotta)
	by mbox.dmi.unict.it (Postfix) with ESMTPSA id 311142361;
	Thu,  9 Aug 2012 21:36:54 +0200 (CEST)
User-Agent: KNode/4.4.11
X-UniCT-MailScanner-Information: Please contact the ISP for more information
X-UniCT-MailScanner-ID: 7418D13F8069.AA373
X-UniCT-MailScanner: Found to be clean
X-UniCT-MailScanner-SpamCheck: non spam, SpamAssassin (not cached,
	punteggio=0.653, necessario 5, autolearn=disabled,
	FREEMAIL_FROM 0.00, SPF_NEUTRAL 0.65)
X-MailScanner-From: giuseppe.bilotta@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203177>

Chris West (Faux) wrote:

> Teach gitweb to allow 'avatar' to be set to 'gravatar-ssl', switching
> to the https://secure.gravatar.com url form, to avoid mixed content
> warnings when serving gitweb over https, with gravatar enabled.
> ---
> I'd alternatively propose always using the https:// form of the URL,
> but it seems significantly slower, so it's probably best to let people
> pick to continue using the insecure version.

Rather than introducing a new, separate setting, wouldn't it be better
to have the gravatar URL be automatically decided based on the current
gitweb URL? (use the ssl gravar url when the current protocol is https,
and the standard http url otherwise)
