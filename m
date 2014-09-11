From: Harry Jeffery <harry@exec64.co.uk>
Subject: Re: [PATCH 2/2] pretty: add %D format specifier
Date: Thu, 11 Sep 2014 18:26:40 +0100
Message-ID: <5411DB50.8080602@exec64.co.uk>
References: <5410C998.5060701@exec64.co.uk> <5410C9EF.9080509@exec64.co.uk> <xmqq61guf641.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 19:26:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS88l-0007Lj-6W
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 19:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbaIKR0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 13:26:32 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:44798 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaIKR03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 13:26:29 -0400
Received: by mail-wg0-f52.google.com with SMTP id x13so6703604wgg.35
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 10:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QYRS3hwrr56bzPznO49lRGm7eygs0rx90g0NaxGHlgY=;
        b=XATTi5rJt16RyH1wMoHJseg/jRp6g+fFBCYvIgVG8ZylTnBPRjrW7jMwV0g22CnyNV
         9grc9BjVFv9125hMVdtSAVvey4xn1Lx42huNvlBXFAnLQlLNspEtSrtzRWp40IdsZsip
         xew6LJ3qc7l2EAnxGoW2oCtVqhd5GMKKytmWxk18ohR58KPJ9ENK/7zhS9XBZfw/Kp9A
         Q6MXUKAHyp/a8AWAto+omAsrEQnxnEy4yk4UCbTrNPDu/3x7fe1AjcdA9busCcEpjwoA
         q+xjauVCV8Gp5uEDo6YMY+T/SXv9b84v6WVoZyaxq+7WhmluqZnUxv1EtaiR5iBTgWIQ
         QfVw==
X-Gm-Message-State: ALoCoQl+jw7yZmX7pD27chPeaL+UwobINndjKnS6lzJTn/9huF8Uridcyh9zBxmQWr/L41301g5v
X-Received: by 10.180.100.37 with SMTP id ev5mr8746544wib.49.1410456383122;
        Thu, 11 Sep 2014 10:26:23 -0700 (PDT)
Received: from [192.168.0.6] (cpc69047-oxfd25-2-0-cust267.4-3.cable.virginm.net. [81.109.93.12])
        by mx.google.com with ESMTPSA id xn15sm6591126wib.13.2014.09.11.10.26.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2014 10:26:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq61guf641.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256857>

On 11/09/14 17:56, Junio C Hamano wrote:
 > Because patch 1/2 alone does not make much sense without 2/2, it
 > probably would have been better to do these as a single patch.

Would you like me to resubmit it as a single patch, or are you applying 
them as is?

 > And of course a few additional tests to t4205 would not hurt ;-)

Sure. Should the tests be in the same patch, or a subsequent one?
