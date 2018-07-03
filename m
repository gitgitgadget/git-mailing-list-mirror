Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083F51F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeGCLyo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:54:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:34155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbeGCLyn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:54:43 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6jIK-1gNuEQ2Ei4-00wTgF; Tue, 03
 Jul 2018 13:54:26 +0200
Date:   Tue, 3 Jul 2018 13:54:06 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>
cc:     git@vger.kernel.org
Subject: as/sequencer-customizable-comment-char, was Re: What's cooking in
 git.git (Jun 2018, #07; Thu, 28)
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807031353520.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ndDfX1D11O/7/wpwFS804K45u+dP9RvdhKp9HbqJ8hmXUqtXq7D
 C1z7KL55GtqMSfa2jX/4lJY2ZVd7UyVq9t1pXQiW+zVX8f1UNWX5OtW7yD92IW+i3Tx+Gwq
 zHbm1sNJOtWn5TMSzu2aPpGZ8cf2eFGgmLA7PPL0Um0igHozdPhlzjysDJxKkvbc2/L9MJ/
 IKQIN0CoyOZyaYoLtsIaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iiwORn7bv0Y=:VsnPNwsVAm7cUvEwD7Z0A0
 OczkluNjOFZaw+qqwdgU3LmGr0AAuhQ8apwyaFDlWVsEjBJPg1VnivF2KLZC8Kdw508ar2KiS
 gd6GalESOhZbH9FctDLfl/RD2EE3dSgIwAbfR3uUuq0/3RfN84NwqJrBr/vUexrlA6b5Foznr
 +vykJ8/CqGBdSzr8LoENVbbJkZmiW2z/5RX4+Bx/h7fy86Alk7f5AwaC2XnCC/rpPthO/tuxa
 JDtRcWSMXqmY3Wjm0XDqmiAKkSTKuOm5w1gYArTZjhH7gWgitxh8O4+iZWXrcuBG5q7SDizwb
 T541tkK3N7+Hv+HQrt8ZzxGp2HWMaHr4kaLRrlCFkXBZZK55sBs0+MhBkEMFBhMwJexhSCSX+
 e3KW/m1fLo27BLXMssZQSnc/f4UNi800RNphvD6ijCuKn2qVlg1P8/kMH1uHdnawXEBfsEzY9
 iWmqQyK5iucNGWs9Ym9UKUE9nbgr0/GXEUXhBxY010T9xMhSkg5qeo0ZK+0X3JrPz1qKAbvmk
 p8/S8MXn3koWFqEeR3je4x1RpKmlHmNWw3k1qCbfBX4V2j+/es797Ifdznu+g/kls8pRf4J9v
 FbwMWhcc7JfT8kWIrfhvFfOtbmPEKlipLbzPNIRZeOcLs90LzIoZKsbNaX5o5o1WdnMBo2fY6
 CzYWRd2WQKOJ/JDLm5xg7N61h5zOORmil9nEjaCOZj//r0sVU2g7KzGwZVpL0XXUHqwOq8kCU
 yufGUZ6V/D1na9zlhx+dqXD1SAtStHOD7Oe/suAdtMyfurrfQQf8fCSgtOVPVs/sg0xUDegL8
 RQgq57q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Aaron,

On Thu, 28 Jun 2018, Junio C Hamano wrote:

> * as/sequencer-customizable-comment-char (2018-06-28) 1 commit
>  - sequencer: use configured comment character
> 
>  Honor core.commentchar when preparing the list of commits to replay
>  in "rebase -i".

As per
https://public-inbox.org/git/nycvar.QRO.7.76.6.1806291607501.74@tvgsbejvaqbjf.bet/
I am inclined to ask for a "v2" (i.e. second iteration of the patch, see
e.g.
https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md#submit-the-patch
where it talks about submitting an "nth version") that adds an explanation
to the commit message why the "auto" value is handled correctly by this
patch, as this is not really obvious from reading the diff alone.

After that change, I think this is ready for `next`.

Ciao,
Dscho
