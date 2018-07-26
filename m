Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_ONLY_24,HTML_MESSAGE,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,URIBL_GREY
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0491F597
	for <e@80x24.org>; Thu, 26 Jul 2018 12:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeGZNZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 09:25:08 -0400
Received: from o1.office.mobisystems.com ([198.37.146.154]:52569 "EHLO
        o1.office.mobisystems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbeGZNZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 09:25:07 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2018 09:25:07 EDT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=sendgrid.net; 
        h=from:content-type:mime-version:subject:to; s=smtpapi; 
        bh=tq1s9fbsneuui9qTUXhWI9SidNU=; b=Q4+J0nytSCb6+TQfICn9h3X2e5uyM
        OyS7lQrlYESc4hYHVhJqytKBS3q7nLYCtN9xcJBcEFsKhFVYxKQ2cM7kawMtDNvD
        GrVyFXN8Fxl0hC6N56UJYof2zWfoW0NsdDuD1Jc4doFWwXugmTe+23dRpTlJv5yU
        NYr29tHbjMgvj4=
Received: by filter0056p3las1.sendgrid.net with SMTP id filter0056p3las1-15074-5B59B844-21
        2018-07-26 12:02:12.291186777 +0000 UTC m=+49224.762336488
Received: from mail.ferryfair.com (113.73.230.35.bc.googleusercontent.com [35.230.73.113])
        by ismtpd0005p1las1.sendgrid.net (SG) with ESMTP id Ywirlr6ySqiBx7RbBfi12Q
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 12:02:12.205 +0000 (UTC)
Received: from [192.168.2.21] (unknown [123.201.171.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ferryfair.com (Postfix) with ESMTPSA id E8C9A45154
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 17:32:09 +0530 (IST)
From:   NeckTwi <necktwi@ferryfair.com>
Content-Type: multipart/alternative;
        boundary="Apple-Mail=_79DC19C6-6E9F-4EBE-A834-593F8A6C51C3"
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.17\))
Subject: fatal: could not read '': No such file or directory
Message-Id: <3D0FDBE2-469B-41A7-B27F-4A8706FD4473@ferryfair.com>
Date:   Thu, 26 Jul 2018 12:03:12 +0000 (UTC)
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.100.17)
X-SG-EID: YUhPsKA0VKt4kiGI+qrcaW2qjx7tU7rsf8gtpxAAA90tqlKwS9xtzc8Mmdkwu/SCYNTDVc5zYDvz/q
 1f5kEEdPTsgHHsBjATNsimX1yWWGdd4z6HO2lQ3NJbaKQQwvvT6l8micI8/B6sFvdvFaRkY4iiVKzZ
 hn5lemt1O646Kh3jzqnJ4woZun6gsikRwEcce4hi0Pn6/SjmAvACmXiJkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Apple-Mail=_79DC19C6-6E9F-4EBE-A834-593F8A6C51C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

While committing a repo I get the error "fatal: could not read '': No such =
file or directory=E2=80=9D.
The git repo is a samba share mounted with smb vers=3D1.0 in linux using ci=
fs-utils.

I tried git rm =E2=80=94cached ./* && git add =E2=80=94all && git commit -a=
 -m =E2=80=9Ccommit msg=E2=80=9D
It gives the error.

I suppose it's a bug.

=E2=80=A6 NeckTwi




--Apple-Mail=_79DC19C6-6E9F-4EBE-A834-593F8A6C51C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D"">While committing a repo I =
get the error "fatal: could not read '': No such file or directory=E2=80=9D=
.<div class=3D"">The git repo is a samba share mounted with smb vers=3D1.0 =
in linux using cifs-utils.</div><div class=3D""><br class=3D""></div><div c=
lass=3D"">I tried git rm =E2=80=94cached ./* &amp;&amp; git add =E2=80=94al=
l &amp;&amp; git commit -a -m =E2=80=9Ccommit msg=E2=80=9D</div><div class=
=3D"">It gives the error.</div><div class=3D""><br class=3D""></div><div cl=
ass=3D"">I suppose it's a bug.</div><div class=3D""><br class=3D""><div cla=
ss=3D"">
<div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; widows: au=
to; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-=
width: 0px; text-decoration: none;">=E2=80=A6 NeckTwi</div><div style=3D"ca=
ret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Helvetica; font-=
size: 12px; font-style: normal; font-variant-caps: normal; font-weight: nor=
mal; letter-spacing: normal; orphans: auto; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; widows: auto; word-spacing=
: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text=
-decoration: none;" class=3D""><br class=3D""></div><br class=3D"Apple-inte=
rchange-newline">
</div>

<br class=3D""></div>
<img src=3D"https://u7535577.ct.sendgrid.net/wf/open?upn=3DOwJOUSI1LxmyLIHA=
Tw8GP3etY9Ae5g91tIgtCC9UpG4L46WSupmV6nOpP07ck3e-2BSzC0Qc1Y2UFj95fGe6FHkjmUe=
HpbqD7FERl0JOwLiamBcur-2BohWlO3PoeS1cQT3m9C2O2Ah2i6mdhKvAaNccv6NBmrwstwe4iN=
hEaxQqiptY9FyPH6S5H9EUuMF7XaKTkOjWsE2V9XOHSSMgWF0KaUtmXLb6oEWSAw85Z9Y3LMg-3=
D" alt=3D"" width=3D"1" height=3D"1" border=3D"0" style=3D"height:1px !impo=
rtant;width:1px !important;border-width:0 !important;margin-top:0 !importan=
t;margin-bottom:0 !important;margin-right:0 !important;margin-left:0 !impor=
tant;padding-top:0 !important;padding-bottom:0 !important;padding-right:0 !=
important;padding-left:0 !important;"/>
</body></html>

--Apple-Mail=_79DC19C6-6E9F-4EBE-A834-593F8A6C51C3--
