From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 14:12:37 -0700
Message-ID: <CAGZ79kY8s9pV_Lb8D0OYCrarDyC6v2U0VkaJSJBnviditYK9aA@mail.gmail.com>
References: <20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
	<xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
	<20160428191038.GA10574@sigill.intra.peff.net>
	<xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
	<xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
	<20160428210342.GB12268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:13:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avtF5-0002NJ-On
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 23:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbcD1VMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 17:12:40 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37858 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbcD1VMi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 17:12:38 -0400
Received: by mail-ig0-f174.google.com with SMTP id s8so3878895ign.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=XrGiDzelDAl69p516Jozr3XfMqgDjxvnQIidWZhGBLM=;
        b=D1keEYql0BNR8VM1C/x3zBsMNlntcqvCsX+iLWCqbI6qhvbjNhYRZWWeeDihVGPEd1
         q+FLBcImJYMPtQYxvt0zi8ddrjU7galwxjQmjdG3GXPJjssajixe+ufXqD7KkfKE3zwm
         GLb01lJV/P/Spepbtha3HFcP4fLlgKwgT8jnVHIOYSA7L1Le2TN7ZuzaqgPnLbE5cmxd
         Q9eyMQQBgyPgdMh1LwX76gwKHKoMSq9QBt+PMjMZfMTU0aileN6oGgwI4/Pydy7c0Cx3
         A+fV2rnJcwY2QyCASBEwzUGv5XDo7GvWLBdC6O98oInFt4Suwi9vVW7/ayIfBQTHSTv8
         6x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XrGiDzelDAl69p516Jozr3XfMqgDjxvnQIidWZhGBLM=;
        b=cxLkHi16fnhAaC2czoNG5FkmjYPFmozEMAnVD5b3qQTAyYhv0meit/Juy/SLY3C7Ae
         y9YhHrJU8RdLjsY4cmOlwS3WB6kVFtTHCPdrnEP35DpFxkbrBxtIZtDW+VQT9sSqYg/E
         D+39UwxQ2K4QU9hFbHsKS1mnNHd1x8z5PmLFgtleBScl80E44EL4ELgAzat2VwPCAC5r
         9jrrQpb7gBnrAEdKBhRIsMeGQ3BXIBC+/+Iz4tTGS1gDEWa58TKrbZMchfCK/UmGFH7E
         NHT8qbShVj4y5cclU1HtYg0Me5lV2UTZz+b5STpv5XLPTYiV3KYfAU22vGvu3PS9TPQX
         Yizg==
X-Gm-Message-State: AOPr4FXYKE85hsvjNYGbI8Giw+2DNOoFrmEU1DbwY0xHTsJbTSCFZHTKGTTqyBQ5MmahDNM/8xyUjLw111RmJKeo
X-Received: by 10.50.102.207 with SMTP id fq15mr42779igb.94.1461877957149;
 Thu, 28 Apr 2016 14:12:37 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 14:12:37 -0700 (PDT)
In-Reply-To: <20160428210342.GB12268@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292956>

On Thu, Apr 28, 2016 at 2:03 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 28, 2016 at 12:52:03PM -0700, Junio C Hamano wrote:
>
>> "git" is not always about submodules, so "-c-but-not-for-submodules"
>> option does not belong to "git" wrapper.
>>
>> Users use "git -c" and hope to affect what happens in submodules,
>> only because "git submodule" support is still immature and does not
>> have options to do that.  You certainly smell a linkage between
>> "pass options to a selected subset of submodules" and your recent
>> "give labels to submodules so that they can be named with *group
>> syntax" topic, no?
>
> Keep in mind that submodule interactions may be triggered from other
> non-submodule commands. So "git fetch", for instance, may end up caring
> about whether you pass "http.*" or "credential.*" down to the
> submodules.

Or clone. I recently sent origin/sb/clone-shallow-passthru
which adds more options to a non-submodule command.
I think a command line option there is better than a "git -c $OPTION"

> I do not think "fetch" should grow submodule-specific
> options, so that pretty much leaves "git" options as the only place
> left.

I would rather see it in fetch as in the generic Git?

Stefan

>
> -Peff
