From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] make pull.ff=true override merge.ff
Date: Mon, 18 May 2015 11:22:53 -0700
Message-ID: <xmqq1tidd9tu.fsf@gitster.dls.corp.google.com>
References: <1431956742-25992-1-git-send-email-pyokagan@gmail.com>
	<b81cabf10169c5be05099addbe6e4d27@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 18 20:23:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPgq-0001DR-8D
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbbERSW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:22:56 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37889 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbbERSWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:22:55 -0400
Received: by igcau1 with SMTP id au1so54824544igc.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DSG5bYqUHC32OF1sy1zaPyuO1EA4NHqA28aDBImgUp0=;
        b=iVu8kjmoricGYr4eD9Xz213/NbZEGSF7f1hemfJOTAN5tyLePhbSoHvKlCKACzYkeT
         xiZ4egecHmLPCnBi2Gvxj662EdyNNjrI02K5tdNubySh9FvLLGgGDIeOtjJeBVShx6/s
         /2B+Yt9D2Fqhn5ujuewua7EJJhyQPtkEyr7y0Ue1flkLQ25ZXNPrv97ObSofFukhYhAf
         6Ip8lJXZYuBLq5oxfkpfX2hQeoYC0R8oflVMXuPzD86JG91NDnW8epJLnpO9ytC2y8l4
         pzH/wK7N0lzYyoyWs0mNDhJfAb6wGD+OXqC8n53x0f/ZYuxLhgOjL8eG9znHD5Mk4IAK
         Xt4A==
X-Received: by 10.50.13.67 with SMTP id f3mr16216846igc.12.1431973374972;
        Mon, 18 May 2015 11:22:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id i4sm6377898igm.2.2015.05.18.11.22.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 11:22:54 -0700 (PDT)
In-Reply-To: <b81cabf10169c5be05099addbe6e4d27@www.dscho.org> (Johannes
	Schindelin's message of "Mon, 18 May 2015 16:46:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269293>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Paul,
>
> On 2015-05-18 15:45, Paul Tan wrote:
>> This is a re-roll of [1], primarily to remove the use of "verbose".
>
> I think these two patches are good to go now.
>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Ciao,
> Dscho

Yeah, looks good.  Thanks, both.
