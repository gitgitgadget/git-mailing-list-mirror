From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [Query] Update email-id in kernel source
Date: Thu, 14 Jun 2012 21:44:34 +1200
Message-ID: <4FD9B282.7090106@gmail.com>
References: <CAOh2x=k==ZjqQk4bvvviz4Uy7Xg2yn0A+9vbYJ63VJa4qMCodA@mail.gmail.com> <4FD860A9.4000804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 11:44:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf6b4-0003Px-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab2FNJoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 05:44:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34189 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab2FNJoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 05:44:04 -0400
Received: by pbbrp8 with SMTP id rp8so3567819pbb.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=D9IxKtqVF/t8DyiQICh84kcsEtDrD7jLcKDZaUCWp30=;
        b=jAGcaER+g7L8L+jzFvqmJGAUmuu30wkO8ii/I8goh3yDoL8EVqENgPbmKCp0A3iQ0H
         f+BT+WA+abmMTTcFokTCdsBJRJlBhY+iz0A1sOkKXJkSYt7TGOUQWdmoAecjxSjCeBNR
         j2F5HWwx/3m1FMaPC9kPcCH2+HWpFeznKtAX3H5IzzWHLfq6t/0+1xN5dJe58ztE0EiU
         gv6xnHPU0FzLevTczacFVFbLjHug2FhsLf4OGxHtJmwZWGvo5aCd7uAtYZtJsKMJT37b
         vP8qBx9bardJX0JmRmFAffAhT8SqQxNXsekZOeQRmbrB/vz2FiOioNQiO0sRsJ0h71SQ
         afmQ==
Received: by 10.68.227.198 with SMTP id sc6mr6077382pbc.138.1339667043515;
        Thu, 14 Jun 2012 02:44:03 -0700 (PDT)
Received: from [192.168.1.66] (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id oy8sm8950580pbc.52.2012.06.14.02.43.57
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 02:44:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <4FD860A9.4000804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199993>

On 06/13/2012 09:43 PM, Chris Packham wrote:
> On 06/13/2012 09:24 PM, viresh kumar wrote:
>> Hi guys,
>>
>> I have recently changed my company and am required to update my email address in
>> kernel source.
>>
>> I can only see one way of doing that:
>> - Do a git grep, update all files, commit and post the patch.
>>
>> Is there any better way of doing this that git provides, by which even
>> 'git log' would show
>> the latest id available? I heard from a friend but don't know if it exists.
>>
>> --
>> Viresh
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Not sure if the kernel maintains one but projects can use a .mailmap[1]
> file to do just this kind of thing. You'd still have to update code if
> you want people to get hold of you from MODULE_AUTHOR statements.
> 
> --
> [1] - http://www.git-scm.com/docs/git-shortlog

git log does support the .mailmap feature with the %aE format option but
it looks like it doesn't do it by default. I'm guessing performance is
probably the reason. Anyone else care to comment?

(Re-send. Sorry for the spam, I can't convince my phone not to send HTML)
