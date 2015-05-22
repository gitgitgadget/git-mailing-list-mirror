From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3] pull: handle --log=<n>
Date: Fri, 22 May 2015 21:29:55 +0800
Message-ID: <CACRoPnSbAA=6xH+4W8KGPRWe8Pi304zz70Kz8TgY92qKtDYQ8A@mail.gmail.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	<5661061272076a1883cfde1087be4a42@www.dscho.org>
	<20150521103617.GA6159@yoshi.chippynet.com>
	<xmqq1ti9ipy9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 15:30:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvn1a-0006kJ-UJ
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbbEVNaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 09:30:00 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:36185 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422688AbbEVN35 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 09:29:57 -0400
Received: by lagv1 with SMTP id v1so12598501lag.3
        for <git@vger.kernel.org>; Fri, 22 May 2015 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SDKxH9SZEl51sH1OuCVGTVdtJ2tqYSZXnDCrfScODVA=;
        b=w2flnIyBN8g2DTUZok7XFNj5b+Hx58WPpVomix20hlFOpj3jPjx3jKt7pupcKjHlyj
         lXRReZZJp99tUhplztI5v2Bh/qUDytEexhhhLQixR3BduqWJA99pbvoLiEP3DVSFQ5IF
         VjQJhIHgKbpamhPEeWUrfbmeg5H9KXzjCdGaZTjnoei7lw/sxPR0p15xjTfNQp6n2jdJ
         DU1dsk93cD3ucTyjUt17sQEnS4S3fA7OI5qyxw0mErddLRF/zMBaO+PCJSU+mWG9JOa2
         sgIFRKf4nbCCufW9BOfvcCUwISKF8xf4qhzaBcMc1t5k4oZXnQMY/NtRbbPyMt7jPLyU
         ZWIQ==
X-Received: by 10.112.171.101 with SMTP id at5mr6590801lbc.66.1432301395720;
 Fri, 22 May 2015 06:29:55 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 22 May 2015 06:29:55 -0700 (PDT)
In-Reply-To: <xmqq1ti9ipy9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269712>

Hi Junio,

On Fri, May 22, 2015 at 5:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> So, here's the re-rolled patch.
>
> Sigh, too late.
>
> I thought the previous round was good enough and the patch is
> already on 'next'.
>
> If the incremental change is still worth doing on top, please do so.
>
> Thanks.

My bad, I should have checked 'next'.

But it's okay, I re-rolled the patch because it seemed that people
preferred "test_commit". I personally don't have a strong opinion on
this, so if you're fine with it then I'm okay as well.

Thanks,
Paul
