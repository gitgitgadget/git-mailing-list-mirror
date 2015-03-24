From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Tue, 24 Mar 2015 10:42:12 -0700
Message-ID: <CAGZ79kZ22Fo5xGrk3x5+hV6WdbUg0A0h1fXgPBukenOxqyxVZw@mail.gmail.com>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
	<xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
	<CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
	<CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
	<xmqqioekawmb.fsf@gitster.dls.corp.google.com>
	<20150302092136.GA30278@lanh>
	<20150303103351.GA4922@lanh>
	<xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:42:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSqX-00022A-70
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbbCXRm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:42:28 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35114 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbbCXRmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:42:13 -0400
Received: by ieclw3 with SMTP id lw3so3510126iec.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FWgnN84hRsWtuzrpxHM3uS8Imfq1HtP39/fgqIDfjzs=;
        b=HV74TzjaxGwJFiGtX8HyCpIsPtqKwiv/w3xezyhQERoJgJws/BnlRjEI2WKSIQNNEi
         ublTQPO4rbc6onjKqMTpeFG34+p+THNHXP6v2CmlyrH2QnTUgFM3in5ezPT8iIZdmKdS
         xxd4lcs1nJKoQ5ZjPqjaPrYb09JX3z2p+66HZwCDnnMfXLWUy59R+kjkyRcUT9pn6lgX
         XI8BK0eR392orEYasQneTBZBkZzC2qcJ38TX/eNq92mhWUBYVOQu5YJ/cC1PKm0IZPOy
         VSzc8KvQsPje0oGMeesdOKGL+7UxzmC2/6vko1/lYU4G6kZvf+9XvY7PtZzz1QDTzlfi
         3i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FWgnN84hRsWtuzrpxHM3uS8Imfq1HtP39/fgqIDfjzs=;
        b=hvTI45XobTjlk2wTeQWNS89atQzaCQia9X0B0+r0wm4TSZgyu7ZmXYjiEvbauOLQs1
         q0RXcznk+UVRYUPTttyxz6zqSBG5ZiaCdTiLmb1KY9E2VP++p5HgqWHw/ZvAdyzHrfxb
         aFRkUdKdFG90GcZogr+9i4EPg7yZT5ZWlc7UHpYfFefDAsWwBin3jKeVBbLgq0etY+J9
         3jLpJ5R2/q8IJzIGXvh/KGKNuH4wj1CvpELMbdsMbmUp5aaeDKpiXptl7sLFedXFkZLh
         K8PmMkY49NeWXW+LDPqZEiFWlTixjnIW98865jG8SZ4HHhptc8Bbhl8KbqRQboK7fOhe
         /JsQ==
X-Gm-Message-State: ALoCoQllcGAC62Y/W7KHoQnMiUbVROaG/nA3hsx/DJRbWPAxbN4dZ/KpE09yJ+6La7KgOvfrz+m/
X-Received: by 10.42.30.139 with SMTP id v11mr23015103icc.76.1427218932536;
 Tue, 24 Mar 2015 10:42:12 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Tue, 24 Mar 2015 10:42:12 -0700 (PDT)
In-Reply-To: <xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266210>

On Tue, Mar 3, 2015 at 9:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Junio pointed out in private that I didn't address the packet length
>> limit (64k). I thought I could get away with a new capability
>> (i.e. not worry about it now) but I finally admit that was a bad
>> hack. So perhaps this on top.
>
> No, I didn't ;-) but I tend to agree that "perhaps 4GB huge packet?"
> is a bad idea.
>
> The problem I had with the version in your write-up was that it
> still assumed that all capabilities must come on one packet-line.
>

So I started looking into extending the buffer size as another 'first step'
towards the protocol version 2 again. But now I think the packed length
limit of 64k is actually a good and useful thing to have and should be
extended/fixed if and only if we run into serious trouble with too small
packets later.

I mean we can add the possibility now by introducing these
special length 0xFFFF or 0xFFFE to mean we'd want to extend it in the
future. But when doing this we need to be extra careful with buffer allocation.
As it is easy to produce a denial of service attack if the receiving side
blindly trusts the length and allocates as much memory. So having a 64k
limit actually helps preventing this attack a bit as it is a very small number.
