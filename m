From: Justin Lebar <jlebar@google.com>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments. (v3)
Date: Mon, 31 Mar 2014 14:04:43 -0700
Message-ID: <CAMuNMfpnojdQi4x_M_k29GBsq_i282Zph3AgLgsZv4arxB3CfA@mail.gmail.com>
References: <1396133950-5285-1-git-send-email-jlebar@google.com> <CAEjxke9pe23YAc_D-JmAd+HkgocNuTrwQxSkGS7DaJhgw9GMRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:05:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjOM-0003qI-24
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbaCaVFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:05:06 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:42342 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaCaVFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:05:05 -0400
Received: by mail-qg0-f45.google.com with SMTP id j5so8118343qga.32
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ot+CZ12isk/Z/zON+ih22qwGwf3uPIxRsbtTiQxx/7k=;
        b=ptTWfzzgGkrgp420pRvtuZNVRbb2qdVKVgjWOdhY1lNU796kTl2mOTExOlEZfguIYZ
         uIKu2bOmVFqyhzhGYAOrminf0CngK2ulaJjGTx8M6C0aYtMSZnB+UNutYpfpSVApABXR
         yMRSM0C20VCNDXX8Ie/0F3daHpBrONypb7eusBslDsXlW/7JPsM/MrpoTvuZn+bq6qTQ
         LJ9FaFU+FhCTSg8orxJKO2figwOQFg0mkJnMRRiu12F4SMGYFHivyonZbB83Xo0AmhfY
         sJ1/yB6hs7pq90f0u8jrgdAYZWEOEKsaoZGjVLa5Bp+6ziF+ypmECuZDCf3KTeUsxEZ2
         fkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ot+CZ12isk/Z/zON+ih22qwGwf3uPIxRsbtTiQxx/7k=;
        b=iSRxrcDdgJeqylsPQb1jF6JcSxjrl7GOBAR2Pm9sUXuutmvDIkxpYznjWhVbsLexRR
         gSDMEgm73byvIVl/fJlsIP+hrvJPzOHaWmicmd4xRUPUOGgKNCk9qF1bWx881WqJ0HvL
         v6qjIvcqX512L5nZLCj5WpthS71pubj3xSqSpQf5S7p1uHcULGCPwz7apIoXtHt3l74M
         txcuuVmHlO+IukhNf1WHRc31yOOFZb8JyHQk2oHSX1wKXg8rAKGouf3QID1jJ5at/iji
         5jv5GbYMm4D+N1nS3i3lvSsEOx/W78ws9/Wthh0htIbtVtf9lt4HUkazhRvczhdwBx7C
         SbMQ==
X-Gm-Message-State: ALoCoQkgoUCviBdTtkiwT2OWy2wDtAtsruhtKn1HfJJWzEL5RSMoeOGtWg/uXm1BAC3+3W2CgkaMJKfdXGOLmUrbT4hNuw5Q1ndcpADfaF0MzGV/dZ6Hc3h2AgP0Q4UfqxhOF21qi2BqUcmUc862d8/77F+1JzcIYr+1luXi+WLKv3sntBdeJV0UAmuwITlBEGr0paygh/u8
X-Received: by 10.224.125.194 with SMTP id z2mr5072421qar.99.1396299903920;
 Mon, 31 Mar 2014 14:05:03 -0700 (PDT)
Received: by 10.96.69.36 with HTTP; Mon, 31 Mar 2014 14:04:43 -0700 (PDT)
In-Reply-To: <CAEjxke9pe23YAc_D-JmAd+HkgocNuTrwQxSkGS7DaJhgw9GMRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245529>

Thanks; fixed in v4 (just sent out).

On Mon, Mar 31, 2014 at 12:54 PM, Jason St. John <jstjohn@purdue.edu> wrote:
> On Sat, Mar 29, 2014 at 6:59 PM, Justin Lebar <jlebar@google.com> wrote:
>> This version applies successfully to master, maint, next, and pu.  The other
>> patches in the previous version of this queue apply successfully without any
>> changes.
>>
>> Signed-off-by: Justin Lebar <jlebar@google.com>
>>
>> ---
>>  Makefile                                    | 2 +-
>>  builtin/apply.c                             | 2 +-
>>  builtin/checkout.c                          | 2 +-
>>  builtin/log.c                               | 2 +-
>>  builtin/pack-objects.c                      | 2 +-
>>  column.c                                    | 4 ++--
>>  contrib/examples/git-checkout.sh            | 2 +-
>>  contrib/examples/git-reset.sh               | 4 ++--
>>  contrib/fast-import/import-directories.perl | 4 ++--
>>  delta.h                                     | 2 +-
>>  diff.c                                      | 2 +-
>>  git-am.sh                                   | 2 +-
>>  gitweb/gitweb.perl                          | 2 +-
>>  http.h                                      | 4 ++--
>>  perl/Git/SVN.pm                             | 2 +-
>>  perl/Git/SVN/Migration.pm                   | 2 +-
>>  pkt-line.h                                  | 8 ++++----
>>  remote.c                                    | 2 +-
>>  sha1_file.c                                 | 2 +-
>>  test-chmtime.c                              | 2 +-
>>  20 files changed, 27 insertions(+), 27 deletions(-)
>>
>
> <snip>
>
>> diff --git a/http.h b/http.h
>> index cd37d58..0a7d286 100644
>> --- a/http.h
>> +++ b/http.h
>> @@ -13,8 +13,8 @@
>>  /*
>>   * We detect based on the cURL version if multi-transfer is
>>   * usable in this implementation and define this symbol accordingly.
>> - * This is not something Makefile should set nor users should pass
>> - * via CFLAGS.
>> + * This shouldn't be be set by the Makefile or by the user (e.g. via
>> + * CFLAGS).
>>   */
>>  #undef USE_CURL_MULTI
>
> There's a rather minor typo here: "be be"
>
> Jason
