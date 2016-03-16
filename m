From: Igor Korot <ikorot01@gmail.com>
Subject: Re: Is it possible to give specific PR number
Date: Wed, 16 Mar 2016 13:36:02 -0400
Message-ID: <CA+FnnTzCh+3==7g-qNsTcO9934OOrVe9n966oZLEJjg+OusOrw@mail.gmail.com>
References: <CA+FnnTzo=D+dUdpBvPumd48vH667FAOSupBLwR4WTJy7S-TDkQ@mail.gmail.com>
	<CAJo=hJssZ9xQv--3=hT-TO2xXf10jOJjTM4Fr59jpCfP-7oTDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:36:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFMg-0007xr-0H
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934642AbcCPRgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:36:05 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35604 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbcCPRgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:36:04 -0400
Received: by mail-vk0-f50.google.com with SMTP id e6so71043248vkh.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Jq0vOCnR2HDGIFhRe9oeprHedgCWP69P8zBzsryfpwI=;
        b=bBp6uZw0UbY41v46hA++oQ9aNazvs31hGuVzsIlhfwM3s4w8rC0wD8uOGgMMwXT6Bz
         eIiRLiuPDtWoNnsEi1W/86m3MoLmZ1NEcxtRp0ZEmfBUBAmmOcPtikxW7Nfm9YWWptew
         9FRsU+/3iqtVRrEW0xshOcG/ywBjAQwXYWICIuPjHTFef5O5//NVJ0Pkr2jaoVCD0CmX
         hicJa+8K55xjWcIrRR0ac0ln8FWoJ/g5iT3sfpQskqctFLRzJNgE+VfSCQ1YDw8egBez
         xc6RAYQiswpgnu7X2SuydUTdKgNqoOAnHpT0h6GODYcb1+zfuHExoUEOfEaE2ygZLkoY
         /i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Jq0vOCnR2HDGIFhRe9oeprHedgCWP69P8zBzsryfpwI=;
        b=hlSywajypyMEpCCltffIuvu137iWCb1ivTVDpGuaJJRiTgd2K0iueXVzYTl9etpNnd
         8TCWRuzacEKetzpaNoo2PPtxaKT/me5Fdx8YG+U+tZ0Duh6zWrdGCHo7WJ8bM/dcpN6u
         +WwalEEdVGGu13pKAJIW6jRDDeRx6yWtIh+RbLZ4n/Gu+Mg9l/do0v/5sOH7P0hBlo8V
         c2vjaDk3IslosxJO7SvZaUms7SpCW5yPjGZV7DPSv86GDCTILVhvIsz19xSHGzCxW3FL
         Wwqs1G1xLD/gH5dCkZhXzkM3kyrG7l+sYLmSvqA7Aep+9HxmEj90Qp2d2haJutwAUTRn
         1UkQ==
X-Gm-Message-State: AD7BkJJIAw4sYtsibSoItoX0t2thAZo2IMeyICB3HUBliihQqpOHMt6+ZWMhkH6IzxqXha1usjRpoQsKq4GIGA==
X-Received: by 10.31.58.139 with SMTP id h133mr6009241vka.158.1458149762163;
 Wed, 16 Mar 2016 10:36:02 -0700 (PDT)
Received: by 10.31.206.4 with HTTP; Wed, 16 Mar 2016 10:36:02 -0700 (PDT)
In-Reply-To: <CAJo=hJssZ9xQv--3=hT-TO2xXf10jOJjTM4Fr59jpCfP-7oTDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289002>

Shawn,

On Wed, Mar 16, 2016 at 1:10 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Wed, Mar 16, 2016 at 8:20 AM, Igor Korot <ikorot01@gmail.com> wrote:
>>  Hi,
>> Is it possible to tell Git to have a PR with a specific number?
>
> Git does not have PRs.
>
> Are you referring to a GitHub Pull request? If so you should ask
> GitHub support. GitHub is a commercial entity that is separate from
> the Git open source project.

Sorry for the confusion.
I will ask on thje GitHub ML.

Thank you.

>
>
>> If yes, is there an API for that?
>> If no, would it be possible to add?
>>
>> Thank you.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
