From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Tue, 22 Apr 2014 00:00:29 -0700
Message-ID: <5356138D.9040409@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com> <53558AD0.3010602@gmail.com> <53558a663ea74_604be1f30c2c@nysa.notmuch> <53558F6F.7080306@gmail.com> <53558f285f379_640076f2f094@nysa.notmuch> <CADcHDF+XcWEkvyP3tL4ibicnaMVJpixUZu1Ces0BXWkzPGsodw@mail.gmail.com> <53559a8333aaa_6c39e772f07f@nysa.notmuch> <535606A3.8040704@gmail.com> <5356100296994_268bd0b30839@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:00:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUh8-0005Yd-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 09:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbaDVHAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 03:00:38 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47821 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaDVHAh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 03:00:37 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so4547211pde.39
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TtNXh8kQafIQn3kcPXbGGLNTPP3Egj3pu20hE9qYTUE=;
        b=m5Vzdn6dAWQ/7vatvOcGgQkW/RSVe8plqL+EPLmMuE0kMPsn+xL5VgeG0UtODOuu2s
         AhKj/mQrFv6RbAyosBNJzAVLMQ4+nrwkdRi+F9EFdCwjDIMiBHzfIc0Fs7n/Lj4ODk1c
         +9vb65Bhe+0jjaWQvuBX02Du8+aA70roWuikWkr91stTZSmI9UAKZGvcPaIVWC/jI9px
         86V0DND5En+4g4egjkad0iquFvANukck9KkfwU1KGS3wuSJrTvT0dGHvkc/Zw/XzDDLP
         3rwPSTdlNtyiMLzooGDNsrEWGVG3b1jbExIxgoiGoGzcf/7ol/3vaPD9fLmY6cRmfzCI
         Qf4w==
X-Received: by 10.68.110.129 with SMTP id ia1mr1557541pbb.158.1398150036607;
        Tue, 22 Apr 2014 00:00:36 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id it4sm82590785pbd.48.2014.04.22.00.00.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 00:00:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <5356100296994_268bd0b30839@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246704>

On 4/21/2014 11:45 PM, Felipe Contreras wrote:
> [...]
>>>> This is how it is suggested by t/README and how it is done in the other
>>>> test suites.
>>>> I can not see how your case is different, but I might be missing something.
>>> Let's take a cursoy look at `git grep -l "'EOF'" t`.
>>>
>>> [...]
>> So the point is that some existing tests violate best practices?
> I don't know what you mean by "best practices", but these are Git's best practices.

I am talking about recommendations in t/README that I quoted.
