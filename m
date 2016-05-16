From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 10:48:40 -0700
Message-ID: <CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	<xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MdZ-0005RB-3o
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbcEPRsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:48:42 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34269 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbcEPRsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:48:42 -0400
Received: by mail-io0-f181.google.com with SMTP id 190so219237533iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=CVA/nZXCUbyoG834JT5LeYVY2xuBiKdE3LxOCu4oNDk=;
        b=fU+5m2DrYS/tZbAksHplPyIfVH9ZJSJuPoSqB8GJCgiGdCVFNwehBe8fD2tRqAW0eL
         dtHWiabIXYIyMrHZiQ6IAQCNuE9wAMBiFfFH/r0qOwC/TaxzCk6lserVuQn7Td07tIMi
         YPtIuPee9sJ3W8b8TgdAun9nrw80P6HoZz164IsN+r97apnr4CMilLkl+M/kgbBjvCDD
         i+LLLZJxr3E64X41tv9km6FuaHpztwcfG1sYlAkviOqcNip0Ngx45h1P2mNCWEnZf1LZ
         71UJbfZf0Cnh5811hC7FG3HCwo9ovP49HZWTvF8qk38sEDY5tKl+v1bAkl6Woaaqu9AX
         OzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CVA/nZXCUbyoG834JT5LeYVY2xuBiKdE3LxOCu4oNDk=;
        b=Rx746tF0TYZ9sIy/PFW0C11bD1iOtTTG0EQKtNh+GjyPlnRh37x0vpaGw0ceMsmc2A
         mEt9IHX1hn4+J41LP51ZHlDnpEByHTgx7NapA09HPAZK39GdTz9ieBNnCYHU+d2L4SNx
         ks0nqdiiL5EPaxdgkP6B9MOoBl+RiOsEdeZXlINlykYr8fCslG8JTQVps59sEyd/gulN
         VZoc0BplDcHa6Dqo1w7BYhuhu6j7c472v7CzKG1S7U4vz7H0m+PsZqe4MJYCU7utjSY6
         U3MvBVFHtiMe95eWlmBT2f65YOMKSRqjCiPlBtVTx3KaOhnivjS9JtxeX1RdF0McVHrS
         MIzA==
X-Gm-Message-State: AOPr4FWLxtNKu4NksZhHvbg8LnlP9dDWx04cBwGR/8y9UROPSVXAchbSXYjQIZAyCwgN23N0EOT0mHKAyhBBpYvD
X-Received: by 10.107.173.3 with SMTP id w3mr8249153ioe.110.1463420920994;
 Mon, 16 May 2016 10:48:40 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 10:48:40 -0700 (PDT)
In-Reply-To: <xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294763>

On Mon, May 16, 2016 at 10:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Sun, May 15, 2016 at 3:06 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> Instead of putting everything in under the same attribute name
>>> "label", make one attribute per label? Would this work?
>>>
>>> *.[ch] c-group code-group
>>>
>>> And the pathspec magic name can be simply "attr", any git attribute
>>> can be used with it, e.g. :(attr:c-group)
>>
>> So you want to be able to query something like:
>>
>>     git ls-files ":(crlf=auto)"
>>
>> as well?
>
> It would be more like
>
>         git ls-files ":(attr:crlf=auto)"
>
> It certainly sounds tempting, even though I do not want to keep what
> this initial chunk of the series needs to do to the minimum.

This is another case for using ':' instead of '='.
So I think ':' is better for this future enhancement.

Also this future enhancement may ask for

      git ls-files ":(attr:label=foo)"

or

      git ls-files ":(attr:-label)"

so the user can circumvent the warn and ignore strategy. :(
