From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Put quotes around branch names to prevent special 
	characters from being interpreted by the shell.
Date: Mon, 7 Jun 2010 05:48:11 +0000
Message-ID: <AANLkTik7PV-2u24UF78U6rtuffw4XUGS1F4hD2_ElrZZ@mail.gmail.com>
References: <1275666800-31852-1-git-send-email-bmeyer@rim.com>
	<20100606215505.GB6993@coredump.intra.peff.net>
	<AANLkTinZc1jiBmTJRsJXDe7A4ZAe001zJIWILGKQ8YoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Benjamin C Meyer <bmeyer@rim.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 07:48:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLVC6-0005Vw-75
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 07:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab0FGFsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 01:48:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57509 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab0FGFsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 01:48:12 -0400
Received: by iwn37 with SMTP id 37so3024624iwn.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 22:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Ji3XCvQGmxOepUfxXwiMvnhrzSBIOfpafX3kOX2LHjw=;
        b=L2kYc72609dluFLC1UZX+GY5WOdT5b2+cVZnV3xpczGoPAfYy9qiPIJiJ+yJxK4j7j
         0XN/onifQTcUkGYujKwARwmklizSzJR0VpdSXtR6yKKtchwGUinFGG+5uokw5cNCHFF+
         HJMHyiCMua35gFlZyXtHoJKLmeBVpmJM/GINA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wo/K58olGZ7Mbs3PY+5f3HVaKdd6c/44hXqnCf4wdeG0WXfAr9s1JuyBK8dz5bqyGQ
         xtztob4oYH/5bM0QK5oncGXKclA4cAWlVZIhYVr2qr+WC+cFuu++4ux3wevS5UynRBWO
         hNNlCpCs8F4ZJTO6GYxmuehNbb+osIREn/L8I=
Received: by 10.231.111.209 with SMTP id t17mr3894205ibp.182.1275889691782; 
	Sun, 06 Jun 2010 22:48:11 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 6 Jun 2010 22:48:11 -0700 (PDT)
In-Reply-To: <AANLkTinZc1jiBmTJRsJXDe7A4ZAe001zJIWILGKQ8YoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148573>

On Mon, Jun 7, 2010 at 05:10, Jay Soffian <jaysoffian@gmail.com> wrote:
> BTW, quotemeta is technically intended for use with regular
> expressions, isn't it?

Yes, it's completely insecure to use it for shell interpolation.

In Perl it's best to use the list form of system() so that the command
will escape things for you automatically.
