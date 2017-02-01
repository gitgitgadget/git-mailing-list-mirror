Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0BC1FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 12:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbdBAMBn (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 07:01:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:53096 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbdBAMBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 07:01:42 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LikQP-1c2Zel1fOX-00cxag; Wed, 01
 Feb 2017 13:01:26 +0100
Date:   Wed, 1 Feb 2017 13:01:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] connect: Add the envvar GIT_SSH_VARIANT and
 ssh.variant config
In-Reply-To: <xmqqpoj8z7su.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702011216130.3469@virtualbox>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <cover.1485442231.git.johannes.schindelin@gmx.de> <3d451f2c357a3fd7f0b0e4b427548553d7d05306.1485442231.git.johannes.schindelin@gmx.de> <xmqqo9yt4o5i.fsf@gitster.mtv.corp.google.com>
 <xmqqpoj8z7su.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U0GLf0zp3ZCaeiviMTp3kn3sdRS08CYbIauOOo1hxuWAOUItCxJ
 9wbrvOscw08Pj90aW2FIkdcOGiKXDGjVjnLLRXbI+KrwUEBaQh25mqFDFa65a3uswEwZrHn
 hGvjgSlvX+HUlCXKaqOQaqpDbPy0xXWQsK2k3siOaOEZ8juas7QYBVgiY4pVVrVOkkkyb3u
 TYYSGzZ/dhxOl3I0fLbtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j/zUpJo2wEM=:Srp7mRVUykrVFwoMixG/l6
 SnI0PN4A+Zmu8jLO4X5hij3od7+LDsAUMvVz4LgEBKz4cI6L+Ir4tGeoqwekePCh2fMXaduk0
 y17JhLJuxtdEIgE5Xt2OQ+I/k13z9bKmWrtfu94OrX1KW8JD5EROB01uI8vKGR0INBoxXZhLA
 IX3B54nYl+4KiIfvrve4rL+7Gi3QFCDYF4IAlbjDPAdz5GbXSFqMuJTqnVRspU/YDA3jVYvT1
 hIH5/q7CzBtTOXdTVX+1w2kd9ejZlLZ7I1N4mg+bIs9pF2dFFshBAqHWWVaFs5UVbb7oOqyHm
 9xhdfh0g4ZFJod4tP3n5tqpTAY5UYW1kH/b6ILhhPWJbTfqk0SKG+TV3q0Eo7O7jz/Se2R+t+
 oGn16sZaL3QrQUvDa0QzgYTA/94AowvAOQ9V2IL4PvhxUH7C1+tjSIBuTHdd7/DxDqtOmGyq6
 zrsnw4bT/qq3zJbZRqroPCyU20XGsx2mekrfUeCaIX6vIVzAXl4kgLBGOhTSVu7nguebU0jOl
 G2Kq6nPXXa3UesMuVclNydANrC1xwUhr0O+LrBmH/iNTvlat+uCQ5UgyC4Y0zU2sgyi+itzJa
 J5se19OMa5jMSshw0Gdmz/QxpBEiS6Im9oe1pkx4Vt736t2PnAmfOZnKOBBEUEcMNyw6NGIVX
 +K3k3oGFTKWCl/UzeQSIhmXGuZll086NtiPlhExZUjIG1Om41Q7hoXKintjr8Iklf8e4jn8kN
 pGIIMFr3pNgnLJxZ242df/v1ffUy0xFGMd//dZ7FJrb2pdazmaEER3hdVpoUOtE6BPTZHKzOh
 mDRKAwUkULWmlzr/QwNI7oXuKZvnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 27 Jan 2017, Junio C Hamano wrote:

> IOW, I think it is acceptable to always split GIT_SSH_COMMAND into
> tokens before we realize that the user used the escape hatch and the
> splitting was a wasted effort.  This is exactly because this thing
> is an escape hatch that is expected to be rarely used.  Of course,
> if the "wasted effort" can be eliminated without sacrificing the
> simplicity of the code, that is fine as well.

Simplicity is retained. Battle-readiness was sacrificed on the way: the
new code is not tested well enough, and `next` will not help one bit.

Ciao,
Johannes
