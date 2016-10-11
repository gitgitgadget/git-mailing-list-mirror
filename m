Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68DCD1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 15:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbcJKPmI (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 11:42:08 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34443 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbcJKPmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 11:42:07 -0400
Received: by mail-oi0-f46.google.com with SMTP id t73so28176735oie.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lTsJbIBksegImIxMv5fHC+3vxT7OZclc0coXn0KFixs=;
        b=GehHehP9lIQW3ld8mFVTD1LCxeFdfNzHvbcvLfZBQZzDzg4k+E0Lbp16LpBEUP9rvp
         V09r7VkFCbNO7EEDjrhlcrbPIjUEqPMEqY+aoD8HggDbb91EU9gz33G3QO1GlbI+aiMh
         nsX8+nJ7eoDjNajlb30VLsvAD4ACcKda5AM92DWVFIlBNgPCXKASulAuvZPGUbwqoqne
         gddsTiH8es/Oe1tJd59z7B0QUeC0pKLpeonQHIZ+mYUZIx1ijWcJA6YFfpmbL3DIfwFm
         DIiI1YN3Qmg3iaBr763J/9BrXTGnMDaya8iOo17bcX0d0pg+qyrKXzGk9hsL04RDthu+
         Yiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lTsJbIBksegImIxMv5fHC+3vxT7OZclc0coXn0KFixs=;
        b=lSmfcm06qgbrK6/uHKDaaEH4WI4cZAScKKpRipvDdJQujAM4KMhCVwLCh6mpjRZbZS
         QGMGKIlwnUMKiO+jyEVM0CH78uChVUO/us+PTAgy7+H5Z0uM0NqdACy1JG36iscXyyMr
         NGH7IydDW82Q4euSRKiK/46HDCZNjl8rZKuda2DhOKBM0T4bfX906IYaP8nBXpg9j27r
         DP7bcrpEYIz6M0kpo4yTzP+eZGspoZygi3y9DzdGDBOyWHw8M5/GOpn39oqzqMWpHFwC
         lyVZviCe9nHp4cToPgAsjWQ8gC9Q9C3WOCcxVNTxXLUcIkBwkRlLhEXbK8NzRhL0/2Qv
         O3AQ==
X-Gm-Message-State: AA6/9RlXoRSkUjdXlQlpFEJ15WJ+dsWN3ikVq4oUbyNwwJ+4JQduhyp0mmEV4DD/dwbjwA==
X-Received: by 10.202.171.202 with SMTP id u193mr2298723oie.7.1476200526296;
        Tue, 11 Oct 2016 08:42:06 -0700 (PDT)
Received: from larrylap.suse (cpe-24-31-249-175.kc.res.rr.com. [24.31.249.175])
        by smtp.gmail.com with ESMTPSA id 77sm1314983otf.18.2016.10.11.08.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 08:42:05 -0700 (PDT)
Subject: Re: Formatting problem send_mail in version 2.10.0
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
 <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
 <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
 <vpqfuo3l4fl.fsf@anie.imag.fr>
Cc:     Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Jorge Juan Garcia Garcia 
        <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
Date:   Tue, 11 Oct 2016 10:42:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <vpqfuo3l4fl.fsf@anie.imag.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2016 02:39 AM, Matthieu Moy wrote:
> Jeff King <peff@peff.net> writes:
>
>> [+cc authors of b1c8a11, which regressed this case; I'll quote liberally
>>      to give context]
>>
>> On Mon, Oct 10, 2016 at 05:48:56PM -0400, Jeff King wrote:
>>
>>> I can't reproduce the problem with this simple setup:
>>>
>>> 	git init
>>> 	echo content >file && git add file
>>> 	git commit -F- <<-\EOF
>>> 	the subject
>>>
>>> 	the body
>>>
>>> 	Cc: Stable <stable@vger.kernel.org> [4.8+]
>
> Is this RFC2822 compliant (https://tools.ietf.org/html/rfc2822)? Not an
> expert of the norm, but my understanding is that you're allowed to use
> either "Name <addr@domain.com>" (name-addr) or addr@domain.com
> (addr-spec), and that comments are allowed within parenthesis like
> "Stable <stable@vger.kernel.org> (4.8+)".
>
> What is this [4.8+] supposed to mean?
>
> The guilty function is parse_mailboxes in perl/Git.pm. It should be
> rather easy to modify it but I need to understand the spec before I can
> try to implement anything.

That added information at the end is intended to be passed on to the stable 
group. In this case, the patch needs to be applied to kernel versions 4.8 and later.

Placing the info inside parentheses causes it to be dropped from the outgoing 
mail as follows:

(body) Adding cc: Stable <stable@vger.kernel.org> (4.8+) from line 'Cc: Stable 
<stable@vger.kernel.org> (4.8+)'
--snip--
Cc:     Stable <stable@vger.kernel.org>,

Larry



