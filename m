From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Mon, 27 Jul 2015 21:29:37 +0530
Message-ID: <CAOLa=ZT58Fai++91AUH2VcerH5OLkbC3thoGtqVYC70R8gSkaA@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
 <vpqtwsp92wf.fsf@anie.imag.fr> <CAOLa=ZSXD-pjgYCOt+ZcYS4uHS0p2uBYX8Rw80xpL+9pNUvm+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 18:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJkpA-0006mr-Cn
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 18:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbbG0QAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 12:00:09 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34121 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbbG0QAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 12:00:07 -0400
Received: by oigd21 with SMTP id d21so53987544oig.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7jEgHlEZNOeWOC07ywXBcjZWI+BUz2F9Y13j2XKyFUU=;
        b=OJDK2HjreJiqcNG70zxWJqiBGihTqpeeEIN26MtTswYi8ijrpl7vFSqUbzcDiwEGDa
         jTJk08XVDOFQZNRTsigo+lFcXb/jNLoeqYgua3wyqLSHMXs8VuhD0wA5bKKFYIKwSaPW
         QCURBvh/VzKZz0BJ7N7v05h9kjos3mbj/8hXjU2gq5f1ojETp3yq8Q/A/BSYghlXmHUv
         vNOMoWRSo//BqkyhWsYuGcYEE8kJ3iHnvTRxTPgYYah6XRw7hlIh5GzOS4qw0kL4ZHa3
         9WfVt763HdQef7jeTrNuN/WehkkFYH+9KXMTk58bLccjjQ00zgnDqlYo6Tzd0gwivqel
         4/+A==
X-Received: by 10.202.180.133 with SMTP id d127mr27559717oif.104.1438012807266;
 Mon, 27 Jul 2015 09:00:07 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 08:59:37 -0700 (PDT)
In-Reply-To: <CAOLa=ZSXD-pjgYCOt+ZcYS4uHS0p2uBYX8Rw80xpL+9pNUvm+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274687>

On Mon, Jul 27, 2015 at 9:27 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Mon, Jul 27, 2015 at 6:24 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> --- a/ref-filter.c
>>> +++ b/ref-filter.c
>>> @@ -946,6 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>>
>>> +/*
>>> + * Return 1 if the refname matches one of the patterns, otherwise 0.
>>>   * A pattern can be path prefix (e.g. a refname "refs/heads/master"
>>>   * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
>>>   * matches "refs/heads/m*",too).
>>
>> Nit: you used to s/,too/, too/ in the comment in a previous version.
>>
>
> That's carried over from a previous patch, ill change it.
>
>> I think I already suggested saying explicitly "... matches a pattern
>> "refs/heads/" but not "refs/heads/m")", but I won't insist on that. Just
>> a reminder in case you missed it.
>>
>
> Sorry, I missed that out. Thanks for reminding.
>

If I remember right, I didn't change that cause It didn't pertain to
this commit.
I forgot to mention it in your previous mail.

-- 
Regards,
Karthik Nayak
