From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH v2 5/5] contrib/subtree/Makefile: clean rule cleanup
Date: Tue, 06 May 2014 07:41:29 +1000
Message-ID: <40d16f4b-440c-4268-bd6a-e7f413d01801@email.android.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com> <1399121375-14727-2-git-send-email-nod.helm@gmail.com> <1399121375-14727-3-git-send-email-nod.helm@gmail.com> <1399121375-14727-4-git-send-email-nod.helm@gmail.com> <1399121375-14727-5-git-send-email-nod.helm@gmail.com> <1399121375-14727-6-git-send-email-nod.helm@gmail.com> <20140505050938.GB6569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, greend@obbligato.org, apenwarr@gmail.com,
	gpmcgee@gmail.com, mmogilvi_git@miniinfo.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 06 19:10:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiAM-0007Xo-PE
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335AbaEEVll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 17:41:41 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:44297 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756175AbaEEVlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 17:41:40 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so1882614pab.7
        for <git@vger.kernel.org>; Mon, 05 May 2014 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=tIb7UBD8Zo1Bb1Vrs1Zc9rfz/YjwztYyWBX6eOTffsc=;
        b=ch9ygbxvXPsAmmR6qfU/QigNwW1wRtxXQt/lov2OG2NUkXlntlIgYZrzrgyjsj31Iw
         JcC1TDUF5z2PORmEGgv3UTkK2okkSunkuHqGWsgxQKgM3GMWAwlPE3lhnhclMiFuxQrc
         2cWXcZRoTS/+2m6ZYnxhFJGRegkYZZtt8LEndg2yVi83JQdxKUA0REfohM8sAxMOjOnS
         JPpFuQ4INAXXlOLx3Ft5WrfbBmDjRnmfeg9Wq4gctpoSaKvU/rjPmpMH7RGMZVMtiNNr
         I6U0DoR677xNW8of8YoktBH2FsRLVcxPFKslNnLzQrnIvYmu4bLTmt6ot8rErpLd3YaY
         /O7w==
X-Received: by 10.66.141.144 with SMTP id ro16mr75942314pab.131.1399326100332;
        Mon, 05 May 2014 14:41:40 -0700 (PDT)
Received: from [10.94.103.239] ([101.119.29.90])
        by mx.google.com with ESMTPSA id bs17sm81218684pac.28.2014.05.05.14.41.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 May 2014 14:41:39 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <20140505050938.GB6569@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248174>

On 5 May 2014 15:09:39 GMT+10:00, Jeff King <peff@peff.net> wrote:
>On Sat, May 03, 2014 at 10:49:35PM +1000, James Denholm wrote:
>
>> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
>> index f3834b5..4f96a24 100644
>> --- a/contrib/subtree/Makefile
>> +++ b/contrib/subtree/Makefile
>> @@ -11,8 +11,9 @@ man1dir ?= $(mandir)/man1
>>  
>>  -include ../../GIT-VERSION-FILE
>>  
>> -# this should be set to a 'standard' bsd-type install program
>> -INSTALL ?= install
>> +# These should be set to 'standard' bsd-type programs
>> +INSTALL  ?= install
>> +RM       ?= rm -f
>
>I do not think BSD-ism matters for "rm", as it works pretty much the
>same everywhere. "install", on the other hand, is a bit weirder between
>systems. So you might want to leave that comment as-is.

True. I might just buff that out when sending the patch to Junio, unless
protocol dictates otherwise - a reroll for a single comment line seems
a bit excessive to me at the moment.

Regards,
James Denholm.
