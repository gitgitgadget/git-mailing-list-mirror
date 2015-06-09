From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: Fw: sort of a bug report - git rebase dropping empty commits
Date: Wed, 10 Jun 2015 00:16:04 +0100
Message-ID: <CAJMB+NgqcydSzt--L+2kLmtNYp2kzhifEdYfgnEbcbwOovH_7A@mail.gmail.com>
References: <1430956735.75040.YahooMailBasic@web172301.mail.ir2.yahoo.com>
	<CAJMB+NhVapp+upsk2AQQmZndaNFjaOieom7=n6mY31v0QemaYA@mail.gmail.com>
	<CAHYJk3QOuo=p26OAnkKmrPS0SzpdJGvB=Fm=jiMMDDJo13zi9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:16:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Sko-0004XX-Te
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 01:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbbFIXQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 19:16:12 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34290 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbFIXQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 19:16:05 -0400
Received: by wibut5 with SMTP id ut5so31262769wib.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nJOu4WPJt67SCHTL8dQ0qy0y16i8TAcJq+t1swCIocc=;
        b=M3FgGEeVAiN3lH3mTirng4ImmHetWHuTV+F520/8VJkjj124mP3J5RY5IjVP9CFMZd
         3NifglS/n3c7D0GUfbW6S/n5MftCs4mDkAcb+kJtTNYS3oGmJqKcve2LXH/dZrtGqWBQ
         Rs5MjEnJwBxiH/Ecbc2EiGfd4cKPwOCG64NeSRhWluJHgA8FLKNRkF62dFU6xwSD6D1a
         rFVdRoj8efnlgehLx8EboGfhMJNjMNX0JzsEq83sL/V5FofInd9Ertgm1v0zzDW3NhIS
         3J6+j6iA2SVg45m6OSmJ6THxizVXxlGm6h8etxry7fsWgCiio7szx9WP8Z/uZb5zlpef
         SP6w==
X-Received: by 10.180.206.14 with SMTP id lk14mr12768017wic.94.1433891764145;
 Tue, 09 Jun 2015 16:16:04 -0700 (PDT)
Received: by 10.27.172.143 with HTTP; Tue, 9 Jun 2015 16:16:04 -0700 (PDT)
In-Reply-To: <CAHYJk3QOuo=p26OAnkKmrPS0SzpdJGvB=Fm=jiMMDDJo13zi9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271239>

Argh, thanks a lot!  Should have read the man page better. OTOH,
I expect 'git commit --allow-empty' being needed, but 'git rebase --keep-empty'
comes somewhat as a surprise - I wasn't expecting git rebase to commit
each in turn,
but of course that's what it does.

On 7 May 2015 at 01:47, Mikael Magnusson <mikachu@gmail.com> wrote:
> On Thu, May 7, 2015 at 2:19 AM, Hin-Tak Leung <hintak.leung@gmail.com> wrote:
>> Repost from another account. vger.kernel.org seems not
>> to like postings from my other alias (which goes through
>> yahoo).
>>
>>> (please cc - I am not a subscriber)
>>>
>>> Recently I have started to keep some notes in git repo's
>>> with --allow-empty - i.e. the meaningful content is
>>> the commit message and the date itself, not the diff.
>
> Use the git rebase --keep-empty option?
>
> --
> Mikael Magnusson
