From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH] http-protocol.txt: Basic Auth is RFC 2617, not RFC 2616
Date: Tue, 17 Jun 2014 10:10:00 +0900
Message-ID: <CAFT+Tg8w+wKeAT751TWRZxzZcN9=UaOq8-iu+023otkaOQC-zg@mail.gmail.com>
References: <539cafe8.c1a4420a.08dd.fffff66e@mx.google.com>
	<539d5765.e9fb420a.5e43.3d3f@mx.google.com>
	<xmqqlhswr9rg.fsf@gitster.dls.corp.google.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 03:10:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwhua-00028b-5A
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 03:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbaFQBKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 21:10:03 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:63534 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaFQBKB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 21:10:01 -0400
Received: by mail-ig0-f180.google.com with SMTP id h18so3651102igc.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=NCBESkWsI2kTgVt5j9gLoUVC9ZEVhJZOYO3fH6Fy7Zs=;
        b=eOw6H2dlJYtpwGVcqTerRfJHO2PLtats5Yt8dcBh8xZPNtFy4A0iTcXOqdoJkr7f8K
         ROjc9zkJDk2zCobyjJg0Kj/SZNnZeLm3GCK8vWYNWnwMwq6dB8cx7KQ60jyrRMYvb1hM
         TcYO5yEy3CNUNmokduueHGJNZZWwKGIsx3Dapb/e76UIWD4fzFU3xEduoAj6j/wwVo8u
         1QxhCyam9gSd0209I7BFAXymgtI6uOsCVk0B7+RWmlrcRmlQV5iGGM9idO8c7IbI0czQ
         y6uXOMhKoH4BFRMUsrkiTxS2pfBFSVtFY7ywVAjYleUtbWjNQL/CnlTpO0sZQZ8LIm7C
         EVxA==
X-Received: by 10.50.178.196 with SMTP id da4mr16802444igc.6.1402967400916;
 Mon, 16 Jun 2014 18:10:00 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Mon, 16 Jun 2014 18:10:00 -0700 (PDT)
In-Reply-To: <xmqqlhswr9rg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251840>

Thanks for your advice. i'll resend it.

2014-06-17 3:26 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Yi EungJun <semtlenori@gmail.com> writes:
>
>> Could you change the author to "Yi EungJun <eungjun.yi@navercorp.com>"
>> if you apply this patch?
>
> You can send a patch with the desired "From: " line that matches the
> identity on the "Signed-off-by: " line at the beginning of the log
> message, like this:
>
>         From: nori <semtlenori@gmail.com>
>         Subject: [PATCH] http-protocol.txt: Basic Auth is RFC 2617, not RFC 2616
>         To: unlisted-recipients:; (no To-header on input)
>         Date: Sun, 15 Jun 2014 04:09:29 +0900
>         Message-ID: <539cafe8.c1a4420a.08dd.fffff66e@mx.google.com>
>
>         From: Yi EungJun <eungjun.yi@navercorp.com>
>
>         Here you write your log message, after a blank line to
>         separate the in-body From: header above with the log
>         message.  And then after a blank line below, you sign-off
>         your patch.
>
>         Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
>         ---
>          ... diffstat here ...
>
>         diff --git a/... diff here ...
