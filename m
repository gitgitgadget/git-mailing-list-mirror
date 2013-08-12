From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Huge possible memory leak while cherry-picking.
Date: Mon, 12 Aug 2013 05:34:16 -0500
Message-ID: <CAMP44s3SMwQseKbQ8dvYKK41WCWwejRhTqBmJQPCJP2XNG1mLQ@mail.gmail.com>
References: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com>
	<CAMP44s282DD+tQUgVHawdRDJayjTxMjOu_R3robbCVhkbksEtQ@mail.gmail.com>
	<CAJc7Lbrmsna4u4s+fdCGZ7jn9HzgZkinL3tbjbjcuw40Of5umg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 12:34:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8pSA-0006mv-Dq
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 12:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab3HLKeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Aug 2013 06:34:18 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:42004 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab3HLKeS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Aug 2013 06:34:18 -0400
Received: by mail-la0-f42.google.com with SMTP id mf11so4522822lab.29
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uWOguaUwzo+AZQK9nSH22DH8+T1AzPPpjDS5U+ierFI=;
        b=FEU+8RvFQmXahwBTGWc9tBMYsWnqjjCaPZ45sZjO8O51ZVW/7AjAibTM1m/gpOdWg8
         uZUYUmPOsxBD/f6/FB7CxfmtejDx7c+YT6I+a2ihqpynxvjiYjVYQIoVxEFbVAlVyEIl
         ZeH+z9ZuQ+W+CGejEMo+pM2o6lAsoOlp2tUhFS82zx3eWppbv6EYwWZbqDZ4YuBE37k3
         8Sy4GhNbfGinLMQo9P48D6otcYJ06EmfIniU4NgvdpbdZdKrF/2ltA8aVGWBTFQn11AF
         yXCP9SP+RE0Xr7FVQQtMcdgbHsF36z1y61soUGYN5GthQU1dHuv6pS0xBy+Eo6cYfypE
         XqOQ==
X-Received: by 10.152.9.233 with SMTP id d9mr11137057lab.33.1376303656574;
 Mon, 12 Aug 2013 03:34:16 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 12 Aug 2013 03:34:16 -0700 (PDT)
In-Reply-To: <CAJc7Lbrmsna4u4s+fdCGZ7jn9HzgZkinL3tbjbjcuw40Of5umg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232182>

On Mon, Aug 12, 2013 at 5:04 AM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=
=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
> Thank you, it works very well!
> Will this patch go to upstream?

Ask Junio.

> Also, there is still some unexpected memory consumption - about 2Gb
> per ~200 commits, but it's bearable.
> I will do a futher investigation.

Can you post some valgrind log? Or even better, a way to reproduce?

> Felipe, should I exclude you from my futher reports on possible memor=
y leaks?

Exclude me?

--=20
=46elipe Contreras
