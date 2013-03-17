From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Sun, 17 Mar 2013 18:41:23 +0100
Message-ID: <CALWbr2wQNM=7vUcoragNmKGpSeXkOCsmsM5y1AMhj95i15A4bw@mail.gmail.com>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
	<alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
	<CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
	<7vmwu6x72q.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
	<7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr>
	<7v4ngcwt4w.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
	<20130316120300.GA2626@sigill.intra.peff.net>
	<alpine.DEB.2.00.1303162355120.21738@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	kusmabite@gmail.com, git <git@vger.kernel.org>,
	msysgit@googlegroups.com
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Sun Mar 17 18:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHHai-0004lK-RV
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 18:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445Ab3CQRlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 13:41:25 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:49568 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab3CQRlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 13:41:24 -0400
Received: by mail-qc0-f172.google.com with SMTP id b25so2383574qca.17
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=uuEYo+YEB+gwR5ovJ6cY9fgc9NozTfcLDCISKsK2q/Q=;
        b=LXDOAfYKHt8GceQQhOkfiGpVJdRTr3ev0EMPAkfu3aU7qO+rUJEYHJstYxPtYj35mP
         Gdoeaxy3uMmQ9JHUYz5eyZicoAVnZr2oM57sSg6ijQ7CrKUyk2CKTkoETdksgFWqwrrI
         Gis0qZhYDxTjGsN9Cf5nKsjtzRu6dXtPY4jG5RD2uCETS0a4QkmKnlH/xYeyL98ESrEe
         RrBd7RephINeuhISrzXdjNayxznDBAAu04hGIBhIlPdhQDNdpQh/Jy4KCNy4udVlqrwE
         CYakDqCShqIX7Dt21Eqc3lu4xwWlRvMiUoBCRhRiCcZKdT1wWhIfPTnvvIktY1fWCCHJ
         pKJw==
X-Received: by 10.229.118.158 with SMTP id v30mr2939817qcq.52.1363542084000;
 Sun, 17 Mar 2013 10:41:24 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sun, 17 Mar 2013 10:41:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303162355120.21738@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218367>

> With redirects taken into account, I can't think of any really good way
> around avoiding this init...

Is there any way for curl to initialize SSL on-demand ?
