From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 16:46:50 -0500
Message-ID: <b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: tytso@mit.edu, Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 22:47:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsNYq-0008UG-Lv
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab0CRVrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 17:47:14 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:49803 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab0CRVrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 17:47:12 -0400
Received: by fxm19 with SMTP id 19so104462fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=yCh6GvaenPhqwiNAPekSbCrnCoF+Innq3em8xE0hDG0=;
        b=kZ/FQpUSJ4RCUrEjGBRbPU3PqhfBdxTT6RlrLoeFIfjKVCV4CYESNbBaqAdi8Sd9HY
         f5EMIXc4zMvpXkJdenJGt/fVyqTIfsaACJA5eHHUgArCFUpCKpb0Wx6JwVlPAx9oDKJ1
         oIVJEBtEi2Qqz/PSbIypG9B3UwFEqUOkgbB/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fd5svj2I58Gh1ZYEknkAPr5BxE1O7hN3QzeDdqt2RWTZn4NPk6LJZqskMRphWNjjtr
         QzrNW9zSkyrlO6ihR9PED24LbNG2t5hsD7qszw4bWsoVk089wnzUWTmSImZpdBmPEol+
         1uBVqXKJFW0TiY8qLzsmw/fKKXERvmwrwlDio=
Received: by 10.239.188.200 with SMTP id q8mr1056120hbh.26.1268948830185; Thu, 
	18 Mar 2010 14:47:10 -0700 (PDT)
In-Reply-To: <46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142526>

On Thu, Mar 18, 2010 at 16:39, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
>
> Here's a hint: using your "uuid" model, I'll get some commits into a
> project with the wrong uuid. Because I made a typo, or changed
> machines (and a random uuid got created), whatever reason. So now in
> my project I appear under 2 uuids.
>
> What should we do in that case? Use mailmap to map the stray uuid to
> the "real" one?... Have we done a lot of work to get back to square 0?

Again:

>> At worst, things will be just like they have always been.
>>
>> Most likely, all that will happen is identification entropy won't
>> increase nearly so rapidly and there might be other benefits
>> such as shortlog speed improvements.
