Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A31C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24634611CB
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 09:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhJVJ2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 05:28:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:51765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhJVJ2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 05:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634894778;
        bh=8P0WEnC6d2dRA5eJ0jcf1b9YNp+M28BVLDlVdwr6lNA=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Yuxm2olQIrk8A2E4C+ndy3/HOXBCPCWY4VkdRaugDdDWuRTJsaK0sUyqOlVEPqeHZ
         bSeAYAhffNiXiTSS5L+R1ptGGlsbjr383lQA78TTjnjYmbnc4X8ZSMla9H+WoRR3yr
         VzC5wX1K/EoWwcZRXFSd9N1bQUibP2CbUSJ1KFy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiU3-1mH8tD0oJB-00U6FM for
 <git@vger.kernel.org>; Fri, 22 Oct 2021 11:26:18 +0200
Date:   Fri, 22 Oct 2021 11:26:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Let's have chalk talks, was Re: Missing notes from the Git Contributors'
 Summit 2021, virtual, Oct 19/20
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <nycvar.QRO.7.76.6.2110221116391.62@tvgsbejvaqbjf.bet>
Message-ID: <1MQe5k-1mIUTU15Lq-00NjOF@mail.gmx.net>
X-Provags-ID: V03:K1:g8VaUD6bsv8qUF2VJZoz/OSNmGVOgFNIFAvU3k3yifa7es4vGWr
 iWnIttFFYZWtaTQ9G8AIL2lynH2zzH4/ql13L82iIkks6WjB+qYTOWmGSEVOUeu2gcSFLWu
 B3RPm/8I99cG7zdN0k6CtVtb7t1k+cgcKCakVIVhyX0bgLJ6ZlaFNKO8/zPEiAqGOB062QH
 24e25cq6LqZgbik3uA2EQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GOJTTuiAynw=:UGAxkfH9eRC4oySJVe3GRm
 /5L/Wv4ZVoVrsC1LO06HgOTk9fCRDauSC70JTyO+2gMu83TTsK/AkDRm7voshZrBy4HGA5Ce2
 yu4WUI6yqCL17fulg+io7kZKPJGr6cIYZHloi3BokC+tUvJQPB4dlgmRzELuaWIZKIZYkl2ls
 lmBZTL4tfyn7b0Nzbdqkwb0LgyId+v9W3imFNQoq5lo2auHQ1AHneLsKJBEmaDZPS4yeIoU9g
 nwyWR+lyzKP+/aolLDwsIqNedKqzN+/0wSLJycvbBodLPqyky4uiPaPqdO+Mh2df94KXtLBdA
 eEF0PqnkcanKvL44FtuAFslbepDZk3KSwtIrjY8HGxDWR31zRx9khYWFeF02YjKb+t+Nti0S4
 6NRsEgt38wDAWMzpbuMiRwaYOsamRn6QNBagSaSGyycT5oo2fXHh22iqvg6wFOxM3jYVBgPot
 zdylvWdUsMC/HW/StcbeqGp2TMnEnuO7Y8H/slAecMPb4srBtx3Cwvy1XjDniy0HZlXK7uSbU
 T2DDJTEa0QT9xiBmPB9SLp1aVLiUbE6AAtiaVX70Smfobn++Qg7Xbe3PdFkuqSkiEMQif334F
 sAnHfz45ljcJ66fM09j5HlrQlXPFxgnUMHT5MdXu3LjtHwvTDGh/tRkofoyWoDJvwyg9QdWvu
 F5swwMK8X3sO1r/zAF5YLGCa6Lvn9fxxiwspR9tVZ/M419eygIO+b+tBZrAFPL1TPPneIqm4p
 c94ixv9IRGVbyMDOqKOby20HrzG9TKzTXR2REO7bgsCgCmvK2w4jteOeE8k19juF2MRr1nwR1
 BBtnMRqVzVEJCibLMh6hKlY0hjfDgB+3HPCYkQKk/I3aQoaT/uupm3SfcO4QNdsoWQcZlP5gO
 i9Y7EgAx4ArKm6ZyNUrKQDljt0DZuOrCH0wO4bNO1KqIRvkfFQwipBFqwcGWqYRY6hVVbmxyR
 K2x9Jh2HO9anUDMdN0xN/NdVeH74dFU6VXd5EZbDM4+HxyryVTSgjWUr0lQbQjq0NbY2Wbk+E
 zfk+LuKsXYpGo4/KgIPDfpX82lEVzg1ByVKF+RkL7+bkT74CBFLJ40nFTw5gl1SOhQpUYkhZp
 Y9vlba38zaUT70=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

If I did not have the impression that this was an important topic, I would
definitely stop trying to send the notes on this session.

On Fri, 22 Oct 2021, Johannes Schindelin wrote:

> The[n] brian m. carlson offered the idea to be considerate of
> reservations by participants, but also accommodate Git contributors who
> would have loved to see the presentation but were unable to attend due
> to timezones, time conflicts, etc: offer it for viewing only for a short
> while.

CB then said that it would be nice to see the other contributors face to
face, and that they really liked the idea. But they still hoped that this
new talk series would not replace the other things we do.

Another point was raised by Emily: in their internal meetings, they often
talk about patch series that are in progress, or not even started. In
other words, the discussions are somewhat ephemeral and therefore it would
not make sense to keep records of it forever.

to be continued

