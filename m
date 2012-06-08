From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: show refs points to a commit
Date: Fri, 08 Jun 2012 21:47:24 +0200
Message-ID: <4FD256CC.5010801@lyx.org>
References: <CAN0XMO+G6K0FZgu35OuuqGEp322vLpakXHXBTPpUQmoex68srA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 21:47:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd59i-0004eU-2x
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 21:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933489Ab2FHTr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 15:47:28 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65039 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab2FHTr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 15:47:27 -0400
Received: by eaak11 with SMTP id k11so1261366eaa.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 12:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=yWHRUKezadHvBYBJ2Rj3f2GI/2+6k8gmrhtFCjGjqo8=;
        b=EZv1hEiNqf7ANw2BD2NSH8sAKHWVrN5jsNSw2HF7rD4itjzFhTRVAQTXa+xLByyCf/
         uStKKM3pP8qSAszoPiFN0q6qqA0ZjgQTo6KKOoBmKUgnGl9YmS9u1ZCoMKPHt8h1icsK
         cV8cdJE7djZ/P1hCH53eJYH1eKrtraegXrz/cPl8kCryqKKyP6ud1WYSXqgB8c3z74Ph
         qGxeRTfm8PB7IVuRwu7HZbYKHBo+ELfdEHTclHtuvGzKN/6QZfnt89hTOt+tYG+FinoL
         4lVWsDfBhp7OveFZw4LrI716barAj41zYsHK+1ABfZR2MHztglNEyGFG7ejqnYbfw8WV
         geHg==
Received: by 10.14.47.130 with SMTP id t2mr4320788eeb.21.1339184846141;
        Fri, 08 Jun 2012 12:47:26 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id m5sm25406636eeh.17.2012.06.08.12.47.24
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 12:47:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAN0XMO+G6K0FZgu35OuuqGEp322vLpakXHXBTPpUQmoex68srA@mail.gmail.com>
X-Gm-Message-State: ALoCoQncl9ptgOiXEVxX7vjIdXhZKe8bZzsK3gLE75SFIyivZ+Eh+0HUSVTEJ7gKYK6dfvh9mE1H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199521>

Op 8-6-2012 21:37, Ralf Thielow schreef:
> After playing around with submodules, I haven't
> found a builtin way to show refs pointing to a
> specified commit without using UNIX pipes.
>
> Especially when you working with submodules, it
> would be very helpful to know which refs
> points to this commit in order to switch from
> "detached HEAD" to the branch you can (maybe)
> work with.
>
> Or did I miss something?

Is this what you mean ?

$ git rev-parse master
f623ca1cae600e97cb0b38131fdd33e4fb669cf8
$ git name-rev f623ca1cae600
f623ca1cae600 master
$ git name-rev --refs=refs/heads/* f344333cd
f344333cd master~10

Vincent
