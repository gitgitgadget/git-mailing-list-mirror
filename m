From: John Tapsell <johnflux@gmail.com>
Subject: Re: git log -p unexpected behaviour
Date: Wed, 1 May 2013 08:23:32 +0100
Message-ID: <CAHQ6N+rs1miLLUWsGvu5W-nUxU9NK30JEo8gcjXpdGLLXvqK7g@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
 <20130420140051.GB29454@ruderich.org> <7vd2towdiq.fsf@alter.siamese.dyndns.org>
 <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
 <20130421102150.GJ10429@elie.Belkin> <CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
 <20130421160939.GA29341@elie.Belkin> <7vli8bu3ne.fsf@alter.siamese.dyndns.org>
 <CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
 <7va9ogezzx.fsf@alter.siamese.dyndns.org> <vpqy5c0oson.fsf@grenoble-inp.fr>
 <CAEBDL5W-xuNhyL81TBGhriAr2jM7CC3FtLhfcbEfEAf9GjCJAQ@mail.gmail.com>
 <CAHQ6N+pDeeZBabiArTXJy9POv10xCBU+=46YdYmW0Ge1qVgUCA@mail.gmail.com>
 <7vd2tbdcsa.fsf_-_@alter.siamese.dyndns.org> <CAHQ6N+pgz3yzFCumgRd3yzpxpqFbkMSzB=tHxmY5hdhzTjeXAg@mail.gmail.com>
 <7vvc73bvp9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 09:23:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXROP-0004mT-3k
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 09:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab3EAHXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 03:23:54 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:44905 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab3EAHXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 03:23:52 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so1171792iag.14
        for <git@vger.kernel.org>; Wed, 01 May 2013 00:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=iD4lhuGoKnjhimWkJgjLZqBV84CkYiSBTsWRKRvlzDM=;
        b=0AuqnHoGxQU4WUEJGU7OysM654gXlbiD7aGze/+SLeGVlVU0SfDnzp30nRtZtS8MZj
         x0ZpFKnZT9UHgXEnJzXr2xocpbODPtWr6gHgoi8tf+fXzv1D10GQiA4pR7Is71VYNrem
         1+dTyaXP9DdsRkLRLNwXn956bhxdgESqdCfLRkgtPbZ9ceLT0OxpqAZCEm4L6Kh4ke7L
         qxqGpewZJfnfvymKYHY7vYg9dZfcBtsPxXZ6+aoJqY5wpp5t3iKarC4X1R4xyeH+Xdhl
         3zd8kYPEWa6o+ej4k0O3b2sWrc9Qs/ARcCPa/hmmq5br1tgnZpXAWebLUc1CzjxCEI23
         GxwQ==
X-Received: by 10.50.147.100 with SMTP id tj4mr4217675igb.19.1367393032185;
 Wed, 01 May 2013 00:23:52 -0700 (PDT)
Received: by 10.64.8.235 with HTTP; Wed, 1 May 2013 00:23:32 -0700 (PDT)
In-Reply-To: <7vvc73bvp9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223072>

On 30 April 2013 21:38, Junio C Hamano <gitster@pobox.com> wrote:
> John Tapsell <johnflux@gmail.com> writes:
>
>> On 30 April 2013 20:44, Junio C Hamano <gitster@pobox.com> wrote:
>>> John Tapsell <johnflux@gmail.com> writes:
>>>
>>>> Is there no way to fix --cc to work even in the edge cases?
>>>
>>> Can you clarify what you mean by "fix" and "edge cases"?
>>
>> My understanding is that even with -cc there will be changes that
>> won't be seen - and hence why --cc could be even more of a "security
>> risk", no?
>
> Combined diff is a way to show a tricky conflict resolved in a
> tricky way, so that the tricky-ness of the resolution can be
> examined.  A trivial resolution that takes one side is not shown
> because it is not usually interesting.

I don't really understand your point sorry.  In this trivial
resolution case, you would still just see the commit that added the
code in a later commit.  No?

There couldn't be a case where you add or change a line of code, but
not see it with --cc ?

> This design choice of course
> have to trust people involved in the project do not pull from
> untrustworthy sources.
>
> You would need "log -p -m" (without any pathspec) for the kind of
> "security" you are talking about.  Note that "-p -m --first-parent"
> is not necessarily enough.

This results in seeing the same change more than once though, right?
