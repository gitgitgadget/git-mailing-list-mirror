From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH v2] Place cache.h at the first place to match general rule
Date: Sun, 2 Mar 2014 15:59:53 +0800
Message-ID: <CAJr59C2xV43P2cZv-V5rm0-ea3G1W7BGK9exA=0obPgEHUsGEA@mail.gmail.com>
References: <1393726697-2816-1-git-send-email-sunheehnus@gmail.com>
	<CAPig+cRAni1m2xReUvFkx1muvzTLGo1PF8iTuQdXUzLn3yXNkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 09:00:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK1K7-0002Bm-No
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 09:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbaCBH74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 02:59:56 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:54360 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbaCBH7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 02:59:55 -0500
Received: by mail-wg0-f45.google.com with SMTP id m15so1931793wgh.28
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 23:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=NH70aCwf9MY18LnP9ztgA+Ptqd381Tib+FqLdyaLn6E=;
        b=umbuGf4MxUM9t9tw/go1mb0xv/Qbpjn/bul1NFm3Aj4naU4iSwOpjgDNRWoUQPv4bC
         YYKDSY9Zd8WwhKSJQ2zjB3VqOlIrwA2wq0BbkddCAJAz61mTsU37nYti6joQGrBYRwG1
         M93SZA0B52dOz8TuGT5VoMkyVBcak/Ivkst+872g7zhJo+wMCkky9IylI6yq67ehEaC0
         eOiKQ8WFa4OZthOxbIWX1IBKAfIRLEO74sl5zrf7Nwbd+R11wYjLaSwDPkETPC28m3H0
         zyc1MSnp9sUaB0/X9+I06k8Nzm45BlcC12t/7fvIfucBmeAH7v9S1YRFTPSJnjFJExy0
         IEQw==
X-Received: by 10.180.205.130 with SMTP id lg2mr9958712wic.59.1393747193989;
 Sat, 01 Mar 2014 23:59:53 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sat, 1 Mar 2014 23:59:53 -0800 (PST)
In-Reply-To: <CAPig+cRAni1m2xReUvFkx1muvzTLGo1PF8iTuQdXUzLn3yXNkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243138>

2014-03-02 12:34 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Sat, Mar 1, 2014 at 9:18 PM, Sun He <sunheehnus@gmail.com> wrote:
>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>> Helped-by: Duy Nguyen <pclouds@gmail.com>
>
> Footers should follow a temporal order. For instance:
>
> 1. Duy helped you.
> 2. You revised your patch based upon his input.
> 3. You signed off before submitting the patch.
>
> Hence, your Signed-off-by: should follow Helped-by:.
>

OK, got it.
Thank you very much.

>> ---
>>  "PATCH v2" Fix the spelling bug of general in subject as is suggested
>>  by brain m.calson <sandals@crustytoothpaste.net>
>
> There are two type of information you want to convey to readers:
>
> 1. Explanation and justification of the change itself. This is
> recorded for all time in the project history as the commit message. It
> is placed above the "---" line.
>
> 2. Commentary related to this version / submission of the patch which
> is not likely to be helpful or meaningful to people reading the
> "official" project history via the commit messages. It is placed below
> the "---" line.
>
> Explaining what you changed since the previous version of the patch,
> as you do above, is a good thing. It's not meaningful once the patch
> is officially accepted into the project; it's only meaningful to
> people following the progression of the patch on the mailing list, so
> it definitely belongs below the "---" line, as you did here.
>
> However...
>
>>  The general rule is if cache.h or git-compat-util.h is included,
>>  it is the first #include.
>
> This information explains the patch's purpose, thus it is relevant to
> the project history. It belongs above the "---" line.
>

OK, Got it. I will move above the "---" line soon, and I will pay attention
not to make mistakes like this from now on.
Thank you very much.

>>  I parsed all the source files, and find many files start with builtin.h.
>>  And git-compat-util.h is the first in it. So they don't need any change.
>
> This could go either way. It tells how you arrived at this version of
> the patch (relevant below "---"), but also explains why the patch does
> not have to touch additional files (relevant above "---"). It's
> probably okay to leave it below "---".
>
>>  sigchain.c and test-sigchain.c are started with "sigchain.h"
>>  I checked sigchain.h, and it didn't import any bug.
>>  But to keep consistant with general rule, we should take this patch.
>
> Commentary suitable for below "---".
>
>>  Thanks.
>>
>>  sigchain.c      | 2 +-
>>  test-sigchain.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sigchain.c b/sigchain.c
>> index 1118b99..faa375d 100644
>> --- a/sigchain.c
>> +++ b/sigchain.c
>> @@ -1,5 +1,5 @@
>> -#include "sigchain.h"
>>  #include "cache.h"
>> +#include "sigchain.h"
>>
>>  #define SIGCHAIN_MAX_SIGNALS 32
>>
>> diff --git a/test-sigchain.c b/test-sigchain.c
>> index 42db234..e499fce 100644
>> --- a/test-sigchain.c
>> +++ b/test-sigchain.c
>> @@ -1,5 +1,5 @@
>> -#include "sigchain.h"
>>  #include "cache.h"
>> +#include "sigchain.h"
>>
>>  #define X(f) \
>>  static void f(int sig) { \
>> --
>> 1.9.0.138.g2de3478.dirty


I am honored to get detailed guidance from you.
Thank you very very much.

He Sun
