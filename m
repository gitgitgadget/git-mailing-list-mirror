From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 0/5] coverity mixed bag
Date: Tue, 29 Jul 2014 07:36:44 +0200
Message-ID: <53D732EC.8010302@gmail.com>
References: <20140724043940.GA31282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 07:36:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC05f-0005BX-8W
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 07:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbaG2Fgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 01:36:43 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:48807 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbaG2Fgn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 01:36:43 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so5514706wib.8
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=w8wfwFS+z8eyjeMGmR1C8dRKhl8df/pKToy7kqoUhN0=;
        b=CyX28+QkMAUCR61IVurkdr6BA0qQBig5AclppqFxKWK7E9JNkLnH5yiqFxGMEGsRLv
         UYZBMygPDRYsPAcXlLnZJ23WVwQqEYTEDu5O59/5CaQdvY49nB/DdWNvQBZTU72KHClH
         zojMB6HgjArOdgyLMERctADzR23eEKakq64NXPemynWruaSxc8y/Uci54r5P/6+l2RE+
         vh3JVhyt+HYK6RcSG4apxGYx1Smxw3BzKxc5akW2WM+ZyMiBgyKgL9eElTtbUwwSowqO
         uMMFNjGFQ88eJWzdt5oGO7lIJx30r1x1t9ESgw5intr69GY/+q8Eky1TN6Ft1aUNZ1AH
         T2Fg==
X-Received: by 10.180.73.6 with SMTP id h6mr2602424wiv.65.1406612201955;
        Mon, 28 Jul 2014 22:36:41 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id f6sm54776741wja.25.2014.07.28.22.36.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 22:36:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140724043940.GA31282@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254393>

On 24.07.2014 06:39, Jeff King wrote:
> Since Stefan has recently started feeding git builds to coverity, I
> spent a few minutes poking through the results. There are tons of false
> positives, so there is some work to be done there with tweaking our
> coverity models. But there are some real issues, too. Here are fixes for
> the handful that I looked at.
> 
>   [1/5]: receive-pack: don't copy "dir" parameter
>   [2/5]: free ref string returned by dwim_ref
>   [3/5]: transport: fix leaks in refs_from_alternate_cb
>   [4/5]: fix memory leak parsing core.commentchar
>   [5/5]: apply: avoid possible bogus pointer
> 
> -Peff
> 

As this patchset is in, we have coverity scan now finding
10 defects fixed.

Thanks,
Stefan
