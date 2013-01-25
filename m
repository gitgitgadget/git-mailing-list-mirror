From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Thu, 24 Jan 2013 23:54:25 -0800
Message-ID: <CAJDDKr4oerSq16rYt2iKNtQNK79L+jOiKROhEW_yiBPKjkVhuQ@mail.gmail.com>
References: <50FBD4AD.2060208@tu-clausthal.de>
	<7v4nibjrg0.fsf@alter.siamese.dyndns.org>
	<50FCFBBB.2080305@tu-clausthal.de>
	<7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
	<5101B0A5.1020308@tu-clausthal.de>
	<7vpq0u8bxd.fsf@alter.siamese.dyndns.org>
	<CAJDDKr5O70tTfwuipWcYVJL6gM3bUyQh-22yVO89xn8OFsQOpw@mail.gmail.com>
	<7vvcal683y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 08:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tye7c-0002NK-UK
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 08:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab3AYHy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 02:54:28 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50111 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3AYHy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 02:54:27 -0500
Received: by mail-ee0-f46.google.com with SMTP id e49so42423eek.5
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 23:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ln9+GliCqz998iF+2XiG8R2reTkOWMu+AmGQDQpqgkQ=;
        b=okbhOX+/J0nIkLCP9LM4Jbe124Iv2k903EJqUp7VYuuOJKP/xkZlu7FvuKlJBcWM6C
         U1G/sGxytzKZwoLAXHPJg2Yh4KF8hzV6upsTvDFlRqODFoNlyZBBwf0ozQPKeSpygy0U
         XWAlZMqSdOkwFOs0K6IVcSUhG2TQWjUXef8H9MovoTFq90tWqC15a7NPm7LOPPCslbBh
         JY9aAIS0mGcRPPunxekYPPtw05+Kz0gXpWiecblusQ39v6G+2H9fIUfP6BSPA2qXKIZj
         5ZnoN/cIuSJfYkgue6NXXVEma2jqwgMroioZTts/tZkHkbS4SYSSn98iVefaWHKw0Vcl
         vlrQ==
X-Received: by 10.14.205.198 with SMTP id j46mr15485852eeo.27.1359100465906;
 Thu, 24 Jan 2013 23:54:25 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Thu, 24 Jan 2013 23:54:25 -0800 (PST)
In-Reply-To: <7vvcal683y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214510>

On Thu, Jan 24, 2013 at 11:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>>>>> This paragraph needs to be rewritten to unconfuse readers.  The
>>>>> original is barely intelligible, and it becomes unreadable as the
>>>>> set of tools subtracted by "minus" and added by "plus" grows.
>>>>
>>>> But I think this should not be part of this patch.
>>>
>>> I agree that it can be done (and it is better to be done) as a
>>> preparatory step.  The current text is barely readable, but with
>>> this patch there will be two "minus", and the result becomes
>>> unreadable at that point.
>>>
>>> It also could be done as a follow-up documentation readability fix.
>>
>> Another thought would be to minimize this section as much
>> as possible and point users to "git difftool --tool-help".
>
> We had a similar discussion here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/201913/focus=201976
>
> and Documentation/git-{diff,merge}tool.txt have stayed quiet since
> then.
>
> But Documentation/merge-config.txt tries to list everything that _could_
> be enabled, and I do not necessarily think having one single
> location that lists everything is such a bad idea.
>
> Is there a way for me to programatically tell what merge.tool and
> diff.tool could be enabled for a particular source checkout of Git
> regardless of what platform am I on (that is, even though I won't
> touch Windows, I want to see 'tortoise' appear in the output of such
> a procedure)?  We could generate a small text file from the Makefile
> in Documentation and include it when building the manual pages if
> such a procedure is available.

That's a good idea.
Here's one way... (typed into gmail, so probably broken)

LF='
'
mergetools=
difftools=
scriptlets="$(git --exec-path)"/mergetools

for script in "$scriptlets"/*
do
    tool="$(basename "$script")"
    if test "$tool" = "defaults"
    then
        continue
    fi
    . "$scriptlets"/defaults
    can_diff && difftools="$difftools$tool$LF"
    can_merge && mergetools="$mergetools$tool$LF"
done

I can follow up with a Documentation patch along these lines.
I'm would imagine it would be hooked up similarly to how the
command lists are constructed.

This should allow the tortoisemerge improvements to happen independently.
-- 
David
