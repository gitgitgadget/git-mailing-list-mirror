From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v4 09/14] remote-testgit: report success after an import
Date: Fri, 02 Nov 2012 17:08:20 +0100
Message-ID: <5093EFF4.5080308@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com> <1351821738-17526-10-git-send-email-felipe.contreras@gmail.com> <5093D193.3030108@gmail.com> <CAMP44s2ZPbda7yJ9UtOhWMqaKp4TaAgoyeUWUSrt0vco7RK+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJnU-0000rI-7p
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 17:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab2KBQI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 12:08:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59645 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2KBQI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 12:08:26 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1441324bkc.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=/oFOA5isZKxTsma1RQ2cKPmrjuTWYrvvlBejQMeyFq8=;
        b=NsyB9dhU1Ai6H5SuE4PKeAF9u+pbL/38C4mCWbR4wum3HGNFMnUMI/7wuQAMnoN4eB
         5DB0AAmJ+twjpmUacv7ktFj76L839qXAHyd92iG5is+cERlNquvqPV0JEc//0DvC4/jP
         4BgbBrpoUwG8W6ZLWw7HpZlFhDu4SnLExw1xlVVbAqBAgRFbW/5GzkRTTcvNmioAuTVl
         EQ6AscioOZeZ7B1yqn+yIEPhBvQOnzyrknHI6dbCyqWK8KyNQPKohbXbpUpIcS8tthRM
         2JNVfbNJQvq/dDRiWKjoEz5FsbW+UqbUtTgNgefwA4uTbUXHKmNIie9sS6MtlfhT1OCA
         yPCA==
Received: by 10.204.148.146 with SMTP id p18mr548200bkv.51.1351872505571;
        Fri, 02 Nov 2012 09:08:25 -0700 (PDT)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id j24sm6925559bkv.0.2012.11.02.09.08.23
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 09:08:24 -0700 (PDT)
In-Reply-To: <CAMP44s2ZPbda7yJ9UtOhWMqaKp4TaAgoyeUWUSrt0vco7RK+Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208957>

On 11/02/2012 04:46 PM, Felipe Contreras wrote:
>
> In the end I liked this approach much better.
> 
> If you have a solution for this that works in POSIX shell, I'll be
> glad to consider it, but for the moment, I think a simple, easy to
> understand and maintain code is more important, and if it needs bash,
> so be it.
>
If this is a deliberate decision, it's ok with me.  I'm just a "casual"
reviewer here, not an active contributor, so I'll gladly accept
preferences and decisions of the "active crew", once it's clear that
they are deliberate and not the result of mistakes or confusion.

In any case, I agree that having a clean, understandable code as a
starting point is better than having a more "portable" but trickier
one right away.  If it will need converting to POSIX, that can be
done as a follow up (and as we've both noticed, this would be the
only point where such a conversion might be problematic -- the other
changes would be trivial, almost automatic).

Regards,
  Stefano
