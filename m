From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] URL rewrite in .gitmodules
Date: Mon, 26 Oct 2015 09:34:33 -0700
Message-ID: <CAGZ79kbFDB55mKnw-ONPGBmHfeXZDBKOb=HrjjepiBh3kgcO1g@mail.gmail.com>
References: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com>
	<xmqqio618mxc.fsf@gitster.mtv.corp.google.com>
	<F01EF930-9787-44DD-A2E5-F5FBA029D3E7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 17:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqkjG-0007fL-Dk
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 17:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbbJZQee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 12:34:34 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33168 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbbJZQed convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 12:34:33 -0400
Received: by ykft191 with SMTP id t191so7090000ykf.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jTIcua5QnaEuEyMiXB105kUWof5X0h+w0FR/S/xVE4o=;
        b=QJ9p5jU5AopgMLkyEtCRSznxG8tom70sxHmnKZRq5PWOTDf1ZoLbvfMv/hZyM+dSbQ
         +vXX45610W4xLcJd/9+nZei1VvANEvcdySm52jCZZcxW5sUOARpFcKcuNg3+KFMzyLtS
         vX0qD8/INPmhfGndxjvHsNwCRdJaCh0gW9gifO628EM2tM+Ry0yVIKggGXNQmx3cflnl
         XDHyBTUj31/SkiVGQLQ7tZ0roAAE8t5+ybCBYC3mLIeHzSqi5tJCsC/FkI3xVkb9lRWg
         V8YpwB7/1CHWkZKxTzFC5Tzn1uPzhclCJzdlLJP7F4Tf9T4J+N+YEXbNnvcUXgC6wRQ5
         gjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jTIcua5QnaEuEyMiXB105kUWof5X0h+w0FR/S/xVE4o=;
        b=DPFPEBzUKIHpfWY7T9vvuHuRgXyPsTnbQWzE5VjkekIelV9sGryMSC4FUujkR+psiW
         OShXOLlhqLC7Um5syhIogjf6N3EQS1s87j4APfwoHoDnEI1pqv/vCgoxZ0epmsLoFDEn
         vduNrv1lfGO2+ex6NNEHE9tPPz0VPiBaiZwa/l5h10Jhid4VA4DCqKKA3/9oETOOhsjr
         VI6l3Aed9GaUVQ+LsT603dzEvSXs+Pl43YR8JbQGSHdh92aKyM0JjKDiW2fLHTsMJUIm
         O1kX4Qla5s3xoWYPe36uEfXZtwaI85huyMCN+dCz7JsfHRCvB9iwiO56mZTXHMnASYun
         yD2g==
X-Gm-Message-State: ALoCoQm/GL+fbm/MDkxjLym/4RwD2TPAAnbl0gp3N7LFn7I6/xIX5BmWeeksS7iaiD5e9JVXiepU
X-Received: by 10.13.199.133 with SMTP id j127mr26279718ywd.176.1445877273097;
 Mon, 26 Oct 2015 09:34:33 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 26 Oct 2015 09:34:33 -0700 (PDT)
In-Reply-To: <F01EF930-9787-44DD-A2E5-F5FBA029D3E7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280199>

On Sun, Oct 25, 2015 at 8:12 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> On 20 Oct 2015, at 19:33, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> If not, what do you think about a patch that adds a "url" section
>>> similar to the one in git config to a .gitmodules file?
>>>
>>> Example:
>>> ----------
>>> [submodule "git"]
>>>      path = git
>>>        url=git://github.com/larsxschneider/git.git
>>>
>>> [url "mycompany.com"]
>>>        insteadOf = outside.com
>>> ----------
>>
>> It is unclear to me if you are adding the last two (or three,
>> counting the blank before) lines to your company's private fork of
>> the opensource project, but if that is the case, then that would
>> defeat your earlier desire:
>>
>>> ... I also would prefer not to do this as I want to use the
>>> very same hashes as defined by the "upstream" ...
>>
>> wouldn't it?
> The last three lines are added to my companies closed source Git repo. In this example the company repo references git://github.com/larsxschneider/git.git as submodule. This submodule in turn references another submodule with a URL "outside.com". This is the URL I want to rewrite. Do you think this could be useful to others as well?
>
>
>> I do not think this topic is specific to use of submodules.  If you
>> want to encourage your engineers to fetch from nearby mirrors you
>> maintain, you would want a forest of url.mine.insteadof=theirs for
>> the external repositories that matter to you specified by
>> everybody's $HOME/.gitconfig, and one way to do so would be to have
>> them use the configuration inclusion.  An item in your engineer
>> orientation material could tell them to add
>>
>>       [include]
>>               path = /usr/local/etc/git/mycompany.urlrewrite
>>
>> when they set up their "[user] name/email" in there.
>>
>> And you can update /usr/local/etc/git/mycompany.urlrewrite as
>> needed.
> Oh nice, I didn't know about "include". However, as mentioned to Stefan in this thread, I fear that our engineers will miss that. I would prefer a solution that does not need any additional setup. Therefore the suggestion to add rewrites in the .gitmodules file.

How do you distribute new copies of Git to your engineers?
Maybe you could ship them a version which has the "include" line
already builtin as default? So your distributed copy of Git
would not just check the default places for configs, but also
some complied in /net/share/mycompany.gitconfig

>
> Thanks,
> Lars
>
