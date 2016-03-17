From: Levente <leventelist@gmail.com>
Subject: Re: Windows download broken?
Date: Thu, 17 Mar 2016 09:13:33 +0100
Message-ID: <CACwWb3CAZUrM9TGwf7NfDMHZ0UvMc2RPqz9C9my3baf9z5mPrQ@mail.gmail.com>
References: <CACwWb3Dm8CfhZKvfNz-4Pj=tytf3zroFxnbbTq9DM+xm4EPEig@mail.gmail.com>
	<CAGZ79kaz2xPUO+zUK9LSqwWPK0aYPirwjgwzKmZgGbscxq6anw@mail.gmail.com>
	<alpine.DEB.2.20.1603161907420.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 09:14:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agT4J-0005qz-6l
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 09:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183AbcCQIOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 04:14:00 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35503 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbcCQINf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 04:13:35 -0400
Received: by mail-io0-f180.google.com with SMTP id o5so5764667iod.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=SGThr7RRqFwInATJCUH45D/F2cCuvodJZwbTvC8FP7o=;
        b=qMNyCFi7l5/i8CZb3oEMVQWOhF771dxxAJyTI1shjRQ0sMO0vxicyEUuz8cyKxOp/x
         Tx5nsRcMZPlpQVUZmZQLklc0J6tHEdIq1a9D5UT+cM1WHt6eL3X2vVoG9rQTiwwtcXCB
         IIbTwixtAZkZTCNJ3Uxz2zl3elgKok19Y0wblLY/ke48GDuIe/0gkLIOXt1dgeMatvET
         0mbVPpbyWltTaVo/vYVIcI+QbQpKqwYdjYXkUhJbpe3byYRJXLlnAV3FVsf9y35evjpg
         n0rNIrzbJRTnE6wIdtV7OTEeNutqMuyNileabeAtrZeZIpWvtzlD27ai0SQeejqC2qwd
         XptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=SGThr7RRqFwInATJCUH45D/F2cCuvodJZwbTvC8FP7o=;
        b=WRpfUCuhYdDBmq9xqB+iJeoKFs0AanOgF9rqprOzXrF0Fe7p3lsVWU892j45jdtgkK
         +20Rn2AyZfTzoxg5skcsYcpBt2eWSd2naGlLDAbA6kuE2xmByhE5sNqJQFtp+C4w9SmN
         CN0Q0sp6fY2xcvTX/tFyI9DhdTegzlqpHPqUCSfn1r4NEvUqeGtltnhKB2oDt+mF8+WJ
         0W7lZaWeAHh5SNPhBLF0yzaCd8MmL/OzgE0IDkzciEJjP6foWMezfeOI+UCgmblSjQ/G
         ClhMOFAHme/xu5vCM0fLBBP5IQpqpMUZV2XiWsaGFm39ZON7IdFWPLPQdABv2UirK6oT
         Da2Q==
X-Gm-Message-State: AD7BkJI02FEpjJqoLZsrC3QNEbcOUI27M1+oN3PSZuTNYhs2iL22JN2NPbS0vohzabMrSRkvTzD37Kq7/nNkEg==
X-Received: by 10.107.165.140 with SMTP id o134mr9410852ioe.62.1458202413640;
 Thu, 17 Mar 2016 01:13:33 -0700 (PDT)
Received: by 10.36.133.195 with HTTP; Thu, 17 Mar 2016 01:13:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603161907420.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289087>

Ok. It waits for github.com, and then my browser gives a timeout for the site:

https://github-cloud.s3.amazonaws.com/releases/23216272/cd833b56-eaf0-11e5-803d-af3ef12f7a03.exe?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAISTNZFOVBIJMK3TQ%2F20160317%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20160317T081038Z&X-Amz-Expires=300&X-Amz-Signature=1e729ce5b850ad198f624487ded05f27553aa0d8602aae67ece47f3499e322d7&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3DGit-2.7.3-64-bit.exe&response-content-type=application%2Foctet-stream

I am behind a corporate proxy, so that can be a problem. However, rest
of the world seems to be okay.

Any hint is welcome.

Lev

On Wed, Mar 16, 2016 at 7:08 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Wed, 16 Mar 2016, Stefan Beller wrote:
>
>> On Wed, Mar 16, 2016 at 7:06 AM, Levente <leventelist@gmail.com> wrote:
>> > It seems that this link is broken:
>> >
>> > https://github.com/git-for-windows/git/releases/download/v2.7.3.windows.1/Git-2.7.3-64-bit.exe
>>
>> I think Git for Windows is discussed mostly in the GitHub issues.
>> Anywhere, cc'ing Johannes, who does Windows releases.
>
> Correct, on both accounts. These days, I read the Git mailing list,
> though, so all is good, people can report stuff here (I sometimes even
> look at bug reports via Twitter, although they are all lacking too much
> detail to be really useful) ;-)
>
> Ciao,
> Dscho
