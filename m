Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3811F597
	for <e@80x24.org>; Fri, 20 Jul 2018 06:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeGTHNi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 03:13:38 -0400
Received: from st42p59im-ztdg12250501.me.com ([17.36.65.27]:29179 "EHLO
        st42p59im-ztdg12250501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbeGTHNi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Jul 2018 03:13:38 -0400
Received: from process-dkim-sign-daemon.st42p59im-ztdg12250501.me.com by
 st42p59im-ztdg12250501.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0PC500600J3GKM00@st42p59im-ztdg12250501.me.com> for
 git@vger.kernel.org; Fri, 20 Jul 2018 06:26:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1532068019; bh=3/b85O1vox39NntCKc0+iZ8HhPvcHUG3qnMrWmqGD5s=;
        h=Content-type:MIME-version:Subject:From:Date:Message-id:To;
        b=xI2Ut7Lpx5vozEjlkHP12s72Hcium2cCE7ZL7uQdDhxefJDMmO09G6F7hcwxv8rPC
 G+aEZJ/tDQpUbDLtJqcXIMhTF/xEhvb5m/rCzi0pn7eMffgYaICPhFWFjhXt3QNigs
 4vsF2e1WL0Rqf28/CwWAfEBoV9JFukdziesaEAAV4oMrFy+2eGgwRPe+0i0QeuLCDh
 QylfNlrSGjZQeYQVkGuuKUneG6rAViliXEXBWfsDz5Dh/oBWtxlcdzuTSG3vbvuQw5
 q/yQfWmqALPcxAfxZSzRQWDXe3RZjYvofF04uwjTI4N/hbfSx+pY946+DbXdY4l1OM
 CAQXPzzdOrLgg==
Received: from icloud.com ([127.0.0.1]) by st42p59im-ztdg12250501.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0PC5004IZJ8VMC30@st42p59im-ztdg12250501.me.com>; Fri,
 20 Jul 2018 06:26:58 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-07-20_02:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1807200077
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.0 \(3445.100.17\))
Subject: Re: Gitk doesn't work on macOS Mojave
From:   Evgeny Cherpak <cherpake@me.com>
In-reply-to: <CAPig+cTJvJLMe4CFOb-yxqwF4udvs4G-BUiT=Kp-NZcfAWAyiQ@mail.gmail.com>
Date:   Fri, 20 Jul 2018 09:26:55 +0300
Cc:     Git List <git@vger.kernel.org>
Content-transfer-encoding: quoted-printable
Message-id: <CC28BF55-9334-42A8-8A40-5D3E54BF8961@me.com>
References: <D295145E-7596-4409-9681-D8ADBB9EBB0C@me.com>
 <CAPig+cT+Z-hN6WidMOUW2jRVNFovvv03LEFESXpr05NKmpnWAA@mail.gmail.com>
 <1569C0A9-7C44-4F28-9C9B-AF2489E021AB@me.com>
 <CAPig+cRYVwsMxUQGWHWyfC1gpVgEtt0VH-CmQoGizEAp-B_7WQ@mail.gmail.com>
 <BD1EAEBF-B125-4D3E-A814-F8824E5D2CA8@me.com>
 <CAPig+cTRdh56VVcOGzeJmUN-L0-v2i+rCdMGxdr1FEUgfUGw4g@mail.gmail.com>
 <5196A9EF-3967-4E4A-A929-58CD8BE72150@me.com>
 <CAPig+cRDTMW5O1T20CnK03wWb9W8ev9q34U4P4rRk-3hrnNfGg@mail.gmail.com>
 <C9089D48-5516-4EF9-9260-BADD62FA3CBD@me.com>
 <CAPig+cTJvJLMe4CFOb-yxqwF4udvs4G-BUiT=Kp-NZcfAWAyiQ@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3445.100.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=F0=9F=91=8D

> On 20 Jul 2018, at 9:25, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> [re-adding cc:git]
>=20
> On Fri, Jul 20, 2018 at 12:38 AM Evgeny Cherpak <cherpake@me.com> =
wrote:
>>> On 20 Jul 2018, at 7:30, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>>>=20
>>> On Fri, Jul 20, 2018 at 12:11 AM Evgeny Cherpak <cherpake@me.com> =
wrote:
>>>> Not sure what you referring to?
>>>> Is it alternative to gitk? How I install it?
>>>=20
>>> This: https://git-scm.com/docs/git-gui
>>>=20
>>> It's not an alternative to gitk, but complements it by providing
>>> ability to stage and create commits, show blame information
>>> graphically, etc.
>>>=20
>>> It's a standard part of the Git distribution, although it may not be
>>> installed by default, depending upon your platform and the packager.
>>> Some Linux distributions, for instance, may place it in a separate
>>> package for installation (named "git-gui" or something).
>>=20
>> Just tried it - it works, but doesn't get focus.
>=20
> Looking more closely, the code in "git gui" is catching and silently
> ignoring errors:
>=20
>    ## On Mac, bring the current Wish process window to front
>    if {[tk windowingsystem] eq "aqua"} {
>        catch {
>            exec osascript -e [format {
>                tell application "System Events"
>                    set frontmost of processes whose unix id is %d to =
true
>                end tell
>            } [pid]]
>        }
>    }
>=20
> which explains why you don't see the "Not authorized to send Apple
> events" error you see with gitk, and also explains why the application
> doesn't get focus.
>=20
> So, updating gitk to mirror git-gui might be one way forward.

