From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 16:29:28 -0500
Message-ID: <b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: tytso@mit.edu, Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 22:29:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsNHv-0008Ff-9B
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab0CRV3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 17:29:50 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:48581 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab0CRV3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 17:29:49 -0400
Received: by fxm19 with SMTP id 19so90317fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=8Y03TVwQGvDpFst61W7ysUPL3gPS7x4SDjvUG0eRIKw=;
        b=YLHHfp9U3/Ar4gHsV9hu+p3PxB/xPCAFXSSAV5BAQqPq9H0b+SXeHc5Hfn4T3ttEkS
         wZhPbTRUtQzrSVMzbdx6gUyGhzknYfY9lqZz8fQDJMAybrS6+aNXFHDImD3qAf1QQAKE
         rEV1gpHn2c4rtkAPdbg6JUZCsfUmEJ3PLMCTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pBSszWcP7LfLjecYJKeFaOHDJrvGMqsaGgfN15GZTL+eNrK4TpnxjbIYGa+chLGTF/
         yyJQTcfaMh7emLKaWuoD3e8Gs29bFCXu4KHMKQ2TGHMvsdwr7B8KY2Mcx8j0Fm2hmRtW
         dleD9y06zh7E+v/AEorqWxAcdpdueBK/mAYrQ=
Received: by 10.239.187.210 with SMTP id m18mr777643hbh.19.1268947788143; Thu, 
	18 Mar 2010 14:29:48 -0700 (PDT)
In-Reply-To: <46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142522>

On Thu, Mar 18, 2010 at 16:19, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Mar 18, 2010 at 5:12 PM, Michael Witten <mfwitten@gmail.com> wrote:
>> This is all that I'm saying: Keep git exactly the way it is, but add
>> one extra piece of identifying information for each person.
>
> What's the value? For me it'll be "Martin Langhoff". I already have that.

Well, that's rather egotistical considering you're probably not the
only Martin Langhoff in this world. I'd advocate something like
"Martin Langhoff <martin.langhoff@gmail.com>".

At worst, things will be just like they have always been.

Most likely, all that will happen is identification entropy won't
increase nearly so rapidly and there might be other benefits such as
shortlog speed improvements.
