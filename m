From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Tue, 24 Feb 2015 15:37:27 -0800
Message-ID: <CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 00:37:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQP2j-0006nw-FN
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 00:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbbBXXh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 18:37:29 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:55588 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbBXXh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 18:37:28 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so31288706igk.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 15:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2psfXFjiGO3vK22DEVPwm4mXur6h+pf4vcTzdOBiR+I=;
        b=emO+eUgcWUHbREsBZxr3VSHtZFo/iKfj3r86I5HZMkh3dQBejHyeg6jo2bPLQLBuM1
         JNKO8P95uKEiQ54Qedg3/QvWHrmI7dCNWxfXfEyBQGCFDRe5lzeMxlnmHeuOfnAJSQgM
         wCA6nwFRyMVRS8UZqJtG3Zhe6+il4EFAKsUWmQB8jcNTWcpec3jEoICYOi1oeirKV2mi
         hehtGatYSLuIGQcyO+fRqWzzBGTIA+vnynv6ETGwLkaCAMwJZfRQ7nR3bEa2yUkpNzUQ
         c8Tx4gQQ67QU9p3LSWogI/HWjl4/WCfPc8GOR+8m08ZYEM7Wq0EojtXBE8xONLY8K0Dw
         X82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2psfXFjiGO3vK22DEVPwm4mXur6h+pf4vcTzdOBiR+I=;
        b=ajYc0tk3vzwHVo/eSe9G41VVd/XUrYayr3TP+7ttrlukMEFN7BaBBowvj03ND79ifC
         gzdVwtEC7lO7l+sPw7SNrekzFNZ9FtcgJRpPr0iOZS2YVsksIdB9mgzwuApXV7iuemBY
         w1FDvSgOXDe4VDcPDxqQC43jW0peab/xrjlORjPuSrjEnsOqHI9Ll1bHZbKf++e7k7VG
         JhDNLdENzHcLQJ7jiyxA8SPVvlHSIYjPojbl3E7bJjtWhqX9cbyDYguqjw1vFloymPVu
         hLiOr02mTcES/i7iN65RYyDSKOv3BqOpGe8LszvRJUbTWmj4JA6TOc9TX+BylESuxfto
         JpCw==
X-Gm-Message-State: ALoCoQlbFjs1svQG/y3iMREH188Tkven7/ZHbeqTHTipvZFPddh+j2zB9rTuFxicYpFk480a4CfO
X-Received: by 10.107.130.25 with SMTP id e25mr895235iod.49.1424821047752;
 Tue, 24 Feb 2015 15:37:27 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Tue, 24 Feb 2015 15:37:27 -0800 (PST)
In-Reply-To: <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264360>

On Mon, Feb 23, 2015 at 10:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Feb 23, 2015 at 8:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> It's very hard to keep backward compatibility if you want to stop the
>> initial ref adverstisement, costly when there are lots of refs. But we
>> can let both protocols run in parallel, with the old one advertise the
>> presence of the new one. Then the client could switch to new protocol
>> gradually. This way new protocol could forget about backward
>> compatibility. See
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/215054/focus=244325
>
> Yes, the whole thread is worth a read, but the approach suggested by
> that article $gmane/244325 is very good for its simplicity. The server
> end programs, upload-pack and receive-pack, need to only learn to
> advertise the availability of upload-pack-v2 and receive-pack-v2
> services and the client side programs, fetch-pack and push-pack,
> need to only notice the advertisement and record the availability of
> v2 counterparts for the current remote *and* continue the exchange
> in v1 protocol. That way, there is very little risk for breaking anything.

Right, I want to add this "learn about v2 on the fly, continue as always"
to the protocol.

>
> So if we are going to discuss a new protocol, I'd prefer to see the
> discussion without worrying too much about how to inter-operate
> with the current vintage of Git. It is no longer an interesting problem,
> as we know how to solve it with minimum risk. Instead, I'd like to
> see us design the new protocol in such a way that it is in-line
> upgradable without repeating our past mistakes.
>
> I am *not* convinced that we want multiple suite of protocols that
> must be chosen from to suit the use pattern, as mentioned somewhere
> upthread, by the way.

I do think it makes sense to have different protocols or different tunings
of one protocol, because there are many different situations in which different
metrics are the key metric.

If you are on mobile, you'd possibly be billed by the bytes on the wire, so
you want to have a protocol with as actual transport as possible and would
maybe trade off transported bytes to lots of computational overhead.

If you are in Australia (sorry downunder ;) or on satellite internet,
you may care a lot about latency and roundtrip times.

If you are in a corporate environment and just cloning from next door,
you may want to have the overall process (compute+network+
local reconstruction) just be fast overall.


I can understand, that we maybe want to just provide one generic
"version 2" of the protocol which is an allrounder not doing bad in
all of these aspects, but I can see usecases of having the desire to
replace the wire protocol by your own implementation. To do so
we could try to offer an API which makes implementing a new
protocol somewhat easy. The current state of affairs is not providing
this flexibility.

I think it would be not much overhead to have such
flexibility when writing the actual code for the "very little risk" v2
update. So instead of advertising a boolean flag meaning
"This server/client speaks version2", we would rather send a list
"This server speaks v2,v1 and v-custom-optimized-for-high-latency".

I started looking for academic literature if there are generic solutions
to finding graph differences, but no real luck for adapting to our
problem yet.

Thanks for your input,
Stefan
