From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Git feature request: mark a commit as minor
Date: Sat, 3 Oct 2015 08:17:47 +0200
Message-ID: <CAHYJk3Qb89YhVJoOpBLYMoNJX5GvVHnJhf41Gdbtypcp+Yq96g@mail.gmail.com>
References: <560EF966.3000501@walltime.info>
	<CA+P7+xq8Ds3hYjv2x8S4v8+6F3G+ciGreiZxHxDfzzft520ChQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Micaroni Lalli <micaroni@walltime.info>,
	Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 08:18:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiG9E-0004wv-KS
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 08:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbbJCGRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 02:17:49 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33414 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbbJCGRs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 02:17:48 -0400
Received: by qgev79 with SMTP id v79so112002200qge.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Zk7vJNCXqaDhizm1HRZxBE2ypnBfY7cjIPR+vI06o1A=;
        b=kJjudXk4UHfr/lUlJ3lrnS2KKeEAeL1gXQJqOoV05eQXYTuiYfFwN+t0eCIJ7qkBa8
         ELoVJ2j3zrAReFx4U1SwtNfdlpALwi4TtVJPWYAqng4w7W46xSwa141ijxRnACwClWDs
         ScXOX+jtY3xBdfEP4+VHeAtpZ1PZa3vYT4DOYmhn+o8r4Z0sYM4Mul3xC+rTL4en4L2F
         Rsq+m3J9Bio74QBqDGLds5Ji28SteVZef/4aqBYB34uwmtDEoKp9YvJh3V5nE+S+ZJ26
         pkrqasf8STYu6v1EP2ItmjKN99zBYggCPNSdQtTmKHXoeq0MvMVpWqOIdkDhYKl1o4N3
         5xwA==
X-Received: by 10.140.98.238 with SMTP id o101mr24734468qge.70.1443853067808;
 Fri, 02 Oct 2015 23:17:47 -0700 (PDT)
Received: by 10.55.197.1 with HTTP; Fri, 2 Oct 2015 23:17:47 -0700 (PDT)
In-Reply-To: <CA+P7+xq8Ds3hYjv2x8S4v8+6F3G+ciGreiZxHxDfzzft520ChQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278957>

On Sat, Oct 3, 2015 at 8:11 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Oct 2, 2015 at 2:38 PM, Felipe Micaroni Lalli
> <micaroni@walltime.info> wrote:
>> A minor change (also called "cosmetic") usually is a typo fix, doc
>> improvement, a little code refactoring that don't change the behavior etc.
>>
>> In Wikipedia we can mark an edition as "minor".
>>
>> It would be nice to have an argument like "--minor" in git-commit to
>> mark the commit as minor. Also, filter in git-log (like --hide-minor) to
>> hide the minor changes. The git-log could be optimized to show minor
>> commits more discreetly.
>>
>>
>
> This should just be part of the commit message log, generally projects
> use something like TRIVIAL in the patch subject or similar. You could
> also standardize for your project(s) what would be considered a minor
> change. The issue is that not everyone considers these changes as
> "minor". You should be able to use a combination of the --grep option
> in log to search for all commits who don't contain that string in the
> right format.

Could also be a good use for notes, since you might want to add this
markup after the fact.

-- 
Mikael Magnusson
