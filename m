From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Fri, 3 Jun 2016 20:02:25 -0400
Message-ID: <CAPig+cTQkEb6K95aeJ9vNyJ=S+8x+JnCQAYSEzydXKzbq-+Yyg@mail.gmail.com>
References: <20160530232142.21098-1-e@80x24.org> <20160530232142.21098-2-e@80x24.org>
 <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
 <20160531074506.GA8911@dcvr.yhbt.net> <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
 <20160531182932.GA27021@dcvr.yhbt.net> <20160602075125.GA19551@dcvr.yhbt.net>
 <CAPig+cTLVXJBn00aco0vC9oFvZuchTgtNXtGGjpLPx1LwRZz4Q@mail.gmail.com>
 <xmqqlh2loq6p.fsf@gitster.mtv.corp.google.com> <CAPig+cQXA3mgYC3rCTx2h93rB6djdKvYJ+oCXUP24-xk2PqW=Q@mail.gmail.com>
 <xmqqzir1zvo2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <e@80x24.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 02:03:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8z2t-0007IJ-6s
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 02:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbcFDAC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 20:02:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36230 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcFDAC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 20:02:26 -0400
Received: by mail-it0-f66.google.com with SMTP id i127so604889ita.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 17:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Xvd8nFulmajNZbzhMSY7JHOzQW1fSDm3YOV+daxkicU=;
        b=Mb/5JLPU20MKu0qwnpHeTkj0FHfCvpOAeeD6yYjIehPaD5bjAcc5ddQCGkG6Su1M0j
         tOkP/D+LGnBiI2lDENyBn691qX/ETTxK/kjl2cCnTzEtacp7iQ6Cbs2aill2CBCmps7/
         j1ZQzmrbQeBoZ9NdnGF3qTam73uy2np3qTaUzqjap0tVFkhJKLYpQkFTF86zC2hymwmx
         Bertug9CY1g8VxE986WC3rTlVSx6nQaVVxxb1iFJ08rPUmi4H09GfJmi1HS/BuAKWGNG
         lH3UVJF+3COUGfbhsRQHdPOHoo/ikK6rvKkYcDrMcJi4yfyXlruHMNj8/R01QAeZoun5
         mNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Xvd8nFulmajNZbzhMSY7JHOzQW1fSDm3YOV+daxkicU=;
        b=fxE8S8Gc7FVso2KR1M8MS7LbyQObmmXh4TMowZ3hqhjAmie4tQCeyqgxANO6Qzo6kv
         62tn8cecUTiNDU30TiitirJvyH+gHLOXbchjkyZk4ivGQFss+QFwnfRCMk5zS4UyLaZf
         /KKZjmDsBC2FCglZvzCJPjAIO8hbvEBUWsiBM4UQgoph1oY2Jvw3HyHb3uduoKuyZM8l
         ge7zemfjsAAK2Su0HdGauzh3HhSO5S39cAnFQW5UQ5/ghaUlYBcvtTCT3lAkjeud6gMO
         hID8L2FClHS53Y2EbUHGrtRjukhBDmXSMT7Ntw4d0cCc5iP81vNsbf2r8G0M22FDQzai
         FbMA==
X-Gm-Message-State: ALyK8tLqJSeb7qM2QGW+Nc48oi+Dik4f39Mwjt+kfCMS+nv6OoNtXGS6aMxPjGg8aSZWfka8b/Vn4sWEHifNKg==
X-Received: by 10.36.112.81 with SMTP id f78mr3239424itc.32.1464998545715;
 Fri, 03 Jun 2016 17:02:25 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Fri, 3 Jun 2016 17:02:25 -0700 (PDT)
In-Reply-To: <xmqqzir1zvo2.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: YHK--IjQYdY4qGaCM3nOFjq_5p8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296434>

On Fri, Jun 3, 2016 at 7:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>>         static int is_mboxrd_from(const char *line) {
>>>                 return starts_with(line + strspn(line, ">"), "From ");
>>>         }
>>>
>>> is sufficiently high-level that no longer is scary, hopefully?
>>
>> That's nice and concise but unfortunately not useful for this case
>> where we must respect the logical end-of-line (within the larger
>> buffer), represented by line+linelen.
>
> Hmph, none of ">", "F", "r", "o", "m", or " " is "\n"; would eol
> still be an issue?

Ah right. Sorry for being slow.

Your concise version of is_mboxrd_from() is a nice alternative, as well.
