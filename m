From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] commit: add a commit.verbose config variable
Date: Mon, 14 Mar 2016 17:29:28 -0400
Message-ID: <CAPig+cTt+Mi=gOREG2zU7vbtB6qk7dVS3mWeMBY37ZwFp_oZng@mail.gmail.com>
References: <01020153698edabd-73daa5db-3c3e-417b-8d83-6cbc04439d95-000000@eu-west-1.amazonses.com>
	<CAPig+cQ+8+saxsGzV=-C2w-eSaaOf0MYC=zTQbH3CW2G5UE5uw@mail.gmail.com>
	<CAFZEwPP_SZsk+B+1L93snQji=wg728P3Oq94oVJ+ZJkhmdC9Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:29:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afa3S-0005km-Cx
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbcCNV3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:29:30 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35430 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcCNV33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 17:29:29 -0400
Received: by mail-vk0-f68.google.com with SMTP id e185so15853859vkb.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=D5AwYMqW4nactvDYjQFwizA3OawYyFm5PyWDyjjqRwA=;
        b=GcBXu2FZ81wHIFWky0x6DGm9ua5bWXzLFmQb8Orh5/0/NxOaAds+dKuMPEQwNjP5mW
         nb/h6UpKWxqUyMna6YCaAi3p0I+yiIvVK1+rAfaFAhQskrnVeV9ugWZUzBuYaVqTTzto
         Rxt9Fn0A8V9EM2ms531NE18R1y52W8aY4JsuF3KLY+2C4MALOkrXEiw8rytv+3t7QocT
         BEBTTJedHZp91D8hZ3MUFaMbAS26Rb5DcNKQNAGvUswjXAdzENyIL7EjVjo0u+Bzedej
         lQ4Q0M3W/5rGjznH8a6vIpPDg93gzYGKh8jk2qxrG2NpMY/MX8DCfZr+SuQ0lyJ8wuT9
         3SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=D5AwYMqW4nactvDYjQFwizA3OawYyFm5PyWDyjjqRwA=;
        b=F18dcWNGqv9ac40EMxC9lw/b7M69DgOqmPf9WfblcQo7UQOvEK69elLWSaYsdH62NX
         S/rZEjOM/gkQXRXZQ8s4n/ykYe3b4b6hbwV+Wqhu7dVQiBlISNo6mfqAEJEgsJsCYQOF
         qSYifHDVV4FwuerAxBwp72D8TUNc8Nloo4GdhL2KwKo85rUbXYIBF40o/5JMr3gN6kVX
         OZPbnXGN2zLxF0uil8IqTbDrYdmvhiIiPhpbOEJT0UIIEIfU/lWNS9V4cX4L1FHCk8Bj
         r2QGfu7PUtFh6OVhCuLPO2RWjy7+EjeAVmnXrmmWWr31+eYzzp4sOVSGsE7FeI5oP27P
         546g==
X-Gm-Message-State: AD7BkJJrQ9E10aaKQLDgg/5RZcZXtHqCKC+Fmbhw5GUVcH0gk6Yyr8NRUddSWLDvEqt/4t872nuGGYD8Ik0iEw==
X-Received: by 10.31.182.143 with SMTP id g137mr27135833vkf.45.1457990968805;
 Mon, 14 Mar 2016 14:29:28 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 14 Mar 2016 14:29:28 -0700 (PDT)
In-Reply-To: <CAFZEwPP_SZsk+B+1L93snQji=wg728P3Oq94oVJ+ZJkhmdC9Yw@mail.gmail.com>
X-Google-Sender-Auth: nL9NsVt448BJ7SOTrHHEPU5slEI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288816>

On Mon, Mar 14, 2016 at 3:09 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Mon, Mar 14, 2016 at 1:54 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Not at all mandatory, but it wouldn't hurt to add a couple additional tests:
>>
>> * commit.verbose=true and --verbose
>> * commit.verbose=false and --no-verbose
>
> I was thinking of putting these tests as when I was debugging (simply
> by printing verbose variable), I found that when commit.verbose=true
> and --verbose the value of the variable `verbose` is 2. But then I
> thought it wouldn't be that useful. But since you have pointed it out
> now, I will definitely include them.

The '2' is a result of OPT_VERBOSE() supporting multiple levels of
verbosity (that is, "--verbose --verbose" could give more noisy output
than "--verbose") for commands for which verbosity levels make sense.

In this case, I wasn't suggesting these news tests for that reason,
but merely to prove that the combinations behave in the expected way.
By the way, the just-submitted v6 seems to be lacking these new tests
(though, as I said, they are not by any means mandatory).
