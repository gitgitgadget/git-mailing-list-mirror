From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 21:02:52 +0200
Message-ID: <51E052DC.3080304@googlemail.com>
References: <7vzjttq9wk.fsf@alter.siamese.dyndns.org> <1373629769-23647-1-git-send-email-stefanbeller@googlemail.com> <1373629769-23647-2-git-send-email-stefanbeller@googlemail.com> <20130712185735.GC8482@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 21:02:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxicL-0003xP-JN
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 21:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305Ab3GLTCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 15:02:53 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38723 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965033Ab3GLTCw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 15:02:52 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so1022453wiw.13
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=cNmDROnkn494mOICt7Npvnib0saOpPXRqdKPlN/MpjY=;
        b=X9GB2yjPl7hwf8ZJZYaiqFSgUSyHtQ48Nyapf2WchkwfeDZQkPiPwk8FQLomeV1PNk
         ugAKCn7U3idO/LJIsax4citlMGR4z3jZgG9P57+opN8Kvsk/yM2lq6LIyr7s/0T/uoG0
         TtRl0AU+HUwTlg9EL6yDHH8D67wnLek0aloAo2X4rdDtmnoUnCGVCh5NWsLC2vzm2ZAJ
         nR/sIXC4AacPTvXWVIFuM51OqV8rDmJxQSfoX6e3xBjrlcnhFEbkeQ8/tGNKSjWBRbKx
         qqpOU48qgCxQQFx8RtUzbnCU325e9vugTGlMdWUOp/GAh/OjVuOYYx1Xuh0/xUS4ep2t
         iQFQ==
X-Received: by 10.194.242.134 with SMTP id wq6mr24443825wjc.94.1373655771424;
        Fri, 12 Jul 2013 12:02:51 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a6sm5035450wib.10.2013.07.12.12.02.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 12:02:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130712185735.GC8482@google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230239>


Which tool would you recommend to sort stuff?
Or rather the exact parameters for /usr/bin/sort ?

Thanks,
Stefan

On 07/12/2013 08:57 PM, Jonathan Nieder wrote:
> Stefan Beller wrote:
> 
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -5,99 +5,146 @@
> [...]
>>  Chris Shoemaker <c.shoemaker@cox.net>
>> -Dan Johnson <computerdruid@gmail.com>
>>  Dana L. How <danahow@gmail.com>
>>  Dana L. How <how@deathvalley.cswitch.com>
>>  Daniel Barkalow <barkalow@iabervon.org>
>> +Dan Johnson <computerdruid@gmail.com>
> 
> Small nit: the sorting looks broken here and in similar places below
> (the usual ordering is Dan < Dana < Daniel).
> 
> Thanks,
> Jonathan
> 
