From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] send-email: Add support for SSL and SMTP-AUTH
Date: Mon, 3 Sep 2007 08:48:09 +0200
Message-ID: <8C6EBB4A-5E0D-485B-A0C4-E5C0C8038D03@wincent.com>
References: 7vveatpklg.fsf@gitster.siamese.dyndns.org <11887563853329-git-send-email-doug@11011.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Douglas Stockwell <doug@11011.net>
X-From: git-owner@vger.kernel.org Mon Sep 03 08:49:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS5k2-0000U9-KZ
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 08:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbXICGsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 02:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXICGsv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 02:48:51 -0400
Received: from wincent.com ([72.3.236.74]:36804 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbXICGsu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 02:48:50 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l836midQ032498;
	Mon, 3 Sep 2007 01:48:45 -0500
In-Reply-To: <11887563853329-git-send-email-doug@11011.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57432>

El 2/9/2007, a las 20:06, Douglas Stockwell escribi=F3:

> Allows username and password to be given using --smtp-user
> and --smtp-pass. SSL use is flagged by --smtp-ssl. These are
> backed by corresponding defaults in the git configuration file.
>
> This implements Junio's 'mail identity' suggestion in a slightly
> more generalised manner. --identity=3D$identity, backed by
> sendemail.identity indicates that the configuration subsection
> [sendemail "$identity"] should take priority over the [sendemail]
> section for all configuration values.

This will be really useful to me in my current set-up. I'll test it =20
here locally and let you know if I can find any problems.

Cheers,
Wincent
