From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Ignore on commit
Date: Fri, 5 Oct 2012 07:50:11 +0530
Message-ID: <CAMK1S_jfdW3BepELgPPoUf3qWwmU-o3o8OpMVimdfkERUJkymQ@mail.gmail.com>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
	<506DEC50.7090402@obry.net>
	<CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
	<CAH5451mpJw4+noUF+FkZJS+Y2oq2ThFeG7wSOCdbVaMQPNgUJA@mail.gmail.com>
	<CANgJU+XSYWObCsGVnWwaaSB9iZQnfU_y095uzEm5-YXMaUoU_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Marco Craveiro <marco.craveiro@gmail.com>, pascal@obry.net,
	git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 04:20:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJxWd-0004yb-EX
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 04:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250Ab2JECUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 22:20:14 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:50332 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196Ab2JECUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 22:20:13 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so617964lag.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 19:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yxZNheOR+y3dkhh6G5GaBoisrBsFi+zt3au1KodBAdg=;
        b=rURzTzWRmH+s3Xn0gh0JFCPRD2Oo/hicrznhmkTyCn7rr5hStj7DO/OBNT4TcXlqmU
         2wVJWCUWrYX8DMak4arrRzrqS28cPBZZCoB7ta9hCoYRyxpfAqPh7FcXUR3fcGMY9Sx5
         BZUsIzw2kvCBuIe1LvSBP0q3FvUc0BuJCCHT8CJZWFhNlZgcbdR6s+yTkO5U9UVY8sJO
         IR9bG6jIC8Q+b1zJz97OwBouMdQUrzjBEaR7NSqNJuigssKC5B7edOCAqp8c4D8h3J0/
         eHHUEsPw6XY8oc8tl4y7vahK2RR7NfDT32+uGKXuIAYYxSdm/9LcuuYKLgKfIjoy7AIQ
         tzew==
Received: by 10.152.144.67 with SMTP id sk3mr5727545lab.19.1349403611519; Thu,
 04 Oct 2012 19:20:11 -0700 (PDT)
Received: by 10.112.84.97 with HTTP; Thu, 4 Oct 2012 19:20:11 -0700 (PDT)
In-Reply-To: <CANgJU+XSYWObCsGVnWwaaSB9iZQnfU_y095uzEm5-YXMaUoU_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207064>

On Fri, Oct 5, 2012 at 7:05 AM, demerphq <demerphq@gmail.com> wrote:
> On 5 October 2012 03:00, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>> On 5 October 2012 07:20, Marco Craveiro <marco.craveiro@gmail.com> wrote:
>>> ...
>>> Similar but not quite; the idea is that you know that there is some
>>> code (I'm just talking about files here, so lets ignore hunks for the
>>> moment) which is normally checked in but for a period of time you want
>>> it ignored. So you don't want it git ignored but at the same time you
>>> don't want to see these files in the list of modified files.
>>
>> What is the reason git ignore is no good in this case? Is it simply
>> that you can't see the ignored files in git status, or is it that
>> adding and removing entries to .gitignore is too cumbersome? If it's
>> the latter you could probably put together a simple shell wrapper to
>> automate the task, as otherwise it seems like git ignore does what you
>> need.
>
> Git ignore doesn't ignore tracked files.

would 'git update-index --assume-unchanged' work in this case?  Didn't
see it mentioned in any of the replies so far (but I have never used
it myself)
