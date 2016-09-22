Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475841F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034590AbcIVSpH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:45:07 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35740 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034576AbcIVSo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:44:57 -0400
Received: by mail-wm0-f49.google.com with SMTP id l132so344457484wmf.0
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:mime-version:subject:message-id
         :references:to:date;
        bh=VDbQ7ZWGWdKo250qIUj1jUlVrB3j+PyofdQvQVutHrI=;
        b=QVC0C9hOEh+WLtryE56tLf/JVnpZyCE+OcBPzyF8M+ekXAx7FTp6v1QfjgkgKeOSM+
         S49mn/iaJmOvypUNGxlQMGVgwyDY0R7GGi6zZEwzJoamD1/vmaD/5ei/Jxt3VLxtxQFK
         729FbDsWn1uUMg0VvL08PykggdlViC5Kk0bOh+pMY/ykDDNwQUk1popFPIyiTHSVxOss
         W8HofZ9g6d31IkROY+P3YgqFQsBlNPvqJiZAOXQz9HXdgKe6kzdZBEa64S91hxyY3nuQ
         jprl9z/sBUugKFMrBbm0nh8lfY1CXITkfquv+YCfUvRLNCasXdWYwDXagoWHvfVQf1Ss
         kSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:references:to:date;
        bh=VDbQ7ZWGWdKo250qIUj1jUlVrB3j+PyofdQvQVutHrI=;
        b=Cv5gTz1rVgtQ3bq46CHaoN7ozHNfndV07YkpvUR6z1ju3reloF3uqMRXze2AnMqoEz
         1SFu8+05aMIejVp5gQxxQuihh69AOFoNLOFytpd3qjz1cjOIZ/26FuzrmcHqF5JxX0F3
         mDZGuOvZXL2Ci3tJXrBVqhrBfFaXisFkztbdrV9NwxQYf6C36HV2xZMIr/WKN/jmKUus
         xVeEmzn59p3nZEHrYFftxn6Ffsg15YhJpm/0g8RJtag4aGzemdcLUtbFH5CFw4qfwFjv
         bLfgF4UZWG1O4scOJ4TU8PSIY6WYz5u80oyLi8T3i84i66f1n0q8VyFgpR4NqdqU/dQG
         fq0Q==
X-Gm-Message-State: AA6/9RnKVuk9uul/LoQWhu5qcknwZylqGTnMtLMIoKPslj5Vl7yMr6n+4mr6okDpb17w2Q==
X-Received: by 10.194.140.77 with SMTP id re13mr3820046wjb.79.1474569895979;
        Thu, 22 Sep 2016 11:44:55 -0700 (PDT)
Received: from [10.10.20.9] (fw1.hnojniknet.cz. [94.229.92.42])
        by smtp.gmail.com with ESMTPSA id w71sm3781633wmw.17.2016.09.22.11.44.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 11:44:55 -0700 (PDT)
