From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Wed, 10 Jun 2015 17:01:16 +0530
Message-ID: <55782004.3080600@gmail.com>
References: <5573520A.90603@gmail.com> <1433621052-5588-1-git-send-email-karthik.188@gmail.com> <1433621052-5588-3-git-send-email-karthik.188@gmail.com> <xmqqzj4a9fpn.fsf@gitster.dls.corp.google.com> <5576D591.6030704@gmail.com> <xmqqvbew66q9.fsf@gitster.dls.corp.google.com> <vpqeglkc8qh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 13:31:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2eEG-0008CO-5N
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 13:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbbFJLbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 07:31:23 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34332 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbbFJLbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 07:31:21 -0400
Received: by payr10 with SMTP id r10so33317170pay.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OY8atTCgjPNR1xAY6kLRZQagEhOVnFiPTLh3BXRKk0g=;
        b=QcVyuI4/yUx8pLqD975yNJP6dWLwUPvaiPfTmSe1mcy7RxENqyjO93ri73B44+B6VV
         q+lDutvxztIHIxlAcpytwBNyvJN5TuBL7E32nhlou6+5ubohnmZle6Ip8hjc6qxdIiig
         c19rpNAOK2XDXKHUzytcATAx7T4fT7WJcH2Bln75yy1NdsPTASHsGdmxS+RpCTrzqfvy
         wiFSwiyqsf/vBY+lK6fccfGqSix376aQoG8NgZY0uDcoUmfbBEnt6p4DL3qDJDdXjOFv
         8tMg0T988u35CsF33WmnR/2pZp6pO2bYjRaTad+GgqZ0FbksPTOUDeJoACJqweqXTrt5
         nfKA==
X-Received: by 10.70.40.131 with SMTP id x3mr4974908pdk.83.1433935881385;
        Wed, 10 Jun 2015 04:31:21 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id i1sm8400320pdm.19.2015.06.10.04.31.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 04:31:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqeglkc8qh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271284>

On 06/10/2015 01:09 PM, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Don't do that.  Always start your function like so:
> >
> >     type funcname(args)
> >          {
> >              declarations;
> >
> >                  first statement;
> >         ...
>
> Hint: create a file config.mak with this content:
>
> $ cat config.mak
> CFLAGS += -Wdeclaration-after-statement -Wall -Werror
>
> and gcc will prevent you from doing this mistake again.
>

Thanks a lot!
Your tips are brilliant.

-- 
Regards,
Karthik
