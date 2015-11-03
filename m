From: Stefan Beller <sbeller@google.com>
Subject: Re: git.git as of tonight
Date: Tue, 3 Nov 2015 10:18:40 -0800
Message-ID: <CAGZ79kbAj-tZS3X1EwFw_gGh1=YU8M0OmEX91W8f++fqs6TiBA@mail.gmail.com>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
	<5637D266.4060904@kdbg.org>
	<CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
	<56385587.1010601@kdbg.org>
	<xmqq37wndndp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 19:18:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtgAV-0001bf-9E
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 19:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbbKCSSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 13:18:42 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36191 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbbKCSSl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 13:18:41 -0500
Received: by ykba4 with SMTP id a4so30098642ykb.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 10:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9II42/V2dZ0rGqF4x3Pkqjb5Uvu3YQ4fn+UiXhdiWEY=;
        b=R9gCFYFU8bq+7h1T1bzlrcgVaiNVTlsK4aPemNZqusB+vpz2CBFV3xYpGhwBrvxZSG
         54mF5rDBodBvRn9c9AOWQl+nZta1Xp2WRdnEqSwxpHu0XK9mn+374X5wzvAI2jgsQ4Rw
         U0/4jMIuZtu/xc3hoipDzVIPlRCMigwTM4846Am5twAs9bUd8503U22H3cA2+dkka0Y6
         MtTwykgOZUcvABfGsf5uD9S9kUUei/Dd0g8UmauqSilTUvpLd7DJsSLvunQXPBDT6Ncx
         u9U3zBxSSbB9SYpNtVfggQTjgV5tCwJBbCykCBqhSCr50FpjxwQZb1YMTloILE1VI67G
         H/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9II42/V2dZ0rGqF4x3Pkqjb5Uvu3YQ4fn+UiXhdiWEY=;
        b=HZcT3gIhHrgFSY5/PPWGeTGMdrXiuAw0o/WmaLMW+AssqQ7+Co27vw1QqItVNI/xCG
         Tgmp9xOxUJ2Rzld2E09822iP32nj7QLrPYhA+Ek0ipVyWRrH7yKgmqwqqP63bz2h93X/
         i1qSePs90sIvecRDt4GoKh0IqSgkpM0m4s3zH0Y0IXCzDtNye3LQV3C22Ps1hUdjFHJ4
         8CeGGYKXlrNSOiyIHOAKZdCsVOCUTWuCCIoCbpqrQePY66Gq71S/XsoYaTQ5ICEcFeNG
         7W8p/RFvEgAYXV5HMRG1a0SJeNvteLQkIPE6ueWd7aTH1zXW7P3Ve2pWEcXZLIEzZu7n
         y0pw==
X-Gm-Message-State: ALoCoQnLC+Y2lHA6FtMxffBPrhMECo1RJWfYSB/x873/dImPdTuSqiZjNDHG7MkE5tJxcDsCkmQT
X-Received: by 10.13.254.69 with SMTP id o66mr21478644ywf.252.1446574720321;
 Tue, 03 Nov 2015 10:18:40 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Tue, 3 Nov 2015 10:18:40 -0800 (PST)
In-Reply-To: <xmqq37wndndp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280806>

On Tue, Nov 3, 2015 at 9:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> My findings so far are negative. The only short-term and mid-term
>> solution I see so far is to opt-out from the framework during
>> build-time.

So I started reading up on that[1].
As far as I understand, we don't need to mark a file descriptor
to be non blocking, but rather we could use ReadFileEx[2] with
a flag set for "overlapped" operation.

So that said, we can make set_nonblocking a noop and
provide another implementation for strbuf_read_once
depending on NO_PTHREADS being set.
Maybe not even strbuf_read_once, but rather the underlying
xread_nonblock ?



[1] http://tinyclouds.org/iocp-links.html
[2] https://msdn.microsoft.com/en-us/library/aa365468(v=VS.85).aspx

>
> Now, from where I sit, it seems that the way forward would be
>
>  1. Make this an optional feature so that platforms can compile it
>     out, if it is not already done.  My preference, even if we go
>     that route, would be to see if we can find a way to preserve the
>     overall code structure (e.g. instead of spawning multiple
>     workers, which is why the code needs NONBLOCK to avoid getting
>     stuck on reading from one while others are working, perhaps we
>     can spawn only one and not do a nonblock read?).

Yeah that would be my understanding as well. If we don't come up with
a good solution for parallelism in Windows now, we'd need to make it at
least working in the jobs=1 case as well as it worked before.

>
>  2. After that is done, the feature could graduate to 'master'.  As
>     this is a bigger framework change than others, however, we do
>     not necessarily want to rush it.  On the other hand, because
>     this only affects submodules, which means it has fewer users and
>     testers that would give us feedback while it is on 'next', we
>     may want to push it to 'master' sooner to give it a larger
>     exposure.  I dunno, and I do not want to decide this myself the
>     week before I'll go offline for a few weeks (i.e. today).

Yeah I guess cooking this well done has its benefits.

>
>  3. Then we would enlist help from folks who are more familiar with
>     Windows platform (like you) to see how the "run parallel workers
>     and collect from them" can be (re)done with a nice level of
>     abstraction.  I am hoping that we can continue the tradition of
>     the evolution of run-command.c API (I am specifically impressed
>     by what you did for "async" that allows the callers not to worry
>     about threads and processes) aroundt this area.  That is
>     obviously a mid- to longer term goal.

I just wonder if we can skip step 1) and 2) by having the discussion
now how to change the framework to work well without posix file
descriptors here.

>
> Thanks for working together well, you two.
