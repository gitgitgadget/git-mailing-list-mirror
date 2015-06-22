From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/19] ref-filter: add parse_opt_merge_filter()
Date: Mon, 22 Jun 2015 09:15:18 -0700
Message-ID: <xmqqmvzriusp.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
	<1434919705-4884-1-git-send-email-karthik.188@gmail.com>
	<1434919705-4884-5-git-send-email-karthik.188@gmail.com>
	<CAPc5daUkHb5sQ_d-g0EeFwXTkFUf4=PVV=QcV-nekObKSJL27g@mail.gmail.com>
	<vpq381kc7y6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 22 18:15:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z74Na-0007jl-L6
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 18:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbbFVQPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 12:15:23 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38285 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbFVQPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 12:15:21 -0400
Received: by igin14 with SMTP id n14so19745265igi.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tNGZAoYBoDKGAhYXkHdmvCfvEry8zTjz+tiCFBXFSAI=;
        b=bNjlP2rcUn5TMjFmmZ1P+qlF0nD0nrcXQLU4IQ5hocRmYF6QZuJva3Sc3pMICWNJ13
         TDUy1L44gyZnaJf2i6Q5sdvwR+K3mSltxsENLe0sfTtKfliWV04fJ0OdFNgV44AXzME8
         8nakUH1cH4z+uccCDyvEVV84Pobck/wYGfhjw8/bTrgPWqttJnek/j/Bore5YGEkeUwr
         /a/aY3xSScthZWml5HC8chOcAwr5cyWmtY0ft3uxiQCyX41D4ZStALKmfjLfdVuM9PlL
         /imB8IHc5d1Re/OwaCraJ9fWEtBh71F1c8Z4K6nFq66p3aq3Gfo1gfxBFP9DvlHdse19
         D2hg==
X-Received: by 10.107.155.74 with SMTP id d71mr39622339ioe.29.1434989720679;
        Mon, 22 Jun 2015 09:15:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id k74sm13060776iok.30.2015.06.22.09.15.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 09:15:19 -0700 (PDT)
In-Reply-To: <vpq381kc7y6.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	22 Jun 2015 13:13:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272395>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> This is copied from 'builtin/branch.c' which will eventually be removed
>>> when we port 'branch.c' to use ref-filter APIs.
>>
>> Hmph. I somehow thought Matthieu's instruction was to finish tag.c
>> side first
>
> I would call in "advice" rather than "instruction". 

Hmph, the choice of the word came from my understanding that a
"mentor" is like a "teacher", but "advice" is fine by me ;-)

> I still think we
> should prioritize the tag.c side, but if this patch is ready, it makes
> sense to keep it in the series.

OK.
