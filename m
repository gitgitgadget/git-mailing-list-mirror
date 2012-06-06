From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to remote-helper.
Date: Wed, 06 Jun 2012 23:04:18 +0200
Message-ID: <1455162.h3ffdVdFSZ@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <5801019.gWQEmI8V81@flobuntu> <20120606134320.GC2597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:04:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScNP1-00016T-5S
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 23:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab2FFVEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 17:04:23 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51451 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab2FFVEW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 17:04:22 -0400
Received: by bkcji2 with SMTP id ji2so6098457bkc.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=+sER4uxyitXcOXlKiblra9V1fs2TKgCKgl9KCgVAPrY=;
        b=FdrRCo2T08bdH1mEc/h+MAXzEm+3qLDMi7VN4GkLqv4I2fCFUIpp1vww8c1LWOppoj
         DlchpuYYvXu4oHlAVh41wbW9CNOoHHvMe4egPMPm1KbdFUDOKKXSq+o1q5LNBf8gf8yj
         ddSiDIoT1Wo2hUn4KM96KKcxyo5v/I0slbff/+ZCJcvd51xJpi6Gm+YTE9yIAn1vT9zD
         QPuYNkESgVGF8iv/LHF7KERLIeseJFY3gH21dxGUz6Dc6vzhdhsg44XcGOkZwEJKrYVx
         FE6/lEYo8XaBvpBlXSrVerUAm9GVcmVrIBsW0xpmxIC7nXV5rsLUJdgFK8xpRg+L0u8b
         sG6A==
Received: by 10.204.152.13 with SMTP id e13mr13947557bkw.46.1339016661149;
        Wed, 06 Jun 2012 14:04:21 -0700 (PDT)
Received: from flobuntu.localnet (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id e20sm1290643bkv.10.2012.06.06.14.04.19
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 14:04:20 -0700 (PDT)
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <20120606134320.GC2597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199354>

On Wednesday 06 June 2012 09:43:21 you wrote:
> Good point. I think we really are stuck with doing it in every case,
> unless we want to turn to something that can be opened after the fact
> (like a fifo).

A fifo could be clever. There's also something similar on windows, maybe we can 
use named pipes there too.

> 
> -Peff

-- Flo
