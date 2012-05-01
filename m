From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 1 May 2012 15:21:04 -0700
Message-ID: <CAE1pOi02_u9j2oHy-RJ-XbrCmDiUWd4-=50f-v+iaK1GLaLQZw@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<86r4v3mxf7.fsf@red.stonehenge.com>
	<7vaa1r8vhy.fsf@alter.siamese.dyndns.org>
	<CAE1pOi00Mr4dOj2ChTJU9XWypUAaVUDDa36-M7LA+9BixW0nKw@mail.gmail.com>
	<CAJsNXT=niP2Ja-pSbvj-OGi5t0x0-Zxm3CdcY0nLs9ROdCG8hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Git Users <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Wed May 02 00:21:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPLRZ-0004Lt-2s
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 00:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004Ab2EAWVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 18:21:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35723 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab2EAWVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 18:21:05 -0400
Received: by yhmm54 with SMTP id m54so14127yhm.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xc4q/QZwJuoRMTIGUYOAHnLediNsGLnRbHP8a10oV0s=;
        b=V4ae0mxKfaFFa9U4FcbqGtBfkIVX0j+E03XxVyXeFhg22mRiv4T8ic1R0hkD9BhDaG
         l51eILmCaFL0XvYS5sulEdUnPF1yobnmb0fka1VSFagaWBEj7cS2SQBJEw8CRdd+7nVj
         gc6xVUreyiDhIMBumPqGut0NaQ52D+b5TEhuz533Ej7KvkA4yGDhpsvouaToi/P1anQ8
         olv3Xs+R5Y+fuiNhioviql74RTk6TI82uZihXLJqpnEU+y9rHlvYjuiIKgx8ih3ZE4SC
         nZCniSWz1I1c9Ik884gcb091BISrZdHl4xlm3EYbdoT7NrK5ky6rmk3joHkmw2B7O6Fe
         pn4w==
Received: by 10.236.76.41 with SMTP id a29mr28008456yhe.117.1335910864983;
 Tue, 01 May 2012 15:21:04 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 1 May 2012 15:21:04 -0700 (PDT)
In-Reply-To: <CAJsNXT=niP2Ja-pSbvj-OGi5t0x0-Zxm3CdcY0nLs9ROdCG8hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196765>

On 1 May 2012 14:59, PJ Weisberg <pj@irregularexpressions.net> wrote:
> On Tue, May 1, 2012 at 2:09 PM, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>
>> On 1 May 2012 14:03, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> We've talked about something like that a few times in the past, but as far
>>> as I (am concerned / remember) the conclusion has always been that is not
>>> worth "standardizing", i.e. nothing a ./setup script in-tree or a Makefile
>>> target cannot offer the same convenience.
>>
>> This would not keep things up-to-date, though, would it? It seems like
>> yet another thing developers need to remember and do. I would prefer
>> something more automatic.
>
> Once your hooks are installed, couldn't your post-checkout and
> post-merge hooks keep all the others up to date?

Excellent point. Yes, that would certainly work.
