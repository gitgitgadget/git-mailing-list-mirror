From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v1 2/2] git-p4: suppress non test relevant output
Date: Thu, 24 Dec 2015 11:09:35 +0000
Message-ID: <567BD26F.3020006@diamand.org>
References: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com> <1450629869-49522-3-git-send-email-larsxschneider@gmail.com> <xmqqd1tzfsfm.fsf@gitster.mtv.corp.google.com> <0185CA76-DDEE-4E7F-8EFF-65E80720E0AF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 12:09:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC3lx-0003Gy-Vi
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 12:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbbLXLJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 06:09:24 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35589 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbLXLJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 06:09:23 -0500
Received: by mail-pf0-f173.google.com with SMTP id 78so65216009pfw.2
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 03:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OlkpWDI/H9bS1HOxV/jn0BysilG6hUPZPtHGBeN9G1g=;
        b=XPZ5mH0gOn/Wg3dX3xHoy7OH0whvbDvVxXNYEAyy0uGasE9YF9oHM/x6d+3crvLxhu
         6Azq5wgKOguDoSGJtrekSqkYmdFU8AINuTQ6VWvljDV49qg9pwihlNLM0yetPiUd7ItO
         IlMjOrUurwWqLe+wxZZ3CMYHaXw1jaTaaFtXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=OlkpWDI/H9bS1HOxV/jn0BysilG6hUPZPtHGBeN9G1g=;
        b=eIiXh6ijB06jwmMNQFYzKeQFMNwB25mk3m/va0VoNPtk+yeYC1zWDS5BEktOETDnFw
         XOQBLZtMKZW76vDVKkOnf3tHEizfu9HuCkAnZkEH9FKdomYXeJiBOUpptd0D2/n+HHYe
         4IH5xbfVaOePn8WhapqPNqjnZ2zU30HK85Dm+rWkRaEs5vJDQq4BwSFO5YFiubhMpB5Y
         4HeJad329AEdGGmrIBGftxM1EyzNcA7crYgOyt1jeo6/7IsmSzZSEip9pPEf0EGCrYcz
         nyvyFD11nPsaYYjGAf4Pb/l9ygDk4PhQHYGs03tXh5Vp/CVFek+fGFcSCDQNIhEyyMHj
         AtZg==
X-Gm-Message-State: ALoCoQlJV8qLO8mwP3fs7vG6g0AY+EYIgRLMjhDJuq+yqKzwM26aks4GV5PnY74gAdf0XzaAekQQYe+nSI4OP+peOBE/TKRTQQ==
X-Received: by 10.98.76.206 with SMTP id e75mr50867899pfj.157.1450955362420;
        Thu, 24 Dec 2015 03:09:22 -0800 (PST)
Received: from [192.168.245.128] (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id h80sm23701580pfd.44.2015.12.24.03.09.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Dec 2015 03:09:21 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <0185CA76-DDEE-4E7F-8EFF-65E80720E0AF@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282980>

On 22/12/15 08:47, Lars Schneider wrote:
>
> On 21 Dec 2015, at 21:38, Junio C Hamano <gitster@pobox.com> wrote:
>

>>
>> If so, why not do it there instead?  You seem to run only "kill" to
>> send some signal to a process using this helper function, and it
>> would be silent on its standard output stream (even though it may
>> say "no such process" etc. on its standard error), so it is not
>> clear to me what you are doing with this change here...
>
> If I run git-p4 tests in verbose mode (e.g. "./t9823-git-p4-mock-lfs.sh -v") without this patch then the last lines of the output look like this:
>
>>>> Output Start >>>
> expecting success:
> 	kill_p4d
>
> ./lib-git-p4.sh: line 172: 26289 Killed: 9               while true; do
>      if test $(time_in_seconds) -gt $timeout; then
>          kill -9 $pid; exit 1;
>      fi; sleep 1;
> done
> ok 8 - kill p4d
>
> # passed all 8 test(s)
> 1..8
> <<< Output end <<<
>
> However, I want them to look like this:
>
>>>> Output Start >>>
> expecting success:
> 	kill_p4d
>
> ok 8 - kill p4d
>
> # passed all 8 test(s)
> 1..8
> <<< Output end <<<
>
> This is achieved with the patch. I am no shell expert ... is there a nicer way to achieve the same?

I get your desired output with the unmodified code from origin/next:

$ ./t9823-git-p4-mock-lfs.sh -v
expecting success:
	kill_p4d

ok 8 - kill p4d

# passed all 8 test(s)
1..8

But that's because my shell is symlinked to /bin/dash. I suspect you are 
using bash - when I run this with bash I get your command output. 
Possibly a bash bug?

As Junio says, it seems a bit weird that we have to redirect the stderr 
of that entire expression.

Luke
