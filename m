From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v4 37/38] i18n: unmark die messages for translation
Date: Wed, 8 Jun 2016 17:21:47 +0530
Message-ID: <CAFZEwPP0U4BbqfJ-a4GfnXq15CR6KVsM2yBCK6heNgx70Ojscw@mail.gmail.com>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
 <1465304141-9392-8-git-send-email-vascomalmeida@sapo.pt> <xmqqtwh4odp6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 13:51:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAc1Z-00054T-PY
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 13:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022AbcFHLvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 07:51:50 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34424 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcFHLvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 07:51:48 -0400
Received: by mail-yw0-f195.google.com with SMTP id j74so614307ywg.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5czZK6O141rv5ckh3ysQo8OyyO1JoGM8siDmOS3Jfgw=;
        b=aI6tne7baIDE1bgNuyA4UIhkX26TaN+jwmyuHQHUHka06OR6xZ7nW658m3HkClE5Tn
         tYFHeFN5go9KUxjFVQ+XGgGOCfatuaUkXwV1vuzkbeVkJ4biKUw3aXUDVhBairo3Zbh6
         W9v2q6Tf8kgXbIdDh0t1rXO4Tb67qmj8sQXa0dAFpOx7imvVH0u4csnEw8NYiqBoNiU4
         uIwTYjsLVv0Yhs+tfG16DNdsnGyeqbi+nM5Rv4AcAlFXXTJnfDreH1diutFQ4Q+ZJwRx
         yvEZ7yE6+uP4PPiy0Vbcux9FT+ikIcFV4t4eiCxxVfKI1rApx2AGzsHb7G8R/OBn4G3T
         2VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5czZK6O141rv5ckh3ysQo8OyyO1JoGM8siDmOS3Jfgw=;
        b=JkNbhgb7x4ngEXVAANFesnXMZmWNc2WRrLjXt1CeYnGlB5oI3/+qMPaBPz6zpTsAzT
         IKQ2cg78ndMG8dTq/Uoj33EH4HPhYevo3PCxLliyoeSKMIkySc3ZBTso0zAIWT5jvh49
         oF1o7iVCDv9wPmPzLjOUdB3y9XswuQQtqLN2JVV7ecTaHi+b0C1D9pZ54LGX2bNQgV7B
         PIRUNMfT65MU8fcIytMkKAy4qI90BVwjUFeGqd80vwHOq79I7iwHneBxHbdKcxqVHFME
         wOQTRSk2PSy/3KgiS3+H+/UHXmvg/lob968E6Y7FyG/wpi7lpvFOMjHMpQuZU933cyM/
         MURg==
X-Gm-Message-State: ALyK8tIlLyiwhBsA6WsrC/3jlFoLZPZqqxNrxIYRalIp3ZahF1fqqT4zRxGDfUc+PEXLzUNRpeb7++Qyvb4uMw==
X-Received: by 10.37.231.81 with SMTP id e78mr2367330ybh.7.1465386707811; Wed,
 08 Jun 2016 04:51:47 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 04:51:47 -0700 (PDT)
In-Reply-To: <xmqqtwh4odp6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296784>

Hey Junio,

On Wed, Jun 8, 2016 at 3:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>
>> These messages are relevant for the programmer only, not for the end
>> user.  Thus, they can be unmarked for translation, saving translator
>> some work.
>>
>> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>> ---
>>  git-bisect.sh | 2 +-
>>  wt-status.c   | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index 30d01bb..ae3cb01 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -274,7 +274,7 @@ bisect_state() {
>>       check_and_set_terms $state
>>       case "$#,$state" in
>>       0,*)
>> -             die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
>> +             die "Please call 'bisect_state' with at least one argument." ;;
>
> OK.  This should have had "bug:" prefix from the beginning, but that
> is outside the topic.

I can probably include this with the rewrite of git-bisect.sh .

Regards,
Pranit Bauva
