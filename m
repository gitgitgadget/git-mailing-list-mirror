From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 1/2] remotes.c: update calls to new signature for repack_without_refs
Date: Fri, 13 Jun 2014 12:47:00 -0700
Message-ID: <CAL=YDWnq5=3z09huNddO5zW4=uXgc4U3xh_oa2K3R082HvrM_g@mail.gmail.com>
References: <1402674666-6634-1-git-send-email-sahlberg@google.com>
	<1402674666-6634-2-git-send-email-sahlberg@google.com>
	<xmqqwqck1tu2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:47:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvXRL-00052M-EP
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 21:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbaFMTrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 15:47:03 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:47602 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbaFMTrB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 15:47:01 -0400
Received: by mail-ve0-f170.google.com with SMTP id i13so300104veh.15
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y9d220MOTgemXr0yXaMegxyMkWffxrAKjWXGBHFqm+0=;
        b=PROW4M/PAhBzi4xxE5e+BtGWAmm21IZMDpSVnmt3Tg7y2uHY/us9cyUIBQehXaZf6X
         evWm+HeScawirc0IemW2ut4KtVhQPjsLIaN0N/vEZaTySq4sYdMknueW60+hhdJH+RME
         hSvKjI7SgPWxGYZWnkyFcYFIyoyCYehVaxL+JtJRHg/SlfMueg3+LVC3kOB97iJKtTT+
         ZIKftsyy3vaINS/5aRsRWs7Ozvvxyu5KddC38OIZ2ZctZ/JmvS8cVgvYFgK+kFXmLIz0
         VFjOStiorYAeg0VQ5lOLw4plrLoFByoQvrkRDcizW+k3vg9KubYlNJPSoTbpx4ASTaaC
         d2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=y9d220MOTgemXr0yXaMegxyMkWffxrAKjWXGBHFqm+0=;
        b=gB8eyMJTygSC1umapejob06QF2ICaVDrOptHcWZ6ipJ6DfUP20khSpTsl+2jjJChvu
         c6AIDO7F0Mvwppe2/Zmixt0KXyNluHEVrTlpsREBHsQ6YGcRCSXjLUU2ZUiF5qIMtyYo
         xfwH8Kc7BhUPlRReaPJWbN+/mdrZ798WPpE+Yf4tFEpCRb32MHPDPrtHk1nvh3wwTthc
         ldHT0F7InANMdMhz5qDYBwow8P/AmRRzffy3ArKcMpcuPVPF+pBZ2lT0QJBXHCDxY/+A
         SOedI3kH8VEGQQUYzX1QTN0EJJH1RP3E8Ei7FjGjr1/Xy6MDqwyaoadoh+THjcevGJIB
         DWkg==
X-Gm-Message-State: ALoCoQlByyeoJ/z6swD/b2gsg8XIiTdyFx7MB4I2s+QPTGVUlox2BQVJgUpEFyQd5PRK7GRB4zZv
X-Received: by 10.58.219.166 with SMTP id pp6mr3222061vec.1.1402688820263;
 Fri, 13 Jun 2014 12:47:00 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Fri, 13 Jun 2014 12:47:00 -0700 (PDT)
In-Reply-To: <xmqqwqck1tu2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251631>

It should have been in
[PATCH v16 08/48] refs.c: add an err argument to repack_without_refs

but it is not. It must have gone AWOL during one of the many conflicts.
It should be there nevertheless since we change the signature for this
function in this patch.


On Fri, Jun 13, 2014 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> This should be merged into patch:
>> 00c74db refs.c: add an err argument to repack_without_refs
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/remote.c | 5 +++--
>>  refs.h           | 3 ++-
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/remote.c b/builtin/remote.c
>> index c9102e8..401feb3 100644
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -755,7 +755,7 @@ static int remove_branches(struct string_list *branches)
>>       branch_names = xmalloc(branches->nr * sizeof(*branch_names));
>>       for (i = 0; i < branches->nr; i++)
>>               branch_names[i] = branches->items[i].string;
>> -     result |= repack_without_refs(branch_names, branches->nr);
>> +     result |= repack_without_refs(branch_names, branches->nr, NULL);
>>       free(branch_names);
>>
>>       for (i = 0; i < branches->nr; i++) {
>> @@ -1333,7 +1333,8 @@ static int prune_remote(const char *remote, int dry_run)
>>               for (i = 0; i < states.stale.nr; i++)
>>                       delete_refs[i] = states.stale.items[i].util;
>>               if (!dry_run)
>> -                     result |= repack_without_refs(delete_refs, states.stale.nr);
>> +                     result |= repack_without_refs(delete_refs,
>> +                                                   states.stale.nr, NULL);
>>               free(delete_refs);
>>       }
>>
>> diff --git a/refs.h b/refs.h
>> index 1b236f7..db463d0 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -162,7 +162,8 @@ extern void rollback_packed_refs(void);
>>   */
>>  int pack_refs(unsigned int flags);
>>
>> -extern int repack_without_refs(const char **refnames, int n);
>> +extern int repack_without_refs(const char **refnames, int n,
>> +                            struct strbuf *err);
>>
>>  extern int ref_exists(const char *);
>
> How does this related to v16?  The reason I ask is because even
> though v16 0/48 says it is to be applied on 'next' it won't at least
> for me X-< and this is one of the early places where the patches
> fail to apply without adjustment.
