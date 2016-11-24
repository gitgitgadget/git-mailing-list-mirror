Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA5C1FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 16:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757226AbcKXQKw (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 11:10:52 -0500
Received: from mail-wj0-f181.google.com ([209.85.210.181]:36570 "EHLO
        mail-wj0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757195AbcKXQKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 11:10:50 -0500
X-Greylist: delayed 991 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Nov 2016 11:10:49 EST
Received: by mail-wj0-f181.google.com with SMTP id qp4so36965885wjc.3
        for <git@vger.kernel.org>; Thu, 24 Nov 2016 08:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=22fD7aCQMR2kJ3KRCmQHNYrRLN0NL50yCN9d+ghr9go=;
        b=uj2fE80XupKqn+80vI8bjt0TXKftiFPUr8iDyG/rivqhYhwdkAUPbapo2efbAv30zm
         xTantdi/1wDhVEyGbgNR3rQWus/8Gve8JVfxzDmEPJ/ylxKECAkdw2RPsdEXeQCrXzLD
         FGtwGKbKlQiKThkhYgSAyRNBkUTB4ZlQbwnkKm9CNDwqJaUuOHjhs9gqvE9FH01OKNNI
         nUv1lZyh4CdV8zDbjfVJ3PQqGWBeFX4/gXllAm0nvZ55Rat5imY5LOWC0IkHXVnDlybj
         WLH0NLfPnEiQuplfkhu8nxDjBdVFlHPX4vzXYjgsiXkYVyGOKQ+LwS5xXa/yo+aS61hP
         Xuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=22fD7aCQMR2kJ3KRCmQHNYrRLN0NL50yCN9d+ghr9go=;
        b=DfFQ6boIFAdOSBUJ5zIAvo9kAdkgIPQg7RuRt/jS0Y/SJOaQ3QdeHY1h54FH2u5XxK
         PruQRZ6cmgGx3Lm/NMchalbC9wZe2LSihomjo0K0MAu2L4nKIhldoLoEu61f+FY0q9y4
         KJqvev+Hg5v9CaR0vZn1MnN2P14ngkfooRczCBy0KlX4jVHhJhKXyA4Uj3SwQgvip08Q
         yk/I9c9jIr/sMlKA10PK6YS0KrbM9GDe1eulV0gE9xFH+Xbn7M/l15IzjF+s3P0xrS4H
         l6F2tkMpmnRxInnV0j6aJa1pKRFjdmNtvRmuIVRraV3/89jka1esOW4AqZazZkKNa1eE
         dpYw==
X-Gm-Message-State: AKaTC01+LnU7HKTdayBQbccmmAp7m3+T/A1uX20G5oKFMI5qswkMqRSfZUJ9yu8qIJCrww==
X-Received: by 10.194.190.229 with SMTP id gt5mr2843926wjc.212.1480002349001;
        Thu, 24 Nov 2016 07:45:49 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l74sm8846743wmg.2.2016.11.24.07.45.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Nov 2016 07:45:48 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 24 Nov 2016 16:45:45 +0100
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <249EE7A4-F297-4537-92A9-0EF75A3B1AEE@gmail.com>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com> <20161115010356.GA29602@starla> <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com> <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Nov 2016, at 19:03, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> The filter itself would need to be aware of parallelism
>>> if it lives for multiple objects, right?
>>=20
>> Correct. This way Git doesn't need to deal with threading...
>=20
> I think you need to be careful about three things (at least; there
> may be more):
>=20
> ...
>=20
> * Done naively, it will lead to unmaintainable code, like this:
>=20
>  ...

Hi Junio,

I started to work on the "delayed responses to Git clean/smudge filter
requests" implementation and I am looking for a recommendation regarding=20=

code maintainability:

Deep down in convert.c:636 `apply_multi_file_filter()` [1] the filter =
learns
from the external process that the filter response is not yet available.
I need to transport this information quite a few levels up the call
stack.=20


# Option 1
I could do this by explicitly passing a pointer such as "int =
*is_delayed"=20
to the function. This would mean I need to update the function =
definitions=20
for all functions on my way through the stack:

int apply_multi_file_filter()
int apply_filter()
int convert_to_working_tree_internal()
int convert_to_working_tree()
...

# Option 2
All these functions pass-through an "int" return value that communicates
if the filter succeeded or failed. I could define a special return value
to communicate the third state: delayed.=20


What way do you think is better from a maintenance point of view?
I prefer option 2 but I fear that these "special" values could confuse
future readers of the code.

Thanks,
Lars


[1] =
https://github.com/git/git/blob/e2b2d6a172b76d44cb7b1ddb12ea5bfac9613a44/c=
onvert.c#L673-L777

