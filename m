From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: SSH version on Git 1.8.1.2 for Windows is outdated.
Date: Sat, 16 Mar 2013 14:14:58 +0100
Message-ID: <51447052.1020407@gmail.com>
References: <CAJ5Q6vXTyaegQq2uMoK7QQVYiYS9GcJhCefkQs9tXxqU=M10Vg@mail.gmail.com> <20130315210325.7b0a3505ffa4d46e7e716324@domain007.com> <51438058.7080204@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Kristof Mattei <kristof@kristofmattei.be>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 14:15:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGqxX-0001uP-En
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 14:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374Ab3CPNPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 09:15:09 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:61490 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab3CPNPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 09:15:08 -0400
Received: by mail-bk0-f41.google.com with SMTP id q16so1908866bkw.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:newsgroups
         :to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7HrljmLG779akhopQiRGaywUDz31aRPCE0XDPVaovYQ=;
        b=dS+c5yFsIsYq8YNp58VKMVERG9oSk3HlMe6wFKMQ6XEq44CDPtVkhRWRWP46b0KDkP
         vSkghNQpJs9KVSevi5V3DMGPzG/PPNuG8tZAffegm7Q2oqrdMq0NwUMTA38wD+cfLQP9
         xnGZRCvpPX/CWl61uGqBMWIMuGJzwS82KhWNRQpAZwWeQSCDzi3ePyVBNgGhv2zg8wuu
         97rOB05JnNJCwMJIm/J2oqMhr4bFhNuv7gt2KIWWekDNW5J6ve6gONaFYtEJsuWwcHqn
         9I7XIKzLR78PQWW2rfJSsLyy+VLNlvPlJtHH8kibWpN4w6FXXtfGg+zdmpKhRTQ7hdBm
         FI1Q==
X-Received: by 10.205.96.69 with SMTP id cf5mr4437079bkc.132.1363439706727;
        Sat, 16 Mar 2013 06:15:06 -0700 (PDT)
Received: from [192.168.188.20] (p5DDB3DA3.dip.t-dialin.net. [93.219.61.163])
        by mx.google.com with ESMTPS id ge12sm2406907bkc.19.2013.03.16.06.15.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 06:15:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <51438058.7080204@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218302>

On 15.03.2013 21:11, Joshua Jensen wrote:

>> Yes, you should grab the msysGit (the Git for Windows build
>> environment) [2], tweak it to include the new OpenSSH binary, ensure it
>> builds and works OK and then send a pull request (or post your patchset
>> to the msysgit mailing list [3].
>>
> Wow, we can do that now?
>
> When I brought up the vastly improved performance from a newer SSH
> executable, I was told the only way to get it in would be to build from
> source [1].

"tweak it to include the new OpenSSH binary" is supposed to include the 
step to adjust the release.sh script to grab the updated sources and 
build the binary.

However, another option is to take a look at the new mingwGitDevEnv 
project [1], which relies on mingw-get to retrieve binary packages. I 
hopefully find soon the time to include OpenSSH 6.1p1 incl. HPN-SSH 
patches [2].

[1] https://github.com/sschuberth/mingwGitDevEnv
[2] https://github.com/sschuberth/mingwGitDevEnv/pull/5

-- 
Sebastian Schuberth
