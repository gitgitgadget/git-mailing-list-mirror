Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB5B20D0A
	for <e@80x24.org>; Sat, 15 Apr 2017 11:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbdDOLQ7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 07:16:59 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35346 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbdDOLQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 07:16:58 -0400
Received: by mail-wr0-f176.google.com with SMTP id o21so61553374wrb.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madiva-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id
         :references:to:date;
        bh=9BV4tMLdvQRQa3RXdnU691/hVxXYp9kX7js01XVhVTc=;
        b=TPKQGGa1pjvQhRFS9cJu6SOYOJ8JQvKEYpshNO6YW5mhRNnWF3Tm5Yx7aZzMGkX0bm
         BRLfY62jKHZTWFAZIc3Q2a/QYwE1pwhi8Nc03el3WAOeUTnNBA4juA6ElOryw8klp87N
         1hBvooJR3QnB1BXfs8iCXx5ztUTEQEfuaKVWyPACoFjMssKlAonS74G1+/s4EIkCrpU2
         JRTCPiUt5MYty76TgMzWNRaEjp2Wwrjji4d+P3Vbx3l3Ul1xT+O2SWGuGSK4gpy5cogp
         6mpYJw/NygM9fJM7OVaYxqPG9Us9mmUph6dOAdS6h2LMi8sKVFtCtL3F/7BpEN/3B94+
         W8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:references:to:date;
        bh=9BV4tMLdvQRQa3RXdnU691/hVxXYp9kX7js01XVhVTc=;
        b=kTdcp6Puhq5heUJ2nbJXla7Uhvm0XXska0ANtWp29RTaIPcsA1Ch8woICGZFcuskFa
         J3SQikZJB9KYueLg2crspfRaEFKb3CAhLGmG1oXnrEvcisbWbHTUp/fxzSFtByKPBUI6
         nzJPrkmBP4f/+a3HvlTHNdgmyFHJyCEehTTEe1SVBKH33ySANRsqhuDed8Kjit1+SwYM
         moYWauJErZVFftrKP2CfYkDwnt3giC7B5bm0uxRqOHOknCzwIQ5phBNlLcBVmsHPHk7c
         jH3gyxIgoIRo2oknnZqkl5sB4zdrjDkRlnO8FldgUwmtcCXMXrDewdzznU278YzwlWlQ
         ZNUA==
X-Gm-Message-State: AN3rC/5LB0R04GHdDucDQKkO2r1aB2cmiZXuPLgGnx4xZMtZ2Wonq1VO
        +LnAPg0kdJt1tc96Txk=
X-Received: by 10.223.170.197 with SMTP id i5mr10285881wrc.159.1492255016343;
        Sat, 15 Apr 2017 04:16:56 -0700 (PDT)
Received: from [192.168.1.34] (3.red-83-53-9.dynamicip.rima-tde.net. [83.53.9.3])
        by smtp.gmail.com with ESMTPSA id 24sm5999304wrw.46.2017.04.15.04.16.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Apr 2017 04:16:55 -0700 (PDT)
From:   =?utf-8?Q?Ux=C3=ADo_Prego?= <uprego@madiva.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Fwd: Errors running gitk on OS X
Message-Id: <F677C638-3307-4106-BE32-FF7219F03526@madiva.com>
References: <CAFzZ5jq5KS9DydO+zCdQ=BHCLOZYHXjp_yDW1S=UVb_u3CfTwA@mail.gmail.com>
To:     git@vger.kernel.org
Date:   Sat, 15 Apr 2017 13:16:53 +0200
X-Mailer: Apple Mail (2.3251)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a similar one

