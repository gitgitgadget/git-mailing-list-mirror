From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Sat, 5 Mar 2016 07:43:37 +0700
Message-ID: <CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info> <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
 <20160304115634.GC26609@ikke.info> <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
 <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 01:44:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac0KN-0006ds-HK
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 01:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759694AbcCEAoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 19:44:10 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35597 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567AbcCEAoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 19:44:09 -0500
Received: by mail-lb0-f179.google.com with SMTP id bc4so78848961lbc.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 16:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FtJdGjdLvuDF4Iydq5/cs1ZA3I8aHL6sHXYvwME8rCY=;
        b=mB6rxVm4rxUwDZK7PinERVPtIFTAAbotOhnEfXkXzRwy13B6W9yE6o+pAQOjnPlcKO
         jCAn0H0t0ZNkashWQd/cx7F6Pkd4WM8DEJow2tjvkct0l9CtpTvPAXzdrRahLsQH6xDX
         B1lhIE9UzS5vIlzDC5Ay9SLt8HH7+KHlN7Epuc2b5O5o7cnQxTjWj2WlONA4zeIAWWYY
         hp2+0A8t/6qTRybi5TkuJCEymHAIfwegpsHvdCnNJNxwWheQ/WIYxbbhJKkOZYMw0tIU
         /92QhKKQoFfJS9PsxJAPMk3IK2ePNt6lNiXaBQcAQWQCi0J210QGiMv+LZNH2c0ymBBo
         VTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FtJdGjdLvuDF4Iydq5/cs1ZA3I8aHL6sHXYvwME8rCY=;
        b=DhaKeiWEGSWB730kjQuswHrpSkTnqECsJrjDGp21tIzRP4YpIWvMkBWhf9ktXcxDXz
         +x1KrAX/97fhcEjlmq8aDUnHkIuhwT3ldDUR+a+DNcAlqroxBCzB/5G35dlM26XX+rcC
         N8djCdoB7xjSOXd2cJU6yhGmqFObkcCFOIBoUWDKeuA6QQU2LiOdyuLsAfQDMMCEhlP2
         sy9zb1zhIVN8ySfPeLImMNsLz0N9sIoTXYrI5/M2Mc+7rJt+HyfdUIUm1irzCx333j4s
         BaZgXFaWaajnbjmkg75zlr2ftVUm3xafVrKUb3bLeHmKce7sF6cmJhVc0kvh4mf5dhtG
         kvaQ==
X-Gm-Message-State: AD7BkJKkOtXOmUjeG+tCGP/rx0eUMNRhBy5jvlpbngpoJdSE2Fl5NCnE6NTjOwa9fqie493xaWfj3RPYDKGKEw==
X-Received: by 10.25.157.213 with SMTP id g204mr4334856lfe.112.1457138647391;
 Fri, 04 Mar 2016 16:44:07 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Fri, 4 Mar 2016 16:43:37 -0800 (PST)
In-Reply-To: <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288284>

On Sat, Mar 5, 2016 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Mar 4, 2016 at 6:56 PM, Kevin Daudt <me@ikke.info> wrote:
>>> Verified that it's different in 2.7.0, but 2.7.2 gives expected output.
>>
>> Thanks. 2.7.1 reverts the faulty commit from 2.7.0 that generated two
>> other regression reports before this one. I guess it's all good then
>> (except for the people still on 2.7.0)
>
> Are we good at 2.8.0-rc0, too?  Somehow I had an impression that we
> queued "another attempt to do it differently" or something.
>
>  ... goes and looks ...
>
>     $ rungit maint status -suall
>     ?? baz/quux/corge/wibble.txt
>     ?? baz/quux/grault.txt
>     ?? foo/bar.txt
>     $ rungit master status -suall
>     ?? baz/quux/corge/wibble.txt
>     ?? baz/quux/grault.txt
>     ?? baz/waldo.txt
>     ?? foo/bar.txt
>     ?? foo/garply.txt

If you swap a60ea8f and bac65a2 so that we can have tracing even
without the problematic commit a60ea8f (dir.c: fix match_pathname() -
2016-02-15). Without a60ea8f I got

GIT_TRACE_EXCLUDE=1 ~/w/git/temp/git status -suall 2>&1 >/dev/null
|grep waldo
07:25:05.639445 dir.c:952               exclude: baz/waldo.txt vs * at
line 1 => yes

(meaning, baz/waldo.txt matches "*" rule and is decided to be excluded)

with a60ea8f

> /tmp/abc $ GIT_TRACE_EXCLUDE=1 ~/w/git/temp/git status -suall 2>&1 >/dev/null |grep waldo
07:25:24.425125 dir.c:952               exclude: baz/waldo.txt vs /baz
at line 4 => no

the decision is not taken earlier from line "!/baz" and it's decided
to be re-included. Which I would argue is the correct thing because
you ask to re-include the whole directory "baz". It should behave this
way because exclude rules without '!' behave this way.

Because positive any negative rules can be nested, by adding a rule to
reinclude what's inside baz..

    *
    !/foo
    !/foo/bar.txt
    !/baz
    /baz/*
    !/baz/quux
    !/baz/quux/**/*

you'll get baz/waldo.txt excluded.

Yes it's a behavior change. I think the old behavior is unintended.
But it's probably out there long enough that many .gitignore files may
rely on it and by making it right, I break them. Whether to revert the
series is up to you. Let me know if I should send the revert patch.
-- 
Duy
