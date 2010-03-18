From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 17:02:06 -0500
Message-ID: <b4087cc51003181502y1f339cf8u268fa5388ace098@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> 
	<b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com> 
	<46a038f91003181455u7136e011u5352c996384f086d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: tytso@mit.edu, Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 23:02:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsNnV-0001Kg-AA
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 23:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab0CRWC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 18:02:28 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:57377 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab0CRWC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 18:02:27 -0400
Received: by fxm19 with SMTP id 19so116509fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Jdm1C3F75zfwPvkS4O78hMWeqsIJMWMhbuRsh3tqFcw=;
        b=it0SKfGu6gVp8IJDjSRAdowK9SX49OhZnjwEKaYnYXQ0v1bjhJulUu/c/YdkR2f418
         uH77owX8WLlM8Q4MG+07adIm2RVGKvQC5CtWkuIvrbDov21N4/Yfk5tmJCtBP01KYivV
         fo2aoVBjjR0ycQIwQ8N3vxdLArxAu61pv/IOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=T93wEn/DJDgM0JcM/d3woPOJU2Ey9JeWP9YanvU7S2LH1FOWuI8U87dIcnMGf7MJfC
         U7O+Zs2VvttUIPmpk3hVIhQ17HayrVYg9d+03fPKxtLuF4jgSWBOl0bDzz0DWhoJQnYw
         oYKH9/gOpM3tu7ZaupFdZVSmt+T2YTNPQrI2g=
Received: by 10.239.185.81 with SMTP id b17mr1572076hbh.191.1268949746131; 
	Thu, 18 Mar 2010 15:02:26 -0700 (PDT)
In-Reply-To: <46a038f91003181455u7136e011u5352c996384f086d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142528>

On Thu, Mar 18, 2010 at 16:55, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Mar 18, 2010 at 5:46 PM, Michael Witten <mfwitten@gmail.com> wrote:
>>> What should we do in that case? Use mailmap to map the stray uuid to
>>> the "real" one?... Have we done a lot of work to get back to square 0?
>>
>> Again:
>>
>>>> At worst, things will be just like they have always been.
>
> Of course we all read that line.

You missed the other line (probably gmail's fault):

Most likely, all that will happen is identification entropy won't
increase nearly so rapidly and there might be other benefits
such as shortlog speed improvements.
