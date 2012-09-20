From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v5 3/3] Color skipped tests bold blue
Date: Thu, 20 Sep 2012 12:08:27 +0200
Message-ID: <505AEB1B.7010702@gmail.com>
References: <505AAE34.2020408@viscovery.net> <1348132118-23139-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 12:08:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEdge-0003gt-9E
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 12:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab2ITKIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 06:08:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60239 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab2ITKIi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 06:08:38 -0400
Received: by bkuw11 with SMTP id w11so98970bku.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=nYudk6nwFjR0F2HtLgVxfl+7Pvtpyh6+6E0xLZKnLX4=;
        b=UyVLVqf4aIgPDB5PRkkoUj45FAAb/tSMdRwnTiZg5t6O46bU3hlP0ECi39cIydqg8k
         nmThLRiwPrlPEwb+vZswrIxUg1IrWYNnTObzMYJ5YxdIBEby9DDNgWD1tO8/kn1FojSZ
         wbrP+V90Abw1038c41BoZdzehvxtSk39kM4PNUj9fN3wG/bqG7x5Qc/rA4Wyi6WLKV/Z
         VeBDgw61Mh+0VBu/D02ksYLecaNkjjBT6OGEL6P6qmysV+kNumTGnxJ5v+HJr/haI9QH
         oPUP/LNdWwFmS2kMh1jAurEOFmmi0Mb3IasHmt8Tt5cyAkt1akWf7lySTvFWSfFOh70h
         0F7Q==
Received: by 10.204.8.84 with SMTP id g20mr339292bkg.126.1348135716810;
        Thu, 20 Sep 2012 03:08:36 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id x13sm2945052bkv.16.2012.09.20.03.08.35
        (version=SSLv3 cipher=OTHER);
        Thu, 20 Sep 2012 03:08:35 -0700 (PDT)
In-Reply-To: <1348132118-23139-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206044>

Hi Adam.

On 09/20/2012 11:08 AM, Adam Spiers wrote:
> Skipped tests indicate incomplete test coverage.  Whilst this is
> not a test failure or other error, it's still not complete
> success, so according to the universal traffic lights coloring
> scheme, yellow/brown seems more suitable than green.  However,
> it's more informational than cautionary, so instead we use blue
> which is a universal color for information signs.  Bold blue
> should work better on both black and white backgrounds than
> normal blue.
>
A very minor nit (feel free to ignore it): IMHO, it should be nice
to state explicitly in the commit message that blue is already used
by other testsuite-related software to highlight skipped tests; you
can report the examples of at least Automake, Autotest and prove --
and extra kudos if you find further examples ;-)

Thanks,
  Stefano