bash-4.4$ gitk
2017-04-15 13:09:52.514 Wish[3344:197352] *** Terminating app due to =
uncaught exception 'CALayerInvalidGeometry', reason: 'CALayer position =
contains NaN: [nan 0]'
*** First throw call stack:
(
        0   CoreFoundation                      0x00007fffd119048b =
__exceptionPreprocess + 171
        1   libobjc.A.dylib                     0x00007fffe58f2cad =
objc_exception_throw + 48
        2   CoreFoundation                      0x00007fffd120e96d =
+[NSException raise:format:] + 205
        3   QuartzCore                          0x00007fffd6d35520 =
_ZN2CA5Layer12set_positionERKNS_4Vec2IdEEb + 152
        4   QuartzCore                          0x00007fffd6d35695 =
-[CALayer setPosition:] + 44
        5   QuartzCore                          0x00007fffd6d35ceb =
-[CALayer setFrame:] + 644
        6   CoreUI                              0x00007fffdcafd4ce =
_ZN20CUICoreThemeRenderer26MakeOrUpdateScrollBarLayerEPK13CUIDescriptoraPP=
7CALayer + 1284
        7   CoreUI                              0x00007fffdcaf94c3 =
_ZN20CUICoreThemeRenderer19CreateOrUpdateLayerEPK13CUIDescriptorPP7CALayer=
 + 1595
        8   CoreUI                              0x00007fffdca7a58d =
_ZN11CUIRenderer19CreateOrUpdateLayerEPK14__CFDictionaryPP7CALayer + 175
        9   CoreUI                              0x00007fffdca7d241 =
CUICreateOrUpdateLayer + 221
        10  AppKit                              0x00007fffcf7bc21f =
-[NSCompositeAppearance _callCoreUIWithBlock:options:] + 226
        11  AppKit                              0x00007fffcee620b3 =
-[NSAppearance _createOrUpdateLayer:options:] + 76
        12  AppKit                              0x00007fffcf0da71f =
-[NSScrollerImp _animateToRolloverState] + 274
        13  AppKit                              0x00007fffcf09a0f9 =
__49-[NSScrollerImp _installDelayedRolloverAnimation]_block_invoke + 673
        14  AppKit                              0x00007fffcef602c5 =
-[NSScrollerImp _doWork:] + 15
        15  Foundation                          0x00007fffd2b6ec88 =
__NSFireDelayedPerform + 417
        16  CoreFoundation                      0x00007fffd110fd74 =
__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 20
        17  CoreFoundation                      0x00007fffd110f9ff =
__CFRunLoopDoTimer + 1071
        18  CoreFoundation                      0x00007fffd110f55a =
__CFRunLoopDoTimers + 298
        19  CoreFoundation                      0x00007fffd1106f81 =
__CFRunLoopRun + 2065
        20  CoreFoundation                      0x00007fffd1106514 =
CFRunLoopRunSpecific + 420
        21  Tcl                                 0x0000000106fe5b43 =
Tcl_WaitForEvent + 314
        22  Tcl                                 0x0000000106fb55cd =
Tcl_DoOneEvent + 274
        23  Tk                                  0x0000000106e1ef4f =
Tk_MainLoop + 33
        24  Tk                                  0x0000000106e2aa5b =
Tk_MainEx + 1566
        25  Wish                                0x0000000106dfe55a Wish =
+ 9562
        26  libdyld.dylib                       0x00007fffe61d1255 start =
+ 1
)
libc++abi.dylib: terminating with uncaught exception of type NSException
/usr/bin/wish: line 2:  3344 Abort trap: 6           "$(dirname =
$0)/../../System/Library/Frameworks/Tk.framework/Versions/8.5/Resources/Wi=
sh.app/Contents/MacOS/Wish" "$@"
bash-4.4$

I think it is new - I do not really care as long as is working mint on =
Linux.
Please pardon the 80th column limit exceed.

> Begin forwarded message:
>=20
> From: Evan Aad <oddeveneven2@gmail.com>
> Subject: Errors running gitk on OS X
> Date: 13 April 2017 at 19:03:45 GMT+2
> To: git@vger.kernel.org
>=20
> Running gitk from the command line, while at the top level of a Git
> working directory, produces the following error message, and gitk
> fails to open:
>=20
>> objc[1031]: Objective-C garbage collection is no longer supported.
>=20
>> /usr/local/bin/wish: line 2:  1031 Abort trap: 6           "$(dirname =
$0)/../../../Library/Frameworks/Tk.framework/Versions/8.5/Resources/Wish.a=
pp/Contents/MacOS/Wish" "$@"
>=20
> Additionally, the following error message pops up in a window:
>=20
>> Wish quit unexpectedly.
>=20
>> Click Reopen to open the application again. Click Report to see more =
detailed information and send a report to Apple.
>=20
>> Ignore | Report... | Reopen
>=20
> How can this be fixed?
>=20
> ***
>=20
> OS: macOS Sierra, Version 10.12.4
> Git version: 2.11.0 (Apple Git-81)

