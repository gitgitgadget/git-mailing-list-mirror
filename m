From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 11/19] tag.c: use ref transactions when doing updates
Date: Mon, 28 Apr 2014 08:15:23 -0700
Message-ID: <CAL=YDWk_7+GGocnvdf314xHnYEUgWGxzndbFQmOoQ927zob8Vg@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-12-git-send-email-sahlberg@google.com>
	<535AE89B.2000408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:39:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wenel-0005Ut-2A
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbaD1PP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:15:26 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:56943 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbaD1PPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:15:24 -0400
Received: by mail-ve0-f173.google.com with SMTP id oy12so8112750veb.18
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LKF956YfgGSshlG4FeQ5wrQk+wh+Q+M3Cq/a9FKxDT0=;
        b=QlNmMP00IDgkA26hoUMBH95tJuu3q3Ys4ajpRU/x1R3aRIfoVVMYRmZTWR/VElH78q
         yGqjNU6j5ed85lDiclStLBWejEkdbU9D95qNjtr7jmia15L4At9zsp7NgbidnLU26ZI9
         k2YT5kRDcl6a4ikUP6vF7yQWmpfdiTk8+8RWd2hMlSlFtPUe9PZSTTE4XPrQbOX3OBLP
         QpxnDv6CBTloyHnGuOKDW94LvWqFSZz6BP2Y3XogE1tqI8JhSXc8xDyX1X0Q7FxCNrvo
         IjF5uMxbAT0gtgjpF7FtL+VTaTRj4PEmeVjf09D/3koRBobAHQmZoVa+kbGx8B0EaSGN
         N7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LKF956YfgGSshlG4FeQ5wrQk+wh+Q+M3Cq/a9FKxDT0=;
        b=M5NB8wzb8u6hBCfvdsZnKMfWYpbIWENsjQHR6kxE4UFuRjU6LWQ0iIEFbPK+wDwYPk
         c1AOErZruCMVDe1HdmmqxNRVIx66U/ytT3s/289Q2vDFPBHrIh8hVNcgz8iViJNR3IYZ
         TqNAI+hRr3CpgcTuLNa0QFh4XF/MTHDMykiQ4W0MTxEDS6lhKitea7s0n+D9dIpohcXM
         kBSOHN6x/qVWMVp6qMK5pJR8KKkNjvtdc6SvVUeqlRlXL6NSVWvmWVHuAk+ctaDXFmyH
         xXhxHWc12S7Psyc+gNYmPVlDou/KMPAApzL/6Cws5UWXZYAFG1YW88PRXUVxuPZCsOMm
         aB7Q==
X-Gm-Message-State: ALoCoQkY3ilChs8hf3ivsN8QIBvtHCVFLSBeeQ9TfVZ7Eknnitay0yjH50ww8Uqlfv/hL+qIO32olIb89SNREN2r+BAyEWm700tmV8UHWETg4BKem4c/pgQH+p0TagcBp3X5CQy36b5wvN0qixRG5nNS35pqaZ6VYcgdmjQIDqQaGRzM1A8jVr5YNk01giEqOQX5Wejq/3lS
X-Received: by 10.52.118.212 with SMTP id ko20mr40652vdb.77.1398698123501;
 Mon, 28 Apr 2014 08:15:23 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 08:15:23 -0700 (PDT)
In-Reply-To: <535AE89B.2000408@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247369>

Done.

Thanks.

On Fri, Apr 25, 2014 at 3:58 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>> Change tag.c to use ref transactions for all ref updates.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/tag.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 40356e3..dd53fb4 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -488,7 +488,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       struct strbuf ref = STRBUF_INIT;
>>       unsigned char object[20], prev[20];
>>       const char *object_ref, *tag;
>> -     struct ref_lock *lock;
>>       struct create_tag_options opt;
>>       char *cleanup_arg = NULL;
>>       int annotate = 0, force = 0, lines = -1;
>> @@ -496,6 +495,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       const char *msgfile = NULL, *keyid = NULL;
>>       struct msg_arg msg = { 0, STRBUF_INIT };
>>       struct commit_list *with_commit = NULL;
>> +     struct ref_transaction *transaction;
>> +     char *err = NULL;
>>       struct option options[] = {
>>               OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>>               { OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
>> @@ -641,11 +642,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       if (annotate)
>>               create_tag(object, tag, &buf, &opt, prev, object);
>>
>> -     lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
>> -     if (!lock)
>> -             die(_("%s: cannot lock the ref"), ref.buf);
>> -     if (write_ref_sha1(lock, object, NULL) < 0)
>> -             die(_("%s: cannot update the ref"), ref.buf);
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref.buf, object, prev,
>> +                                0, !is_null_sha1(prev)) ||
>> +         ref_transaction_commit(transaction, NULL, &err))
>> +       die(_("%s: cannot update the ref: %s"), ref.buf, err);
>
> Formatting nit: die() should be indented by two TABs.
>
>>       if (force && !is_null_sha1(prev) && hashcmp(prev, object))
>>               printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
>>
>>
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
