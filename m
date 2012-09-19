From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 2/6] Make 'not ok $count - $message' consistent with
 'ok $count - $message'
Date: Thu, 20 Sep 2012 00:45:26 +0100
Message-ID: <CAOkDyE9oYzxoKGC8q4=whGo7R0krKtRjFoGqLMQu__nJOPd4Cg@mail.gmail.com>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
	<1348074915-19985-3-git-send-email-git@adamspiers.org>
	<7vmx0leg62.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:45:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETxY-0000o3-7P
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab2ISXp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:45:28 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42814 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab2ISXp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:45:27 -0400
Received: by bkwj10 with SMTP id j10so834345bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 16:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=XyNsXhiT2iS1zhJSMBxFZwSexXyjytw3LehdtLhRdfo=;
        b=yKd5rorjIVX8DaHMgP8Ht6E34vPAyuKKzvC0aDhumRqeu5UC1mvT77l47mgF2XYSnm
         zx+7sqHQjOfAuj2Fi5YYxRG10wT8ZTUIqEz++BnOKVhcfs9WLQmAQx3GBayxklRP4lWw
         EhOOhWTG2Bc8XavcNLM7JMgb9AIVgZ7s8DHtTkMdDEqo5A+YM5/DWzXUeAnRICZbhJbj
         e3F+EeRm92Vk2SYtufQnfYvBZJGEDLK1Q44tAHtoY1KBYTM8vrOU4GS1k/8g/DQh+4BY
         Z47k8kwVhT4EKh5mxyETPeiOjV2MMaE99rBRvAU/toWngdoBSODotg1qDjQOiflQ9qCh
         dZ8Q==
Received: by 10.204.152.207 with SMTP id h15mr58001bkw.5.1348098326161; Wed,
 19 Sep 2012 16:45:26 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Wed, 19 Sep 2012 16:45:26 -0700 (PDT)
In-Reply-To: <7vmx0leg62.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Ch3_AKERIChu_Fs0yOuGedC_sdU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206015>

On Thu, Sep 20, 2012 at 12:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> Signed-off-by: Adam Spiers <git@adamspiers.org>
>> ---
>>  t/t0000-basic.sh | 4 ++--
>>  t/test-lib.sh    | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
>>  mode change 100644 => 100755 t/test-lib.sh
>
> Peff might have already pointed out, but this is wrong.  Will queue
> with an obvious tweak.

Oops, good catch.  That's a bug in my emacs config, I suspect.
Thanks for the tweak.  You guys have eagle eyes!
