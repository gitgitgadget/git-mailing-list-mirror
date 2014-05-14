From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Tue, 13 May 2014 21:16:37 -0500
Message-ID: <5372D205.4040004@gmail.com>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com> <xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com> <53729b2150a84_34aa9e5304e0@nysa.notmuch> <xmqq38gdmhdo.fsf@gitster.dls.corp.google.com> <5372a0f6650d2_36c411ff3002e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 04:16:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkOkN-0006UO-AY
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 04:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbaENCQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 22:16:39 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:56269 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaENCQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 22:16:39 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so1194667iec.25
        for <git@vger.kernel.org>; Tue, 13 May 2014 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=o1XwIZhI4A1O9BkErZ6tY9C7GW+ao+rt99CtFAwZCy4=;
        b=gDjOet0eo1XBMlJLc6tvgQWlaInWpkv+6o+j7XiWg6YsuJ86IvIRJ+DxHT15rnjbJm
         SSBrGjzCK4FjsQ+pf+pTvmzfErNdOTqZd7KzACsWGtJLmUg0exrkebVLx86H/N6xO846
         J8BFaMtJ/4N59aQh2mwEA6cU+gxBsg9UciVzF2kM3CQTW/tS8kt17rpuSi62kpM78cJf
         moFsfay1riQv8/tVtW4/5EAV3dWvKFfTKX9lPboYNipuRIrBoXktF3a0kpCdQh94SipW
         cNlzNJrKUUkO/PNv96h0Fm+DF1ewpmGEZy+9G9nNJBeF6lX/qVykfOVOq8B7ISx5gNhH
         EqTg==
X-Received: by 10.43.35.143 with SMTP id sw15mr490375icb.29.1400033798406;
        Tue, 13 May 2014 19:16:38 -0700 (PDT)
Received: from [10.0.0.29] (c-98-197-19-2.hsd1.tx.comcast.net. [98.197.19.2])
        by mx.google.com with ESMTPSA id y15sm1919003igy.2.2014.05.13.19.16.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 19:16:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <5372a0f6650d2_36c411ff3002e@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248894>

On 5/13/2014 5:47 PM, Felipe Contreras wrote:
> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Sigh, you just don't seem to understand that you are thinking
>>> about a different issue. I don't think there's any other way I
>>> can explain it to you.
>>
>> Perhaps pointing out which commit(s) to revert might be a good
>> point to start.
>
> Oh, now you realize it might be nice to avoid this regression I
> warned you about.
>
> Why don't you continue schooling me about what constitutes a
> regression? I'm such a slow learner.
>
> I was going to do more than pointing to commits, I was going to
> provide the fixes with test cases and a detailed explanation. But
> then you made your decision.

I believe the regression in question, mentioned at the bottom of this post
 
http://thread.gmane.org/gmane.comp.version-control.git/248263/focus=248269

     "Since you are not going to do so, I do not feel compelled to fix
      the synchronization crash regression that is present in v2.0.0-rc2
      and I already warned you about."

is referring to this patch
 
http://thread.gmane.org/gmane.comp.version-control.git/247546/focus=247549

but I admit, I'm getting a bit fuzzy around these discussions.

-- 
.marius
