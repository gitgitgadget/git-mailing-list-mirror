From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] i18n: mark relative dates for translation
Date: Wed, 25 Apr 2012 09:27:24 -0700
Message-ID: <xmqqzk9zdbf7.fsf@junio.mtv.corp.google.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
	<1335184230-8870-4-git-send-email-pclouds@gmail.com>
	<xmqqd36wgam5.fsf@junio.mtv.corp.google.com>
	<CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com>
	<20120425152558.GC31026@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 18:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN542-0003xi-G5
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 18:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab2DYQ13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 12:27:29 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:41853 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab2DYQ12 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 12:27:28 -0400
Received: by wibhj13 with SMTP id hj13so15624wib.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 09:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=bCrooUYn4ZZpmE/lnlAK+yv2N4Q/OGwJYuuDXTzneus=;
        b=Lf5dUoeQNMcZnMzfuFAAnFt+jEnrKKMvfqy82Q0+iuS6sWk31RRII/mmZsof88W0UK
         o07uJoLi0RQ0CE7kZZFBUeFyCynesmrTvFbL3buaOXhYI/UK+3OE9PInppJfpi02UZQE
         3C/2Mr+IbhVmObIfZmCzCKjcVn3dxCyfpsw78pilMEfZbgwUb1f4NL9CeUbs5GABtmei
         BvjVb7bBQ+1m6v3+rejUuW3GbOvJPI0eqItO3pUPqJUfYT65FLxfqR9S7pnPDZtUejee
         LaSt3N+kahGAPoi6xIKNMZUB7oJKA2wJMbTaTuw7RJp7Xp/GQDnaqoetjLMokqATWP5X
         htyQ==
Received: by 10.213.2.70 with SMTP id 6mr366304ebi.18.1335371246743;
        Wed, 25 Apr 2012 09:27:26 -0700 (PDT)
Received: by 10.213.2.70 with SMTP id 6mr366286ebi.18.1335371246561;
        Wed, 25 Apr 2012 09:27:26 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si145614een.0.2012.04.25.09.27.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 09:27:26 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 2DFAE5C0050;
	Wed, 25 Apr 2012 09:27:26 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id D2D4AE125C; Wed, 25 Apr 2012 09:27:24 -0700 (PDT)
In-Reply-To: <20120425152558.GC31026@burratino> (Jonathan Nieder's message of
	"Wed, 25 Apr 2012 10:25:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmHBArRFj60gQtVnANRv7G6BHMTMhn49IXHsAeOPgXpa9NBh8GiyYzC9ZVYt622M0Go2AtwD/3LcCyE7qPCuN1tpNyXRxi5YyaCH8h2p9XBnbmomc1GOc4hRbLmTox0t1kLcMXLV8qLTSXZb59UnbDZKhnSZpqb/aISxS16EJXGeAyvSEE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196321>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguyen Thai Ngoc Duy wrote:
>> 2012/4/25 Junio C Hamano <gitster@pobox.com>:
>
>>>> +     strbuf_addf(timebuf,
>>>> +              Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
>>>> +              (diff + 183) / 365);
>>>>  }
>>>
>>> This is just a tangent, but could we possibly come here and say "1 year
>>> ago"?
>>
>> Nice catch. Singular form here is unnecessary.
>
> I think Junio meant
>
> 			Q_("1 year ago", "%lu years ago", ...)

No, I was just being stupid---what I meant was that diff will be so
large that this will always be feeding more than 1 to %lu, so the first
template string will never be used.

But it cannot be N_("%lu years ago", number), as others correctly
pointed out.  We want to use ngettext() here, because it is not enough
to know that number is always greater than 1 to correctly phrase this in
some languages.
