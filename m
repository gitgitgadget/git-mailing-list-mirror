From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Thu, 3 Mar 2016 12:15:07 +0700
Message-ID: <CACsJy8BONz-q7kW4zsOyq4O+YJOmDoNF1tjp5-kDBbPnx7mC-w@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CACsJy8AzZsC3_7mWQutko8W=X1Lch3bMZRjoHtjVnWwtbMBt7A@mail.gmail.com>
 <xmqqwppk2rqo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 06:15:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abLc0-0005Jy-9E
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 06:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbcCCFPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 00:15:40 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36323 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbcCCFPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 00:15:39 -0500
Received: by mail-lb0-f175.google.com with SMTP id x1so10005364lbj.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 21:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lAJfVuCUCEJXlZS04MW0/bLF7oISW06/ZaN5dmYlIfE=;
        b=wuDL0yuIlQly3uxWyjS3hJZgdee/JrJzg4k9IV9J3y+IDlW3NbaLP+uNL6OvbJaYwH
         m7JQ4xcO4ZFL/9p7BNxLhvQruHU+RddzbSMPTHCG3GTFfTPLetAlGOyso8KDhFQou7RN
         3Ky7YGEHNJGXMZBuqmWXGAIc6YlNvytHyWCc7uS8gPy+U5JO20M2aHkqoq2SOZVX1C1a
         6KXuCW9Rp4GFzssxWsl3u/oQf5nDyy+NXAyd1d6FWsiFCBSkl65fetuBBSKuVjFQump2
         2bs/2hh0F0PHAyVArq/RdTL8CfkViHBlc+TVRJFgSNHN6wIcBKu70jzmh3xYhiOXswpP
         0xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lAJfVuCUCEJXlZS04MW0/bLF7oISW06/ZaN5dmYlIfE=;
        b=D46+beI7XgrCjIYuWCfPASijQi1bjm40ZmtCdvb60s28gelFDXdROqIYgLGv0bh7IJ
         E6R474+ykyq+3eR5FrTIOEuStnLtbyqtS8DGojJdBZuEMkMs+63N7QdhXzfnBm6nsQfV
         DmXssOv/AavyXqH5sCK6/bBpkqLHoH/HxW5FdhP88A2dyXWvH6VanlFH32n1MCT6yvx1
         5YU8eJgAS2pffeKKzfUiqjeiIjE7v8VUQFqpfljwsfrdZscHG0ux86cBqIy6iggVCjVX
         Dp3dC9hOdQuFBwVibcnaEI+WxUov7rR7IyMKWyfX3lxsQQ8YN20RY7vaY6bJ3ff/H6nh
         /XwQ==
X-Gm-Message-State: AD7BkJK9ZB0sUpLDGl/Vz4WIwjAlUS0gFMqJjwcHmkSBnpI1yNrs6NXqsOLJHZguvvxQUQ/dM5RVAS0J70EImQ==
X-Received: by 10.25.83.5 with SMTP id h5mr223301lfb.45.1456982137281; Wed, 02
 Mar 2016 21:15:37 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Wed, 2 Mar 2016 21:15:07 -0800 (PST)
In-Reply-To: <xmqqwppk2rqo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288165>

On Thu, Mar 3, 2016 at 9:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> would it be
>> ok if we introduced a minimal resumable download service via
>> git-daemon to enable this feature with very little setup? Like
>> git-shell, you can only download certain packfiles for this use case
>> and nothing else with this service.
>
> I think it is a matter of priorities.
>
> A minimalistic site that offers only git-daemon traffic without a
> working HTTP server would certainly benefit from such a thing, but
> serving static files efficiently over the web is commodity service
> these days.  Wouldn't it be sufficient to just recommend having a
> normal HTTP server serving static files, which should be "very
> little setup" in today's world?
>
> Such a "minimal resumable download service" over the git-daemon
> transport still has to reinvent what is already done well by the
> HTTP servers and clients (e.g. support of ETag equivalent to make
> sure that the client can notice that the underlying data has changed
> for a given resource, headers to communicate the total length,
> making a range request and responding to it, etc. etc.).
>
> In addition,, by going the custom protocol route, you wouldn't
> benefit from caching HTTP proxies available to the clients.
>
> So I am not sure if the benefit outweighs the cost.

What I had in mind was individuals who just want to publish their work
over git://. Right now it's just a matter of running git-daemon and
configuring it a bit. If it was me, I wouldn't expect all the bells
and whistles that come with http. But I agree that this is low
priority, "scratch your own itch" kind of thing. Let's have resumable
clone with standard download protocols first, then we'll see.
-- 
Duy
