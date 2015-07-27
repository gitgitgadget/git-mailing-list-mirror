From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Mon, 27 Jul 2015 21:27:29 +0530
Message-ID: <CAOLa=ZSXD-pjgYCOt+ZcYS4uHS0p2uBYX8Rw80xpL+9pNUvm+w@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
 <vpqtwsp92wf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 17:58:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJkmz-0004pt-0p
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 17:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbbG0P6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 11:58:00 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34826 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbbG0P57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 11:57:59 -0400
Received: by obbop1 with SMTP id op1so62742264obb.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Tpclu2Qia4VzzM55T8xcJDThACLGGMftWDQzlp0CnME=;
        b=gvtAoRgj+0ULbje/of8zRoyBrLKTTpXO8xYXgFnKUe+K4bTcBmLcF73FciBeXQo842
         TG5WQt9NCUcqTD5FIPHYQTz7tagcOD81X/i45L3+daMvq1ntVGQcyV07mqDPRu2ylvyu
         TBJ7/HyVmcL4IDmQ7BEbkzf9jms0984OcGjNWO5RksvACNt0m2I/6hiGQ1h0bQij8uTz
         fQWQJOS11HtV841QnpxVXJGecNopR6fRAwnFlywkh/8k71NVUaIqzoSD+DbFXoaOmHyo
         vOkshddlHig5vgWmU3/6AwGbjioT7BVE0b+JjFMyl2zH9P9Mm6d7YRkubmyVdSQHWpVQ
         r7tQ==
X-Received: by 10.182.153.161 with SMTP id vh1mr28256995obb.34.1438012678751;
 Mon, 27 Jul 2015 08:57:58 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 08:57:29 -0700 (PDT)
In-Reply-To: <vpqtwsp92wf.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274686>

On Mon, Jul 27, 2015 at 6:24 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -946,6 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>
>> +/*
>> + * Return 1 if the refname matches one of the patterns, otherwise 0.
>>   * A pattern can be path prefix (e.g. a refname "refs/heads/master"
>>   * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
>>   * matches "refs/heads/m*",too).
>
> Nit: you used to s/,too/, too/ in the comment in a previous version.
>

That's carried over from a previous patch, ill change it.

> I think I already suggested saying explicitly "... matches a pattern
> "refs/heads/" but not "refs/heads/m")", but I won't insist on that. Just
> a reminder in case you missed it.
>

Sorry, I missed that out. Thanks for reminding.

-- 
Regards,
Karthik Nayak
