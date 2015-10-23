From: Xue Fuqiao <xfq.free@gmail.com>
Subject: Re: ancestor and descendant ~ clarification needed
Date: Sat, 24 Oct 2015 07:11:33 +0800
Message-ID: <CAAF+z6Guy4h8XDHkgkAmxLftfTTsXrDAd_ezFCQzdiWncvVSTg@mail.gmail.com>
References: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
	<xmqqfv12r6vn.fsf@gitster.mtv.corp.google.com>
	<CAAF+z6H+wwCOhPCU-_Uh-Odc=411N+G+d_iE_AKX+JxVMDtsMQ@mail.gmail.com>
	<xmqqsi51plpz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 01:11:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZplUo-0004X4-IY
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 01:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbbJWXLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 19:11:34 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33504 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbbJWXLe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 19:11:34 -0400
Received: by igbkq10 with SMTP id kq10so44018793igb.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=28AJnZyg7N1S2f/1y6ahIoM5Fppbxn1Vv10Z5mVuEAk=;
        b=rE06KUNdTw1/ebv7RllLNzSRHIF4sQlMAkVbDyTCH/UmGXsmM86n9Yx0KxDXHnQSEn
         +c9H9hqFWeDGC/OIIb+XFTvSQEb9gM7lLggNF7T01XipeWqOvFVSJE0FBIpUWRadem0g
         /ojH8+8eClKXgbCGcYcImvhg0XQKLRkvUV8t5eJVa7PxTz1JZaAIrTjqsSbg9dBKS708
         EeOXGEXFHeg8oKSE84zw5rTDRsR1ddJi/5U00vECLft4WztOQdhRKK2HXpm3w2sERG+R
         ycp4hx4AogR/NP7xT7c8zOodJnJnPi1+R9fntC2ZWgi9dgyBcX861av2hhfWf/5QKrol
         Ltxg==
X-Received: by 10.50.117.65 with SMTP id kc1mr7607892igb.4.1445641893639; Fri,
 23 Oct 2015 16:11:33 -0700 (PDT)
Received: by 10.79.94.2 with HTTP; Fri, 23 Oct 2015 16:11:33 -0700 (PDT)
In-Reply-To: <xmqqsi51plpz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280113>

On Sat, Oct 24, 2015 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I see.  Thank you.  What do you think about the following minor patch
>> for user-manual.txt?
>
> While the updated text is more correct than the original, I do not
> know if that is sufficient, or we would also want to mention the
> "Already up-to-date!" case here while at it.

I thought about that, and IMHO it's not needed.  The section name is
"Fast-forward merges" and intends to introduce the "fast-forward"
concept, which is irrelevant to "Already up-to-date!".  Although the
"Already up-to-date!" case isn't mentioned all over the manual, it's
pretty clear to me (as someone who isn't quite familiar with Git).

>> -However, if the current branch is a descendant of the other--so every
>> -commit present in the one is already contained in the other--then Git
>> -just performs a "fast-forward"; the head of the current branch is moved
>> -forward to point at the head of the merged-in branch, without any new
>> -commits being created.
>> +However, if the current branch is an ancestor of the other--so every commit
>> +present in the current branch is already contained in the other
>> branch--then Git
>> +just performs a "fast-forward"; the head of the current branch is moved forward
>> +to point at the head of the merged-in branch, without any new commits being
>> +created.
