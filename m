From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 20:42:18 +0700
Message-ID: <CACsJy8Do-djwjVP1YvGnvsbdiWjE47KTK4pZZ3Qdnubvd-r3Lw@mail.gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
 <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8DTKZgVM7TSBUKJq2pspkR1jH-fyG6BHr1YYz3N+Ov3XA@mail.gmail.com> <CAMP44s0cpAkAUzo0nS55yv+6=cCBsBhgNiYxpEd8Hzk=3mfNhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:42:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgeV-00009P-Q3
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966046Ab3E2Nmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:42:51 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34388 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966007Ab3E2Nmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:42:50 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so3055021obq.7
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J0VhVKJ6Atttw5+dNnAdsyaLyockqQTtWuE8mkyPcZM=;
        b=KQUKWxNV263DClW4xUNKXTkyCzLcN8gPK9Ki/1nxY/yVSxLRu/v03YiFkZZYeJ3l4z
         5m7K2d3AobsHeydfhEM3rBB71oQOTsVPijCAQHHowxpRLm0DCHt9ep2Dq3IB3KdHKps6
         6xFUpHMpgDfcob+beM4Aybzwybh7RbBGmFu0iX1abyUTyr8ByE9JkcMybbInQzHZVo+O
         hVWCptQR/N5TiMo8wYr0vEYzJqQz1xY7k1P9LNE/x5XCYIt32pVAy2E7totd+kVOpWhI
         1BErygoBhTCK3AhPYXMxTAI1USEtU8xgz3RfDWsPeqCBK6RKhL0P14VQaP82slMRmwlu
         pVGQ==
X-Received: by 10.182.111.164 with SMTP id ij4mr1631141obb.59.1369834969897;
 Wed, 29 May 2013 06:42:49 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 29 May 2013 06:42:18 -0700 (PDT)
In-Reply-To: <CAMP44s0cpAkAUzo0nS55yv+6=cCBsBhgNiYxpEd8Hzk=3mfNhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225822>

On Wed, May 29, 2013 at 8:34 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 29, 2013 at 8:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, May 27, 2013 at 11:52 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> We should free objects before leaving.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> Micronit: perhaps you should move the "free obejcts before leaving"
>> (in do_pick_commit) to the subject instead of "trivial fix", which
>> adds no value to the patch.
>
> Perhaps. I prefer it this way because it's really a trivial fix not
> really worth much time thinking about it. So when somebody is browsing
> the history they can happily skip this one. The time save by not
> reading I think adds more value than any succinct description that
> would force each and every patch-reviewer/history-reader to read it.

Some time from now, assume a ridiculus case when this function grows
more complex and somebody wonders what the "leave" label is for, "git
log --oneline -Slabel:" showing "trivial fix" would not help much.
--
Duy
