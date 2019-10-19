Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB351F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfJSK3f (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:29:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:59353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfJSK3f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571480973;
        bh=gE4UzqO2VEEcRd7c/NJFH/x/kNoMxSbdpC/gMt/fKxM=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=gFJ8oEddfwX7i4u3AIsTxtz+GJOHxceZaPk1Zr7ozpaOYf96zlBPdF9/z/GGi8CZg
         3Du2VuEChlSujaD32HufMOTVcVc23se8vTRG1ua8oBkPbVyVwC1OtmJfvc5TQJqh4k
         rptKipASHL2xQn6VpP6I1DD9C9QBsJxUDCqoWeck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1i5v422gY7-00yNcF; Sat, 19
 Oct 2019 12:29:33 +0200
Date:   Sat, 19 Oct 2019 12:29:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Git for Windows v2.24.0-rc0 delayed a bit
Message-ID: <nycvar.QRO.7.76.6.1910191225030.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W8kHk9ymL9dzabqOgw5TZcJ+JN0k9hOT+DYsvvHEqaDLyaoFxSG
 TukMYg2mut5aAyX77WHM89Q4tc9sAftulu9vbJ5C9ti118Mc6KyNLlz47TVq6Lt0cDRA2RR
 GfTXveaFZOWCCouEArMUaUnYx/5WhubIx4SZP2NMP3J1g3SfVIXVADpkH3QXc1ert744U6L
 FVrWtYi7NTU9NO6itArBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8k+wOjJUjA0=:t07FPG7BqlHZa3tKG9HrwN
 mi3j050SPGMKoUIG0gyDrhJA8Yqb8ngz2Fl9eHP7O+V4yklxa2hSfdUCRNC7gQabWaaNnktOt
 hFZXK/n1JGMyzM92DCjYfDUYIEs18fJnuzPUI5cJ2GLciP2b2+9ZmyqJt42ri9FQypFG2t9FB
 TyBxjrqerguy2u+muAf5XKbJ2TXqjQUc3CVDTJgtXZLvA646ApRxi48YeUgwdRE7xEUkktRJm
 XsrwzobODMHDLWnPkiY/1EFWDy1wA/g+qntnr0jWDCvKAjQZ6iXsGbn4jFH0mn5VnxOhv8Dom
 ZabEKl1Wi2QZWhb5x9nW7qCS759YxwzfgTYeqOkAXAajkAGVJ+R4LdJ52YRb74KUUz1yNfD+n
 1H5WoWidPlFsTUCkER5z6Wgfza6N4xBifY7SIHk2u/DwoyeDLQ+pQY7+L5b3c8Btsy6OvhXqr
 CP6fGil03ZAjT3yOpEd26wcKGH+hYZH/URoynB7gdvcneJWMXpdeJRJeagS5rUw+ZWc4k/myI
 kVkxuKuQ/Eq9Ycq/+vrSPAlPavaqpZK2JvpF7MqYjJ5cAySmAy1YBYxGtcfSM9YqL5tJ2jixe
 9KxXF58zas6eJIorm4s25KlvI/ciQYfhu6AFpBi9Zgpuv7qEKRE3Y2pbn/QhuqdkvtMHuS3DK
 GFfw6KzzOgixuy9j+z/mWJx+IfX9WqMKCJlX56o74mOIK5yF5P5k4RTjs4XDmWILsv61Lhc3N
 L16KBMcX0IF62SIPBLlVW515HF3M4117v4/GC38z9vF6WuhL6ISm/59Qdqk7ySp41guxeLH2+
 5l3SrBVPn3p7iAFbw3bTjDtyFX8ouaL12C1c4JGOi9jbM7GpA7ySoOxN/snmIlRaXqXS3hPB6
 Ul5gwN1d8KDVvibpxIL6/6LjVZGN1qVDjeN3R8lzjEgKowBYOGLgpew/q9WSErgULjE07stCT
 QpZT7Nx+qcGMNeuBprzou4NbbEJJO+/1LpdZNBZyp5o4pEpZMH83dHOC6e53DVUA95rKSmkDJ
 1B1tNhwhM4IgwigVwr1Yacso5eB0/ER0Mn5h77SJycasoQ9fC0XUYDW5OzTyTBfon7rSSkeE0
 V9eMh6h/F8Bj9fR75ZldmybKfwSwdLjRPZxV2nbgYajUCsDdaCbCGrSEC/WtLFIIQRdrFSRoO
 3pvsIDcg0YgL6zA1JDB8qfU0jl3GL1Una74PojBwUz++4N9a7VSXdLBxK35IOFnpvXSAIyWMF
 b/zt+ssRP2cdc8B7OvR4WJ+EZWQh5ew03KjIg3Wqhjt71NeybTqszskE6e0M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I tried pretty hard yesterday to get a preview of Git for Windows out,
based on v2.24.0-rc0, but I need a bit more time.

The PR at https://github.com/git-for-windows/git/pull/2360 shows where I
am going, and I started the automation based on it, but it failed (and I
could not monkey patch it into succeeding).

The main issue is that I _really_ want to move the system config back
where it was in the olden Git for Windows v1.x days: into
`<Git>\etc\gitconfig` (in most cases, that would be `C:\Program
Files\Git\etc\config`.

Alas, it is this move that is not _quite_ done yet, as the automation's
failures indicate. For some reason, it cannot find the SSL certificates
(which are configured as a path relative to the runtime prefix, so I
guess that is what is going wrong somehow).

I need to take a break this weekend, and will continue working on -rc0
on Monday.

Ciao,
Johannes
