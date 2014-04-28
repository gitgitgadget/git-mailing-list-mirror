From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 12/19] replace.c: use the ref transaction functions for updates
Date: Mon, 28 Apr 2014 08:17:19 -0700
Message-ID: <CAL=YDW=P5ZyXTsnd3VumCrVdH2G1qhMxyJpgkgJJ0Tn50VViaA@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-13-git-send-email-sahlberg@google.com>
	<535AE8FF.80509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:18:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenKZ-0005ny-E7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbaD1PSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:18:50 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:37449 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498AbaD1PRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:17:20 -0400
Received: by mail-vc0-f180.google.com with SMTP id hq16so5613091vcb.25
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X5bwbSXYPVUTUEFzx6zARqqcFBVfwyOHTwwlM28M7To=;
        b=PKe/VdogecY6BrUVcAqOOr5h05Zsev/4+U8nuPdcq/SnwW1Km9AbuV0FWTkA3y8eyX
         qWqJLTxo7lZr3ed4vlybd19OUGqcdQ6glLoduBWdvFz/L3IrNa6lf1lKMiI6VdLJBwVK
         QGhBaAn1cmsLbk3FIWgx0bcEs2PTDZ6pet8AItNqKgtd4wdvCkwj9Pakbe3g52j97PEa
         1TyxzGjT6ClaMCM3MofXj70+Jpqijfi9EtjY0ZWTASCQXb4GJHdQlaBTbjaLnpkfu+Cr
         FcN87tD8dAohgyfP+1MRXBneMBMxD51GnjyTCyFdBhvSr1NqnrJhXuo8O30M4IKsCUsm
         5xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X5bwbSXYPVUTUEFzx6zARqqcFBVfwyOHTwwlM28M7To=;
        b=b7aUKsUipV/rXGfTHtgiiAf2zDhfe8D5y2/SdI/KHX4qY76QB9IVrP9PiJGETLLo8b
         hBj+oUiE8g0IHly6S92plaFTygRzrvHYsjss0L80Os0Ewfh411nGTv/TJW8Q0ezM/WZj
         PuyUIFz7tgPTsbZB4BZyvGex4NAsyICh/vTM4K/EZoij0emtIP3HyRWWi6q4GXaej8tL
         46buFP0wbn7uPsbUZDce9Trn9tdeFSvDq4Da7MS9YxpTk/tHHgiFByYpXTArVlPcKXJ0
         6Un9RIjGoetiW7QCLvcP4Qw0fax9tb2skI/SumHfmxXkS9PDhdf+b4LG2kB5MC+jwx+o
         kCzA==
X-Gm-Message-State: ALoCoQlO0tE3+phq06KCBnxhrwMBmY9Y0RukdqElVW6vkG7VIx1J3TyR85pUiIBrlk0FVjU4njgVGJUyLycwbgGRJPs3M/I0VuEc3Eb3tQblLGqD5rd3XfXB98htcjN2OLlPBaxVLNPNm3QGscZB40h8Ejb9KAenDLIqrM5Y+cgILGEbVroP0dl6OJ2+BnnWr7TFKGAgrzfS
X-Received: by 10.52.250.4 with SMTP id yy4mr465166vdc.56.1398698239379; Mon,
 28 Apr 2014 08:17:19 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 08:17:19 -0700 (PDT)
In-Reply-To: <535AE8FF.80509@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247358>

Done.

Thanks.

On Fri, Apr 25, 2014 at 4:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>> Update replace.c to use ref transactions for updates.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/replace.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index b62420a..cf0f56d 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>       unsigned char object[20], prev[20], repl[20];
>>       enum object_type obj_type, repl_type;
>>       char ref[PATH_MAX];
>> -     struct ref_lock *lock;
>> +     struct ref_transaction *transaction;
>> +     char *err = NULL;
>>
>>       if (get_sha1(object_ref, object))
>>               die("Failed to resolve '%s' as a valid ref.", object_ref);
>> @@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>       else if (!force)
>>               die("replace ref '%s' already exists", ref);
>>
>> -     lock = lock_any_ref_for_update(ref, prev, 0, NULL);
>> -     if (!lock)
>> -             die("%s: cannot lock the ref", ref);
>> -     if (write_ref_sha1(lock, repl, NULL) < 0)
>> -             die("%s: cannot update the ref", ref);
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref, repl, prev,
>> +                                0, !is_null_sha1(prev)) ||
>> +         ref_transaction_commit(transaction, NULL, &err))
>> +       die(_("%s: failed to replace ref: %s"), ref, err);
>
> die() should be indented by two TABs.
>
>>
>>       return 0;
>>  }
>>
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
