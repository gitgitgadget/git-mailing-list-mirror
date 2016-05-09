From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t4151 missing quotes
Date: Mon, 9 May 2016 12:26:45 -0400
Message-ID: <CAPig+cS9OeqGz9xM802pDR68tO7fLos3HKWezy8_y2gsyn_fAA@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 09 18:27:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azo1C-00020u-L9
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbcEIQ0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:26:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34640 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbcEIQ0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:26:46 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so19228367iof.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=t1Jtxzo5I73Oa4+kYk9bSq6XVU98pfXyjRhScm3/+ng=;
        b=TfPaTMhbcvVD2BKatLWvoBY8yjEOTNCiANI1rDkwZlqYVAwIDjS/OaJZasI9LqWExM
         /osRseyNVofqKDEYcnwN3gT9Lz5aBN5cYpmY8PDn6G761fqSjulrQO+BRsmTuBS/8pEd
         dFs7nYdQcm4tTpa8xGz/2lu708fQ6rSyDN7pXx7T6cC1CWZ2gzAy3DlczZTp9opgbHXO
         lSvQN62CjQPff1usR0M6ECMlZ6VQYdltVefH2R0JLtcWSsBgNv1Mt6eL7fp+rmos2NeK
         JlRZK+FFzTDNpmLSwAk87B884FhGMXnlfOdNyluTaUV4jyEau9GsY+4UdRH4M6ejhwGq
         lRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=t1Jtxzo5I73Oa4+kYk9bSq6XVU98pfXyjRhScm3/+ng=;
        b=Y5Tzc+v7TdEfxYS9Lk7+B+CS21gUx5picPRlrYZVgll/LaJTQHxfFWPs9IAssi6qUm
         easx/GttaI4OeJDoafTIf5UxO2r16eoFTSy3F3lT24wyNtxtEZdM6rF2gm9mC5633xXR
         f9VTXGueRBXblNBe8Cu6/PfnkkhSjg86RLMCA4bC+ALVHNkcUhOcldXrdPteZT/IDTG5
         fe2vl99HLtQQdgt0+lw+6GpSuCXOBAZlnCi3WqLUjPtTfYFzMUPmBRJGZqiQjq4Ehery
         hUmdnOlWsN3JYOrLosNZUZ84ivQ6PjIG4UXvVoHzGKDehYUu7k3hUbjP8OD60XPocCSV
         bbbA==
X-Gm-Message-State: AOPr4FV6zLLOysO+WzEwLAMEO8Wzqsr7sxv6+FYxfG6xl5sT5BstQa04qRNsS7BRp5yoBkvOf+GesJpGaRoPPg==
X-Received: by 10.107.47.37 with SMTP id j37mr37042000ioo.168.1462811205216;
 Mon, 09 May 2016 09:26:45 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 09:26:45 -0700 (PDT)
In-Reply-To: <CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
X-Google-Sender-Auth: So0TwS7dt7KJ8nfi-pwQ3R5nssg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294011>

On Mon, May 9, 2016 at 12:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 9, 2016 at 12:09 PM, Armin Kunaschik
> <megabreit@googlemail.com> wrote:
>> *** t4151-am-abort.sh   Mon May  9 17:51:44 2016
>> --- t4151-am-abort.sh.orig      Fri Apr 29 23:37:00 2016
>> !       test 3 -eq "$(git ls-files -u | wc -l)" &&
>> !       test 3 -eq $(git ls-files -u | wc -l) &&
>
> Some comments:
>
> Quoting the output of 'wc -l' will break the tests on Mac OS X and BSD
> since the output contains leading whitespace which won't match the "3"
> on the other side of the '='.

This isn't quite accurate. Since the test is using '-eq' rather than
'=', the leading whitespace won't be a problem, but it can still be
problematic if you're somehow getting an empty result from the
pipeline:

    % test 3 -eq "$(echo)"
    -bash: test: : integer expression expected

> Your diff is backward, comparing 'current' against 'original', which
> makes it difficult to read. Reviewers on this list expect to see
> 'original' compared against 'current'.
>
> Use a unified format to make the diff easier to read; or just use
> git-diff or git-format patch, which is even simpler.
>
> It's not clear how the output of 'wc -l' could ever be the empty
> string. Perhaps git-ls-files is dying and causing the pipe to abort
> before 'wc -l' ever outputs anything? Without additional information
> about the problem you're experiencing, it's difficult to judge if this
> change is a good idea.