From:   =?utf-8?Q?P=C5=99emek_Koch?= <premek.koch@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Fwd: [git/git-scm.com] Git Gui crash on Mac OS Sierra (#853)
Message-Id: <EB727288-20B8-4CB0-8B6A-340E5A972B03@gmail.com>
References: <3DDE880D-8746-4E37-903E-B23B1AD338DC@gmail.com>
To:     git@vger.kernel.org
Date:   Thu, 22 Sep 2016 20:44:54 +0200
X-Mailer: Apple Mail (2.3226)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Hello, maybe right place this time...
>=20
>=20
> I want to report a bug:
>=20
> On MacOS Sierra git gui crashes randomly with this message:
>=20
> 2016-09-22 13:17:36.759 Wish[23615:1501726] *** Terminating app due to =
uncaught exception 'CALayerInvalidGeometry', reason: 'CALayer position =
contains NaN: [0 nan]'
> *** First throw call stack:
> (
>         0   CoreFoundation                      0x00007fff7f0407bb =
__exceptionPreprocess + 171
>         1   libobjc.A.dylib                     0x00007fff937ada2a =
objc_exception_throw + 48
>         2   CoreFoundation                      0x00007fff7f0bda65 =
+[NSException raise:format:] + 197
>         3   QuartzCore                          0x00007fff84c09980 =
_ZN2CA5Layer12set_positionERKNS_4Vec2IdEEb + 152
>         4   QuartzCore                          0x00007fff84c09af5 =
-[CALayer setPosition:] + 44
>         5   QuartzCore                          0x00007fff84c0a14b =
-[CALayer setFrame:] + 644
>         6   CoreUI                              0x00007fff8a9b0112 =
_ZN20CUICoreThemeRenderer26MakeOrUpdateScrollBarLayerEPK13CUIDescriptoraPP=
7CALayer + 1284
>         7   CoreUI                              0x00007fff8a9ac317 =
_ZN20CUICoreThemeRenderer19CreateOrUpdateLayerEPK13CUIDescriptorPP7CALayer=
 + 1755
>         8   CoreUI                              0x00007fff8a92e4d1 =
_ZN11CUIRenderer19CreateOrUpdateLayerEPK14__CFDictionaryPP7CALayer + 175
>         9   CoreUI                              0x00007fff8a931185 =
CUICreateOrUpdateLayer + 221
>         10  AppKit                              0x00007fff7d675623 =
-[NSCompositeAppearance _callCoreUIWithBlock:options:] + 226
>         11  AppKit                              0x00007fff7cd22a9d =
-[NSAppearance _createOrUpdateLayer:options:] + 76
>         12  AppKit                              0x00007fff7cf9b143 =
-[NSScrollerImp _animateToRolloverState] + 274
>         13  AppKit                              0x00007fff7cf5ab79 =
__49-[NSScrollerImp _installDelayedRolloverAnimation]_block_invoke + 673
>         14  AppKit                              0x00007fff7ce21331 =
-[NSScrollerImp _doWork:] + 15
>         15  Foundation                          0x00007fff80a3ec88 =
__NSFireDelayedPerform + 417
>         16  CoreFoundation                      0x00007fff7efc0f44 =
__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 20
>         17  CoreFoundation                      0x00007fff7efc0bd3 =
__CFRunLoopDoTimer + 1075
>         18  CoreFoundation                      0x00007fff7efc072a =
__CFRunLoopDoTimers + 298
>         19  CoreFoundation                      0x00007fff7efb82f1 =
__CFRunLoopRun + 2081
>         20  CoreFoundation                      0x00007fff7efb7874 =
CFRunLoopRunSpecific + 420
>         21  HIToolbox                           0x00007fff7e557f6c =
RunCurrentEventLoopInMode + 240
>         22  HIToolbox                           0x00007fff7e557ca9 =
ReceiveNextEventCommon + 184
>         23  HIToolbox                           0x00007fff7e557bd6 =
_BlockUntilNextEventMatchingListInModeWithFilter + 71
>         24  AppKit                              0x00007fff7cc4e5f5 =
_DPSNextEvent + 1093
>         25  AppKit                              0x00007fff7d35e8eb =
-[NSApplication(NSEvent) =
_nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 1637
>         26  Tk                                  0x00000001047cc285 =
TkGenerateButtonEvent + 494
>         27  Tk                                  0x00000001047cc54d =
Tk_MacOSXSetupTkNotifier + 395
>         28  Tcl                                 0x00000001048be5a8 =
Tcl_DoOneEvent + 237
>         29  Tk                                  0x0000000104726f4f =
Tk_MainLoop + 33
>         30  Tk                                  0x0000000104732a5b =
Tk_MainEx + 1566
>         31  Wish                                0x000000010470d55a =
Wish + 9562
>         32  libdyld.dylib                       0x00007fff94089255 =
start + 1
> )
> libc++abi.dylib: terminating with uncaught exception of type =
NSException
> error: git-gui died of signal 6
>=20
>=20
> Premek Koch
> premek.koch@gmail.com
>=20
>=20
>=20
>> Za=C4=8D=C3=A1tek p=C5=99epos=C3=ADlan=C3=A9 zpr=C3=A1vy:
>>=20
>> Od: Jean-No=C3=ABl Avila <notifications@github.com>
>> P=C5=99edm=C4=9Bt: Re: [git/git-scm.com] Git Gui crash on Mac OS =
Sierra (#853)
>> Datum: 22. z=C3=A1=C5=99=C3=AD 2016 19:43:30 SEL=C4=8C
>> Komu: "git/git-scm.com" <git-scm.com@noreply.github.com>
>> Kopie: Premek Koch <premek.koch@gmail.com>, Author =
<author@noreply.github.com>
>> Odpov=C4=9B=C4=8F na: "git/git-scm.com" =
<reply+000da9c18ad6de0541ea9352a4e1e834fbf1dde22ff10e3b92cf0000000113fbda4=
292a169ce0aa4f922@reply.github.com>
>>=20
>> This issue tracker is dedicated to the git-scm.com website.
>>=20
>> The issue you have raised is related to the git program. If you think =
there is a bug in the git program, please, send your issue to the git =
mailing list git@vger.kernel.org
>>=20
>> =E2=80=94
>> You are receiving this because you authored the thread.
>> Reply to this email directly, view it on GitHub, or mute the thread.
>>=20
>=20

