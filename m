From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Fri, 27 Feb 2015 16:46:47 -0800
Message-ID: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
	<xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
	<CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 01:46:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVYT-0003AG-5z
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 01:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbbB1Aqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 19:46:48 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46779 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbB1Aqs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 19:46:48 -0500
Received: by iecvy18 with SMTP id vy18so35162575iec.13
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 16:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fHgtuuK7NPQTN9zt8vfE0CsmnXH1EbhyGh3Zmiq53sU=;
        b=S+ubPgh7oKz3T+s0YCyL2bvrrB7K2pw7ylImmy1MWC3mAWXWOVpPTn+4dII7yZQhUW
         RnDcFvP5QbcfuZMmDKzzdZJf5H2wZnUg5b9GV8BkfbD8acyrH57qOIW0f5OPi08Uf19m
         wLSgmnajbyFLv4YuVGu1iIxsrjnjHqrWYVBIYd8h9CojwcMSmY0BBSBJZWLFvpsBtSdW
         azrFn8bMMwu8Cl6dcfxMOVwvSRSV5GbJUpeIfevoTivEUB+TAuqru6cU3os5y+bEKfRE
         N6AotoZNmjkbfDweBwlYqvd9tMvUMf8jsaeoVNOVKVC/XZ1P8XDmDfQ8GouvOZCjFz8w
         2W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fHgtuuK7NPQTN9zt8vfE0CsmnXH1EbhyGh3Zmiq53sU=;
        b=BWoSRzkfeljxHwOtg5NcFp1gh+tBNA+oWbRPx/o2CDoubWPj6yN5jFR8CCDSGBUCEE
         5qwa/1s1MXiQshyl1IbmI9AOXWfU/931zp1UJgZb2G43Qt/zOW7Jv5yNvz7HspVH8W7e
         2L+WGPFugdjoOQcRsMcN8a95ZSnX57/tgEqC4GoxiptWuhG8DfB8GTmXaqrWSE97enYn
         AXUWs7Ps94AT7gCfOTE9rUztU4PC/QQXvRIso+khFOOvN9fj0iHQlR/v3/ipaeHO+4AX
         1ifA/OCOtxCkkHdrKVW/b6AmUzUxsr9qrhlcvGhBDtp35zXTg9pcEMBiMty7aYL8ANq/
         EIdQ==
X-Gm-Message-State: ALoCoQkxrctgUfR40HJdoaehX1awfK6lsKLEn7ofz7QsAnFwg4GqfxdjVo3KLvs0e4b3qKeQy10S
X-Received: by 10.50.107.36 with SMTP id gz4mr8046171igb.25.1425084407343;
 Fri, 27 Feb 2015 16:46:47 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Fri, 27 Feb 2015 16:46:47 -0800 (PST)
In-Reply-To: <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264517>

On Fri, Feb 27, 2015 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, Feb 27, 2015 at 3:44 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Fri, Feb 27, 2015 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> I am _not_ proposing that we should go this route, at least not yet.
>>> I am merely pointing out that an in-place sidegrade from v1 to a
>>> protocol that avoids the megabyte-advertisement-at-the-beginning
>>> seems to be possible, as a food for thought.
>>
>> This is a fun thing indeed, though I'd personally feel uneasy with
>> such a probe as
>> a serious proposal. (Remember somebody 10 years from now wants to enjoy
>> reading the source code).
>
> That cannot be a serious objection, once you realize that NUL + capability
> was exactly the same kind of "yes, we have a hole to allow up customize
> the protocol". The code to do so may not be pretty, but the code to implement
> ended up being reasonably clean with parse_feature_request() and friends.
> After all we live in a real world ;-)

    - new server accepts the connection, but that no-op probe has
      not arrived yet.".  It misdetects the other side as a v1
      client and it starts blasting the ref advertisement.

A race condition may be a serious objection then? Once people believe the
refs can scale fairly well they will use it, which means blasting the ref
advertisement will become very worse over time.
I'll try to present a 'client asks for options first out of band' instead of the
way you describe.

Also we should not rely on having holes here and there. (We might run out of
holes over time), so I'd rather have the capabilities presented at first
which rather opens new holes instead of closing old ones.

(assuming we'll never run into megabytes of capabilities
over time to have the same trouble again ;)
