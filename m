From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Fri, 10 Jun 2016 10:59:46 +0200
Message-ID: <CAP8UFD1zSAxyHfZgBbfoF=th0waZWEhvHP+4jUxxVO+rU9N9RA@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <5734B805.8020504@kdbg.org> <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com>
 <5759DB31.2000106@kdbg.org> <alpine.DEB.2.20.1606100852550.3039@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:59:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBIIG-0007cm-SH
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbcFJI7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:59:52 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36492 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbcFJI7u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 04:59:50 -0400
Received: by mail-wm0-f49.google.com with SMTP id n184so257590694wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wgdS57eRNQq/PLZV/Egv+cr7kej068/DQKtdJwIP5TQ=;
        b=HZLu9WUMuMwIewP1HkapMUVUkbrWCpi9Ms/7qBEEE2k1UA5QhZO03qkD/UXh0B0BBK
         NOcXwG4q/bCwlD/PJbxBKh3DOwbkUKzFnL9DeyQmOEJd3ZKN/5jmOS74IS+2UELMgQdL
         lLFmhUegNKMkarUIlljzkv8eNPHlyUXvmSN2j7EymLnsEes3eN0Q7JeYps1tD1vmJgAy
         Ctwv/mExODj5+EqVwYtxviq2BRcV65evJTknrFnkUSpslyioVnrt/3cjrp3A6J3cg7Jv
         QnfMgCpRzB6s6iPBOq9dMIyOvLXJZwrggqUKUgzsV+N8FUJ9sUYWWC2pUBuDIYiSQhSR
         kY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wgdS57eRNQq/PLZV/Egv+cr7kej068/DQKtdJwIP5TQ=;
        b=a9e7bv5XvVh+5/FESZusA1kRYW4hD4UFWR/v1n10dg5tFIsDItZQWJuMJF9S/b81yM
         4vcJGFzZiPN23SVpR72Pf1xomv07evUWFLvJT3eRnsR35M9j52TnBY6c5O0awRQU3UZ7
         1J8R1f5D4yL35ZmIFSy/uSlQ6IMCkTpuoxJNL/tvoLJTNvE/8zkDsb+hX62qq4yIh+sY
         N1GbSFCLfPk6GGBPIFqEwlglmbVz4i7ODi60LbGPiwGzCGxpTEDP7d9OJeCa32hi7sSl
         FOmCmURd1K2LE3Y/FNpS2B+DKZDt7AxkwGkCwinOqBCuDJCbm6j7kNBmaM+mnBY41mS0
         Ms7w==
X-Gm-Message-State: ALyK8tIMRG1tBrw4E1qdHILqj15ijd88TdY+8n2D7CwCGdB/RyOyW3tu92O3FvA9ps+sYH/7RZlSDe2WTxk4KA==
X-Received: by 10.28.183.8 with SMTP id h8mr1505218wmf.79.1465549187692; Fri,
 10 Jun 2016 01:59:47 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Fri, 10 Jun 2016 01:59:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606100852550.3039@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296960>

Hi Dscho,

On Fri, Jun 10, 2016 at 9:01 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Hannes,
>
> On Thu, 9 Jun 2016, Johannes Sixt wrote:
>
>> Meanwhile, I have retrained my muscle memory to stop before typing "-i" after
>> "rebase" for an opportunity to consider whether bare rebase can be used.
>>
>> What should I say? I am impressed. It's like 100 times faster than rebase -i
>> (on Windows). I'm now using it whenever I can, and more often than not I plan
>> my rebase workflow so that I can go ahead without -i.
>
> That only means that I have to finalize my rebase--helper work (which I am
> busy doing, I am at the valgrind stage).
>
> I wonder whether that "100x" is a reliable number? ;-) FWIW I can measure
> something like a 4x speedup of the interactive rebase on Windows when
> running with the rebase--helper, and it is still noticably faster in my
> Linux VM, too.
>
>> Can't wait to test a re-roll on top of cc/apply-introduce-state!
>
> I lost track in the meantime: were those issues with unclosed file handles
> and unreleased memory in the error code paths addressed systematically? My
> mail about that seems to have been left unanswered, almost as if my
> concerns had been hand-waved away...

Haven't I answered to your email in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/292403/

?

> If those issues have indeed been addressed properly, and a public
> repository reliably has the newest iteration of that patch series in a
> branch without a versioned name, I will be happy to test it in Git for
> Windows' SDK again.

This is the newest iteration:

https://github.com/chriscool/git/commits/libify-apply-use-in-am65

Thanks for testing,
Christian.
