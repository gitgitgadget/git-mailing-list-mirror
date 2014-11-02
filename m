From: Alexander Shopov <ash@kambanaria.org>
Subject: Re: [L10N] Startup of Git 2.2.0 l10n round 1
Date: Sun, 2 Nov 2014 19:08:25 +0200
Message-ID: <CAP6f5M=OqzH8R6QPxPr3yn1xCFJPA8N6q33BZGg4t8T96KaEgg@mail.gmail.com>
References: <CANYiYbH-Gz8rSo1OX8ApA1ysgpi=YaE+yq9XDOa-DUXeppxQOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 18:10:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkyfM-0000GY-Bw
	for gcvg-git-2@plane.gmane.org; Sun, 02 Nov 2014 18:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbaKBRI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2014 12:08:27 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:63570 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaKBRI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2014 12:08:26 -0500
Received: by mail-qg0-f46.google.com with SMTP id i50so6747111qgf.5
        for <git@vger.kernel.org>; Sun, 02 Nov 2014 09:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q5BNoT7nzmaaYegijCBEUS0FrcYyJdNcAqD2tdENUwU=;
        b=EC69K9lvQwCrAHmWaubXMir0w9LXWk4y1rwoEDj/ii3q/qrQ8bNrkcsT55TjQ02JTv
         dj1gJ1v4UOChgZNA0+DfaOGA7cdrm1w+cfwH1Zq01QnClFiAkiJfYdzwmNleDk4a+fr0
         cbJiFHkz96wOFqeRev9Q5MNpczTCs74VKfZ1lm8GstdppWhBMV0Gk2nda/uCuczqYgJ7
         EbdD0Sq9sYTW6ck3trSpHf59HDRG7Mm219anqR0C6nRUbsfXvM4AaBZNY+A4Bk766egF
         7z6SO8luZOXY8QXUvFE5r6PbIjq7aJsRrjWw7spzes9EC9NsEdoXxFzGc3IiJYOCbvvA
         NQVQ==
X-Gm-Message-State: ALoCoQmTyC/qwSBUBgGiR5r+GgQb14thBa//7qS7Mri8tplERS1ISTav/V1f7GG6ZE5suSPSs4Dx
X-Received: by 10.224.69.202 with SMTP id a10mr18422095qaj.62.1414948105311;
 Sun, 02 Nov 2014 09:08:25 -0800 (PST)
Received: by 10.140.92.116 with HTTP; Sun, 2 Nov 2014 09:08:25 -0800 (PST)
X-Originating-IP: [78.83.52.173]
In-Reply-To: <CANYiYbH-Gz8rSo1OX8ApA1ysgpi=YaE+yq9XDOa-DUXeppxQOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can you please disambiguate message:
msgid "more than one %s"

It means that something somewhere was repeated but does not point what
and where. Perhaps users care about that.

It is now used 3 times (trailer.c:552 trailer.c:557
builtin/remote.c:288) but points to different things that were
repeated. It used to mean only that there is a "remote' section
repeated.

Kind regards:
al_shopov
