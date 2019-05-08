Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE6E1F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEHK4d (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:56:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:53549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHK4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557312986;
        bh=4CW2LhBKYdJ10KSJOetUXaHGj00c0X7/69E7C07QxxY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LMxoyvfVJccipdHcYJBPB0YW0ard6q0aXAObz4K/2cx8uwyJbhBySynrEXG4FCdon
         8DjjCCaeZTG1JI86dl20zxVDANNEd8wIK/jZ3yki5RPWNMkKojcxgvaMoHGOv3HKBB
         eQ383voYcovlUZdMYZhkFtUIDCG0G9A0KR0utFps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.111.32] ([95.208.59.200]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKYLf-1hP9C925Op-0023Rx; Wed, 08
 May 2019 12:56:26 +0200
Date:   Wed, 8 May 2019 12:56:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Dustin Spicuzza via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dustin Spicuzza <dustin@virtualroadside.com>
Subject: Re: [PATCH 1/1] cvsexportcommit: force crlf translation
In-Reply-To: <xmqqtve6lito.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905081248190.44@tvgsbejvaqbjf.bet>
References: <pull.132.git.gitgitgadget@gmail.com>        <9b508af11be125ce5fd80c40c732dbcaf45067fb.1556575126.git.gitgitgadget@gmail.com> <xmqqtve6lito.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+1Q+E85RwKGaYjOXokt6zPJVmP3WGIQNyOYfjHjuq2/Gh0SsgMb
 xAp/LS5UGQcsewnRc0rEipCiZUuyhEvFmH7lyMEVi3t+6mWnFryLa1rVseN+RVmP1W7yldf
 C5vv0gaaoY37pY91ZFCeiCHlbbz8pwiV4LCbrWHpTmwaMTo4B5M6qcarbdrj2XPi2Ts8Z+v
 JvYUlF/ZowtQ90Vb0NSPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eTEJY7Isu8c=:XEgV3kQnjg0tfBP1rS+Kzg
 8xZLELHsZARnEOBe9XAKU9X4vV/bZCH7mXSse3VhYr3qhA1TSI6GKOdr+z1HlZxRHrGgThQIl
 u/AKDZ+H+tLBHIFSD359wzh+2qqRPER4azRJsJHmGzSsd+hAJ0AgBhkCEphqEyl26Y1IyER8B
 FUvUS+cuWASnwo5KVmCiyMhSWnYm93td//oiM3LGr8s3sbnxFc100yRswOqrgxotHoBqo97kY
 rg6c0yBwBBIZg5JX1fof9NUuB1OIESoW9+FPtrmkPGJYMaBPyB3fmaITBPY+nPJuhG1oIup3W
 eE7/QghvYp1IgH149z65S+gkUug23cslIJxC24xMgGIZi3onqTIHc/IY+u+ygwQJcyS54dUwv
 YYmPQm3rYMH9CGpyLvmR+ItoSrUtQJN7/G3k1rhqzGUiVPCa3eXs10vHlcU+mdASM4p7lCC8A
 G27FhSWb1me00tmkxFo+Mooknc/sKj3INU64zUB1kdCGookTZsq1ATyNVCQqC9Tsf43mx+Zd0
 p7aoxnbs5EG0C33klehVVVvNSmXxdkafbM3GpHjtcdQKmYWXdRu/Gf9bp+zLhNoN5DM5MHbLd
 H5tIPoWxAvjC65q/PQr2VrMgRWZ2fX/iRPU/tW6L/vOzaZ5LFL2I/yyMg1zmCtLNnwf8CwCNL
 QOHxWeUMBpoS/sK/5peekeBpwJQo3eHRAaY+gG3J3HrTe6uYe8D5PgZy7221b3sNT4j75ZoCZ
 hGCVlPkiC/T7h9kuNeQFrx5Nf26eSgl7N/XYYp80+lauK2gkEOpuCqGUVbotTdqaKvP9B38O2
 UIDSkBEDDOPM5kl4xHuY/1MxJ8QYODzgtBJbeE8TPTrggFP8F+ds77YERWp2GCYWho4JN2sF8
 n/QqPl8/cD6Vjy/A2ZRKsGxg6WC/O26shZfSRR9y0nFfRej9cPOlSftdgNE2iJ9XwX1QtQ1+F
 Ak37qX3veaQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 May 2019, Junio C Hamano wrote:

> "Dustin Spicuzza via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Dustin Spicuzza <dustin@virtualroadside.com>
> >
> > When using cvsnt + msys + git, it seems like the output of cvs status
> > had \r\n in it, and caused the command to fail.
>
> This is a bit under-explained in that it does not make it clear
> where the right place to fix would be.  From "X did Y which caused
> the command to fail", a possible right fix could be "so fix it by
> telling X not to do Y", but of course a patch to fix cvsnt won't
> come to this list ;-)

Right.

How about this:

	The offical CVS for Windows (called CVS NT) produces DOS line
	endings in its `cvs status` output. Let's teach our own
	`cvsexportcommit` command to handle that gracefully.

It is unlikely that anybody wants to spend time "fixing" this in CVS NT,
even less likely that anybody would take that patch, and even if that was
the case, there will still be plenty of CVS NT versions out there that
`cvsexportcommit` cannot handle.

I think it would be best to just integrate this change in Git and be done
with it. It's not like it adds a ton of maintenance burden there.

(BTW this was also my thinking when I accepted that patch into Git for
Windows, and thereby accepted the responsibility of upstreaming it.)

Ciao,
Dscho
