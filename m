From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v7 2/7] tests: paint known breakages in yellow
Date: Fri, 21 Dec 2012 09:51:27 +0100
Message-ID: <50D4230F.9080502@gmail.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com> <1356059558-23479-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Spiers <git@adamspiers.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 09:57:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlyPm-0007k3-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 09:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab2LUI4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 03:56:53 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:58377 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab2LUI4v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 03:56:51 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2012 03:56:51 EST
Received: by mail-bk0-f48.google.com with SMTP id jc3so2182175bkc.21
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 00:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kjYFmBxTF+MKbaPeZRtMqYdXwE54g+S7rDAEEPWgOsU=;
        b=zqxjzVb5sS2H2UOcMM6Pfn5m4TLSSazHITzYn8o40rFdpoSzGRbFton1AyaysKk3Pk
         IdEnXGTnFvd8sVibGj26HpZHCbpGtuNsVeSWL9Fz+S9PSpQRnrW95U4wRYzCX7kltUiL
         r+31OkLN5TdCfv4TL2u4eJWwsr3FED6ZqLJCm7iqznsSJG2IaOCanUgh337MRRHD8yOA
         ZO3SFDbEyqbDhCZVTpQrRH8vAEUvdpUzDieBzNyFYljLXnA2Tee1BGKuqwhhMn/F22wa
         RQ2eSQ98Sfo8i8CZ5S4E1SpvEDm13zqF4MuaNQ7x6A1RVqi6if1b+m542kWgar6Ml5I0
         SzjA==
X-Received: by 10.204.133.219 with SMTP id g27mr6003493bkt.65.1356079895938;
        Fri, 21 Dec 2012 00:51:35 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id hm8sm9091632bkc.10.2012.12.21.00.51.34
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 00:51:35 -0800 (PST)
In-Reply-To: <1356059558-23479-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211961>

On 12/21/2012 04:12 AM, Junio C Hamano wrote:
> From: Adam Spiers <git@adamspiers.org>
> 
> Yellow seems a more appropriate color than bold green when
> considering the universal traffic lights coloring scheme, where
> green conveys the impression that everything's OK, and amber that
> something's not quite right.
>
Here are few more details about the behaviour of other testing
tools, in case you want to squash them in the commit message for
future references:

1. Automake (at least up to 1.13) and Autotest (at least up to the
   2.69 Autoconf release) use "bold" green for reporting expected
   failures.

2. On the other hand, the 'prove' utility (as of TAP::Harness v3.23
   and Perl v5.14.2) use yellow (not bold) for the same purpose.

Regards,
  Stefano
