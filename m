From: David Aguilar <davvid@gmail.com>
Subject: Re: t7610-mergetool.sh test failure
Date: Thu, 26 May 2016 21:40:27 -0700
Message-ID: <20160527044027.GA26143@gmail.com>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
 <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
 <20160525231615.GC2634@sigill.intra.peff.net>
 <20160526015114.GA12851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 06:41:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b69aQ-00067C-1h
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 06:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbcE0Ekd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 00:40:33 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32812 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcE0Ekc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 00:40:32 -0400
Received: by mail-pa0-f52.google.com with SMTP id xk12so36204066pac.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 21:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aoYorzN4SfMSlyVHIn6Aa9L31tkrKHNaHqdxeqa1TKc=;
        b=cKdmRMvktuM14UaiO+X2UcqGVGTA8MfIZz+EZ3p2gcwqRkp4uEwDZZwk+Yiw5xhZJJ
         XtKoIbl0wJgrWhADCCde8xctIFzTmq+QmdWizRAeYrz8SeRRW2YYKZ3YXF5CS73R3gbW
         QehX8YCV4BVC6qGxSCePYkxT6G3qQYkUXlbKcPvrPCeXBiE79SqqU02aE3rhNdHyXUL5
         hMsRCq/JmMJlB27w+Mqn4XyVvDN912OwYy12DJaIXX8lQ76+cQfYv9YPyi0Yk2tqZlk+
         y4ZktpFNVS2FS8TCteN0d9W8X9rkZwrnsOzHTGpN7x/uGVKQ3jKC2jxt5htiusxn8hQg
         9ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aoYorzN4SfMSlyVHIn6Aa9L31tkrKHNaHqdxeqa1TKc=;
        b=kSkUjGDRSoKpC6wWh7dE38EPV2CSVCWCKOjjyTHH7lz+SkL7qoqUxzGsr6x8FrQU4X
         7Ky0OFfqiHHaxoWv9+HHD3gwwgwzHglYF6caN0ol00cY1mke+n2iQ3j6dw63RqyFjdqa
         VqA7r3ZCXUSw+nGsNxaNySd/oOjg5+carY/Q2LD4fSeSyOC9b6kQXksVYgHt2qwycng8
         lM2dzsqD2xa0emIIC9Hq+jdBoP3Tbdx54XSI/sFgKNYPkCl3+iGIh3EwpUn8FxM5b0Jy
         GsfpYtNHz0KGxukOz8BWl+2B7ijfL+AArhtd/eZ9hinRl8wqBJyazcrF0Tc0ZeRlLa8K
         wR+g==
X-Gm-Message-State: ALyK8tLZYmgqGePetPXGBPaKxkHkc5TKJwyqfGCMVqOHyFHXKLrGbhWReWeA5nAsmjdr9Q==
X-Received: by 10.66.170.168 with SMTP id an8mr19309772pac.47.1464324031628;
        Thu, 26 May 2016 21:40:31 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id 4sm9686556pfm.15.2016.05.26.21.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2016 21:40:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160526015114.GA12851@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295729>

On Wed, May 25, 2016 at 08:51:14PM -0500, Jeff King wrote:
> On Wed, May 25, 2016 at 06:16:15PM -0500, Jeff King wrote:
> 
> > On Tue, May 24, 2016 at 09:45:25AM -0700, Junio C Hamano wrote:
> > 
> > > On Tue, May 24, 2016 at 9:44 AM, Armin Kunaschik
> > > <megabreit@googlemail.com> wrote:
> > > > t7610-mergetool.sh fails on systems without mktemp.
> > > >
> > > > mktemp is used in git-mergetool.sh and throws an error when it's not available.
> > > > error: mktemp is needed when 'mergetool.writeToTemp' is true
> > > >
> > > > I see 2 options:
> > > > 1. code around it, write an own mktemp, maybe use the test-mktemp as a basis.
> > > > 2. disable the test when mktemp is not available
> > > 
> > > 3. find and install mktemp?
> > 
> > I'd agree more with (3) if it was some critical part of git-mergetool.
> > But it seems to be a completely optional feature that we use in only one
> > place, and git-mergetool even detects this case and complains.
> > 
> > So another alternative would be for the test to detect either that
> > mergetool worked, or that we got the "mktemp is needed" error.
> 
> BTW, one thing I happened to note while looking at this: running the
> test script will write into /tmp (or wherever your $TMPDIR points).
> Probably not a big deal, but I wonder if we should be setting $TMPDIR in
> our test harness.

We already set $HOME and various other variables to carefully
tune the testsuite's behavior, so this sounds like a good idea
IMO.

Would there be any downsides to setting $TMPDIR equal to the
trash directory?

FWIW I set $TMPDIR to the $TEST_OUTPUT_DIRECTORY in test-lib.sh
and was able to run the test suite without any errors.

Is it worth patching?
-- 
David
