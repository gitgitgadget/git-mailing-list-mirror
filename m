From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] fast-import: Remove redundant assignment of 'oe' to itself.
Date: Sun, 26 May 2013 22:23:32 +0200
Message-ID: <51A26F44.4020406@googlemail.com>
References: <1369598719-10798-1-git-send-email-stefanbeller@googlemail.com> <51A26BB7.3060702@gmail.com> <51A26D0D.2030702@googlemail.com> <51A26DBD.80106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 26 22:23:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UghTU-0004as-0P
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 22:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab3EZUXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 16:23:24 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:52239 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab3EZUXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 16:23:23 -0400
Received: by mail-ee0-f54.google.com with SMTP id e50so3707867eek.13
        for <git@vger.kernel.org>; Sun, 26 May 2013 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=13xEH24wZeNQIPiRiviGPtW25krcowItz+jlbDWusK4=;
        b=oZAQWwpcdn+XspA64e8PxREG7g47JRGdk5zvCxy3Y/ndbX0lXBsl2kXm8ZXIm15Z4Y
         JZu3l+rxyhjayA1ZKaKVNyp03QSxGOocPWU3n2RUwnJqDaK86Kh0YD4OM7w7IvQN8jV4
         389Wa6IcDUOaODUatAl/PsG3z3thzptZSCt6ib3A7ZvJ4PiwWHf6qQu4F5umg7t8+krt
         tM49EF9U7CU/QHsllp+y+XMrkaLxqUGcFGmzpRyRmRFytmaQgYiqL276TkcaXQQaVXZ9
         DLzLMmSf/m3Sux+w2tBpwlGInFw8RLkRaIgwvng4nGi8C8bnv/CigDgXMa168ElrWXKG
         Im1g==
X-Received: by 10.14.246.137 with SMTP id q9mr50584561eer.39.1369599802493;
        Sun, 26 May 2013 13:23:22 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-90-70-123.unitymediagroup.de. [109.90.70.123])
        by mx.google.com with ESMTPSA id e1sm2973730eem.10.2013.05.26.13.23.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 26 May 2013 13:23:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51A26DBD.80106@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225570>

The line in question was not fixed up, but originally added in
85c6239. However I see your point, it may reintroduce warnings.

Regards,
Stefan

On 05/26/2013 10:17 PM, Stefano Lattarini wrote:
> On 05/26/2013 10:14 PM, Stefan Beller wrote:
>> It's not done very often.
>>
> Of course; it's done only in those places where GCC gave spurious
> warnings.  And it's done for no other reason that to silence said
> warnings.
> 
>> [SNIP] rest of message
> 
> Regards,
>   Stefano
> 
