From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PUB]What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Mon, 31 Aug 2015 09:48:53 +0200
Message-ID: <CAP8UFD0LsjPz-Ap7_eQMUmdkePOv=mn6Q-asuJbtPme5uT5GYA@mail.gmail.com>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
	<vpqzj17hpt8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 09:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWJpq-00030O-IO
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 09:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbbHaHsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 03:48:55 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32982 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbHaHsy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 03:48:54 -0400
Received: by vkbf67 with SMTP id f67so28672288vkb.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=S9/rkXWX5gtsaOBMb9zxQckqDLBqy39xrlXzx/ciu4I=;
        b=ZbAZSS5yL9+x+mt0X17PMHXSEKJljVhbh8eNGGyGxJQ6xmt2LDT6MtgA4YIHJOItd0
         mi820dMCXq6NibVpeS2wtKFAv6oxGMUFvPlGzXyWMaMF0R/QYB9sh06vo8y6uurTc/jF
         YWqm+vntosPGUStqPhxq2dEYuQg9e3/J+BCzKRZ03X+ne2AdXGZPKNT7+nDkY7hyrVCJ
         2vBlhZfoWCNFN4q+c6PXqVmUxGqzF7FQaCYoUSQq1eBS86Qo159501zN88LVd0e78AAT
         iNFfABl2GX/XdhuLVaw8u4vfwUPiitmqgvTbeA8EngEWBUnii6RWnyFDq2i/PO2KJEL+
         zskw==
X-Received: by 10.52.170.241 with SMTP id ap17mr20185754vdc.51.1441007333228;
 Mon, 31 Aug 2015 00:48:53 -0700 (PDT)
Received: by 10.31.13.201 with HTTP; Mon, 31 Aug 2015 00:48:53 -0700 (PDT)
In-Reply-To: <vpqzj17hpt8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276852>

On Mon, Aug 31, 2015 at 9:36 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ad/bisect-terms (2015-08-03) 4 commits
>>  - bisect: allow setting any user-specified in 'git bisect start'
>>  - bisect: add 'git bisect terms' to view the current terms
>>  - bisect: add the terms old/new
>>  - bisect: sanity check on terms
>>
>>  The use of 'good/bad' in "git bisect" made it confusing to use when
>>  hunting for a state change that is not a regression (e.g. bugfix).
>>  The command learned 'old/new' and then allows the end user to
>>  say e.g. "bisect start --term-old=fast --term=new=slow" to find a
>>  performance regression.
>>
>>  Michael's idea to make 'good/bad' more intelligent does have
>>  certain attractiveness ($gname/272867), and makes some of the work
>>  on this topic a moot point.
>>
>>  Will hold.
>
> This topic has been there for a while and unless I missed a discussion,
> nothing happened. While I agree that Michael's idea is good and makes
> this series less useful, I think this topic also makes sense.
>
> I'd be in favor of merging it.

My opinion on this is that Michael's idea, even if it is good, is not
compatible with the current way bisect works, so, if it is ever
implemented, it will probably need a special flag like "git start
--possibly-find-fix".

That's why I'd also be in favor of merging this series.
