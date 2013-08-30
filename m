From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Fri, 30 Aug 2013 15:42:31 -0500
Message-ID: <CAMP44s12m5EMe+SWb4YB1kXfPX1qOOxP5244KCU_Sm3CKaqYAg@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAMP44s3=gRwORdxYiXnioufg8Ag3tmuZth5_-+NbJWV_v1FDxA@mail.gmail.com>
	<CAMP44s0yxaS3YeF5gprTecfa0rzLso96cE9gWM629iM0Sc5+Bg@mail.gmail.com>
	<CAMP44s2cba_UGmYJuwf9kw-OG4FQz6eRefRC0xa7pnx6ctFRjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Pete Harlan <pgit@pcharlan.com>, Aghiles <aghilesk@gmail.com>,
	Jeff King <peff@peff.net>, Phil Hord <hordp@cisco.com>,
	David <bouncingcats@gmail.com>,
	Alexei Sholik <alcosholik@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	Sebastien Douche <sdouche@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 22:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFVWl-0006gX-QW
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 22:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869Ab3H3Ume (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 16:42:34 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:51114 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab3H3Umc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 16:42:32 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so2240756lbi.39
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XzxZzua1kZv1/9ovP/uow7muYUzjHxxNBNPEHElKq6k=;
        b=w3zKTyr8LOz8ecrUJl155eW/O2R7lE29+GGat757eC1k/mmLXbNIe6xCgncqf1FxoG
         4twMkkpWpx1Rv4EEV1m7RJNDZycbifloxi1ncj7hJmdp2oxhyFugQJqEhVIqh4Ng3wyE
         FY7G1JyHLejA1+42cZ6AIFe2ayMCeKYrWRnyj0XBlMJdCtdP13R9fcgxV5OqGk/HuhWZ
         KCUklq6i0t+CCqnkyVDzTy7yE/9XA0jY/39gdUeEgZd+cdfxR557u+FUR0zHlc7zgdbP
         M/8PvDf5RnUIYOANlq9jSvcvCGDvLssq0F5JbA91i1jy0AnHRcA2fpuj5RF8oLtctFcD
         XefA==
X-Received: by 10.112.35.225 with SMTP id l1mr3236009lbj.35.1377895351083;
 Fri, 30 Aug 2013 13:42:31 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 30 Aug 2013 13:42:31 -0700 (PDT)
In-Reply-To: <CAMP44s2cba_UGmYJuwf9kw-OG4FQz6eRefRC0xa7pnx6ctFRjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233470>

On Fri, Aug 30, 2013 at 3:40 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Aug 30, 2013 at 2:11 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Thu, Aug 29, 2013 at 2:57 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>
>>> Here are the threads once again:
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/197111
>>> http://thread.gmane.org/gmane.comp.version-control.git/166675
>>> http://thread.gmane.org/gmane.comp.version-control.git/115666
>>
>> I take it you still haven't read those threads, and you don't plan to.
>> So I have to go through each and every comment and summarize what each
>> person concluded.
>>
>> Hopefully you would come back to me before I waste my time, but it
>> seems there's no other way to make you see the reality of what was
>> actually already discussed and agreed.
>
> So here's the summary, as I said, *everybody* is in favor of "staging
> area" or something other than "index", with the exception of Drew
> Northup, I've put a summary of the conclusion of each person that
> voiced an opinion on the matter, and I've CC'ed them here, so they can
> reiterate their opinion, or clarify it.
>
> Junio, do you accept that virtually *everyone* is in favor of "staging
> area" now?

To avoid bonces, please remove  victor.engmark@terreactive.ch and
alexeyf@opera.com from the CC list.

-- 
Felipe Contreras
