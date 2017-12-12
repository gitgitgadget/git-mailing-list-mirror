Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0AF1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 23:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbdLLXzJ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 12 Dec 2017 18:55:09 -0500
Received: from elephants.elehost.com ([216.66.27.132]:24840 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbdLLXzH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 18:55:07 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBCNt5S6025963
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Dec 2017 18:55:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com>        <xmqqindc4zhp.fsf@gitster.mtv.corp.google.com>        <006301d372df$e82cf410$b886dc30$@nexbridge.com>        <xmqqtvwvy1rh.fsf@gitster.mtv.corp.google.com>        <004b01d373a0$3ec759d0$bc560d70$@nexbridge.com> <xmqqpo7jy0pe.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqpo7jy0pe.fsf@gitster.mtv.corp.google.com>
Subject: RE: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
Date:   Tue, 12 Dec 2017 18:54:59 -0500
Message-ID: <004d01d373a4$a1978950$e4c69bf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKyKGo4qh2sJ7CV4r7D/ydkuQ0kwQIINdwwAgXasQgB63y8ywI0TmDbAsaczFShK1MYgA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 12, 2017 6:40 PM Junio C Hamano wrote to my own embarrassment:
"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> Yes, needed. The lines wrapped om Documentation/Makefile - each change 
>> in quick-install-man/html should be exactly one line:
>>
>> quick-install-man: require-manrepo
>> -	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandir)
>> +	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) 
>> +$(DESTDIR)$(mandir) $(GIT_MAN_REF)
>>  
>> And here
>>
>>  quick-install-html: require-htmlrepo
>> -	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(htmldir)
>> +	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) 
>> +$(DESTDIR)$(htmldir) $(GIT_MAN_REF)>

>To everybody else who did not complain that what I sent was line-wrapped, the message should be showing like this:
>    https://public-inbox.org/git/xmqqtvwvy1rh.fsf@gitster.mtv.corp.google.com/
It is correct at the above link. My mailer is Outlook 2016... so... yeah.

>Perhaps the mail program on your receiving end is mangling what you got from the mailing list, giving you a line-wrapped version.
Yes it is. It loves mangling. Nice to see it mangled it again ☹. Porting sendmail was on my list of things to do, but pretty far down.

>It also unfortunately makes me suspect that you didn't actually have a chance to apply the patch mechanically and make sure it works for you due to mail mangling at your end X-<.
I have no such capability on the system where the changes were made, nor even with Outlook on my own local Windows dev box. I've tried my mac and linux machines but can't connect up to my (bleep) mailer from those without creating more (bleep). It's either that or I'm too close to the holidays.

>> And otherwise please consider it signed off.
>Will do, thanks.

😊

