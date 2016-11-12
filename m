Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E872021E
	for <e@80x24.org>; Sat, 12 Nov 2016 13:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965497AbcKLNdf (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 08:33:35 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36166 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965210AbcKLNde (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 08:33:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so3291782wma.3
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xG+ODUIpAPkHuqXn8moAUl9peFwDZQynLoCOjloIXZQ=;
        b=HPMoO+h4oG55yvAQ+oimyyHQfF+zh6JUk4imXF5Bn+/IECVRQI81UDCp08ulLY7oRi
         rRkEn6+BPHc8Ya/v4utuFHhg4WdGQF/t9j8jRdmAExY//uOTcAcraYX1kARfpZXdVP6B
         EoW0f4rrkAuaLBPPbNJg90O8+gi6VFND6XQcLek0P84u15EQhcBmqBmOzkjH3/0NHcoz
         zwPogRFhbRrQYvy5vLvFTR7zlEdZeC+jgCzVEwnRoGlZZpsEQKBg2XzhQx9kOl2JWyVP
         lrioKkrKHWw2O920rkn3TnPCiAFcpXzUOuvBSP/7nURgTyjpshbIQYngYXIGBztQAoWM
         9Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xG+ODUIpAPkHuqXn8moAUl9peFwDZQynLoCOjloIXZQ=;
        b=Xdy6CtiUV6txqiuvRCjkVSTWx27Ewylyf4fLpk2Qguq0KWZBXLmgR+7njgLyxCi2s6
         XanF2Yf4R8vvuPlkOPQNWiVD+vrkSNFue8JugFWENItzT580E9VqcgY4WCc9ZsIzIHGd
         ZQq0l8ZWgNeTTG1yIyQGaDgZN/hNQnVclmDO9LRIgVCVg1gh7UtJgosg5c8RfcbiH5Ay
         9z/Rm8KO4A6AuTO9NZE3+EQYiUMAtMJyayeLibHm6YGp/XG/UP/rO//ILCfMI9/d6DzP
         eZZ4M6QLWFesX4Vdx79/26TE33vAkxLCWiE7o/JRDYgVQBBYya5prYf6tEzt8ArJjsYQ
         XULA==
X-Gm-Message-State: ABUngvfqwoGy2fGu1aRpWV4OFEhxbf4Dz9e91dVOd0gHoHKByTEhEmufeobYIeKEvksrzA==
X-Received: by 10.194.175.5 with SMTP id bw5mr14819012wjc.158.1478957612790;
        Sat, 12 Nov 2016 05:33:32 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5438.dip0.t-ipconnect.de. [93.219.84.56])
        by smtp.gmail.com with ESMTPSA id d85sm24573787wmd.17.2016.11.12.05.33.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Nov 2016 05:33:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <a90fe336-5b62-4278-64e6-e73cb65a02a8@kdbg.org>
Date:   Sat, 12 Nov 2016 14:33:29 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8EBCC92-6570-4120-85A8-A9A9CAC74286@gmail.com>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com> <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611111711210.3746@virtualbox> <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com> <89DB812E-EC29-4D12-97EA-6E8FF6F86FE5@gmail.com> <C3840B91-58E2-4563-9597-5EE514D97CC1@gmail.com> <e0785e35-b43d-37ed-598d-b458daf3c355@kdbg.org> <xmqq1syh3fjx.fsf@gitster.mtv.corp.google.com> <xmqqr36h209y.fsf@gitster.mtv.corp.google.com> <a90fe336-5b62-4278-64e6-e73cb65a02a8@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Nov 2016, at 22:22, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Am 11.11.2016 um 22:07 schrieb Junio C Hamano:
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>>> OK, then let's have
>>>=20
>>> 	filter_git () {
>>> 		rm -f rot13-filter.log &&
>>> 		git "$@"
>>>                ...
>>>=20
>>> and call that -rc1.
>>=20
>> That is, to queue this on top of ls/filter-process and merge it
>> down.
>>=20
>> -- >8 --
>> Subject: t0021: remove debugging cruft
>>=20
>> The redirection of the standard error stream to a temporary file is
>> a leftover cruft during debugging.  Remove it.
>>=20
>> Besides, it is reported by folks on the Windows that the test is
>> flaky with this redirection; somebody gets confused and this
>> merely-redirected-to file gets marked as delete-pending by git.exe
>> and makes it finish with a non-zero exit status when "git checkout"
>> finishes.  Windows folks may want to figure that one out, but for
>> the purpose of this test, it shouldn't become a show-stopper.
>>=20
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> Nicely summarized! Thank you very much!
>=20
> I've double-checked again that the redirection is really not used by =
the tests. The name does occur in a .gitignore, but I guess that is not =
important for the background filter process. It would be good if Lars =
could confirm this.

Yesterday, I wasn't sure if silencing stderr was required by the test.
Junio's assessment and solution is spot on.

Thanks a lot,
Lars


>=20
>> ---
>> t/t0021-conversion.sh | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>=20
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index cb72fa49de..5ce2535017 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -27,8 +27,7 @@ file_size () {
>>=20
>> filter_git () {
>> 	rm -f rot13-filter.log &&
>> -	git "$@" 2>git-stderr.log &&
>> -	rm -f git-stderr.log
>> +	git "$@"
>> }
>>=20
>> # Compare two files and ensure that `clean` and `smudge` respectively =
are
>>=20
>=20

