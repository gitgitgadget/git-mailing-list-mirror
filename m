From: Zhang Lei <zhanglei002@gmail.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Fri, 25 Mar 2016 19:31:02 +0800
Message-ID: <CABEEbiDRPsL6XJrnyFv43u26hXNbBVmMhbJeZmp+zjS+-jNZ=w@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
	<01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
	<CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
	<CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
	<CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com>
	<CAPig+cS2qMZyUkf9Nekp+QaVkjc1oHXb4QF3wFDnBdF3WMU3iQ@mail.gmail.com>
	<CACsJy8Bs0WFJxGnVOBUnzipZYty-K4D9NkAQdODYqPUw2VAAiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 12:31:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajPxR-0002tY-CV
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 12:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcCYLbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 07:31:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34164 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbcCYLbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 07:31:06 -0400
Received: by mail-io0-f196.google.com with SMTP id p21so9407167ioe.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=v01AIl+Ns027VnelcnvZdnZHEmDeNvS4e+qNOL1Epzk=;
        b=K8VLcQK/NbSNM9I4+Ixt8rD0yqwY6LPLFbHtiOfx3Vy1N2ZoVQwSMXcX9/IWx4cY7v
         UFV8O/Ow5QeuDlefG5X5iqqjRPEAxDM1SrlQyVVdb4riJtyH+/uxZhrl0UKIEjblUVTv
         3b+p8CUTk7M5eHlmPHusc4ubN67WuKPuSsx7wHXYQt+99+iQc/O9ht4dHJ6n7AuSG1be
         1oYDaCr1379DiEgUvlM5IbffyP6af+ZvUUJZq4yEbcvQXdtzjv03kyyjt42i4y9RxmtS
         1QC7z+ha1byA22ge1bl0AeRK6oL3BprNStRfWPwstEkeP1NSFlIEdtpuQi17rv1SkHdo
         9OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=v01AIl+Ns027VnelcnvZdnZHEmDeNvS4e+qNOL1Epzk=;
        b=l14chWHHtKUkGuDp/1iqJzs/CNu7UmE0CI2G9EKplg+2eACYYj8ZcwFSfRVNet855E
         cdcR3XCS+yRmUUycJOEGpMXP4opDRkAl9PxWkIBBJQ+QJrRc/2A/IDjbA6+BRX17069L
         RpFh9W7rNz7eO3yXVwLwSwEdb3qrPS+0WARKnTqgMMULiDTXbSkklCjPJLxs5xpSwKXb
         0R8S7hu8f8slwzTkGoL5LK3t3xhT3DEAUNQLt5D+MT9DCrqTUbeIdHTeNZ4I+zj+nvtY
         4mnV0X2TOCP8Yx/f65mvlNSXsUvvv98fsshazJ4fafEZB6Q8eLo5kOE+XnfdNMEYvy59
         erRw==
X-Gm-Message-State: AD7BkJKrnrcjWttG6MqNDPdmGzj0c2lI8E2D5UQm0WmIEXn/OwCUQFUo/8z4q7olKSXt2tC3v93ZHEfyMmX5Tg==
X-Received: by 10.107.47.41 with SMTP id j41mr12718806ioo.168.1458905462372;
 Fri, 25 Mar 2016 04:31:02 -0700 (PDT)
Received: by 10.107.1.72 with HTTP; Fri, 25 Mar 2016 04:31:02 -0700 (PDT)
In-Reply-To: <CACsJy8Bs0WFJxGnVOBUnzipZYty-K4D9NkAQdODYqPUw2VAAiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289875>

Thanks for the clarification.
By the way, Duy, another unrelated question: why worktree name under
.git/worktrees is being named
after the working tree path basename? I think branch name is more
reasonable since we don't allow checking out
the same branch twice.

2016-03-25 9:49 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
> On Fri, Mar 25, 2016 at 8:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, Mar 24, 2016 at 9:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Thu, Mar 24, 2016 at 5:52 AM, Zhang Lei <zhanglei002@gmail.com> wrote:
>>>> 2016-03-24 17:16 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
>>>>> I think we can follow git-clone and use '-n' for this. [...]
>>>>
>>>> My PATCH v1 did follow git-clone -n, however, Junio C Hamano and Eric Sunshine
>>>> suggested that we should avoid doing so , as --no-no-checkout could be
>>>> confusing.
>>>
>>> My impression was that Duy was suggesting only that -n be recognized
>>> as shorthand for --no-checkout, however, git-worktree already
>>> recognizes -n as shorthand for --dry-run (as a consequence of using
>>> OPT__DRY_RUN), so -n as shorthand for --no-checkout is a no-go.
>>
>> Ignore this. It's only 'prune' which recognizes -n, so it's possible
>> that 'add' could recognize it for an alternate meaning (though the
>> documentation would want to make this very clear).
>
> To make it clear, I don't feel strongly about '-n'. Yes muscle memory
> may count. But if '-n' may become a new confusion source in
> git-worktree then perhaps we should avoid it and go with
> --[no-]checkout
> --
> Duy
