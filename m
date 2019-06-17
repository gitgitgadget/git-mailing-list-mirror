Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4479D1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfFQRlT (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 13:41:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:55671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQRlT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 13:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560793270;
        bh=eV0K50FwFYjEkhnyn4i4HZauF4dryjVLylHfOpj+bzU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MGzD27pG5BexTZf/bqGxCb2lXbf6wDVGV4Ow/C2ugBc0pHgZBKcvKb7WfkPBo/YwH
         ZW4/4PQbzssp6o22Kp6xqSSf+3D5RqWwHtkn29p/4esREk+nFzNfyyM4MOf9tiWCv0
         A1oH62ihOnnhb2jaoMEAKuXwXKKyQJzMujNCBD2U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIdYi-1hf8YP3wkK-002GQV; Mon, 17
 Jun 2019 19:41:10 +0200
Date:   Mon, 17 Jun 2019 19:41:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/gcc-8-and-9, was Re: What's cooking in git.git (Jun 2019, #04;
 Fri, 14)
In-Reply-To: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906171940201.44@tvgsbejvaqbjf.bet>
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T43w5j0zVJ2U9Amv8DBFLfhwHX/fUI6dpqXn7UHCKpe6P7wuYF4
 07ppIdmX6Vp0aMBR7wqPeKoWM1kxeY+nJKtpCdzZE3UPApD8TFkL5to3ROPqcELBwJydIik
 3gAxba8lSHwF9G8b3zWnx/Itp3FNivNakNTCWjtzxPbf/z5baLHsfFt7O/nIlcaOnh2JaWD
 U+jq9v3G+Fd/FILLF94PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b69KusZIGZs=:BGmljN+y4HP+la3ECGEO2+
 8Po3GwzfF5baZfayND+uora+XHdELC7H595MUcgksAO64fAXTpxU+e849ebis5CMpHiB7NlrU
 61sUpn9Ht7aERSVao3IBJzUpmTVFsVnJycEJTC58PyQEBOF5podAl/NpRNJQ2tKtku7UYesQD
 jkji2QRrWOpOppeaI5tY+t9dqxTYsBcXAuO3jXd5OLNKzoxFiDvopEejZWQemdYwqRfsINUYi
 HbXFvdbpHT17rsZtwZPSXDWDhl2f/PlTkROv6OffNCrVOdegHOCL9QW8AUpVSObJk1IYddq59
 7aUiUwyqB9lnXqhvmB3oVKbZ1k8F7sjiW3F27fni3V4ZMv8d6Xcvryly78s5q/XIeHfc/2ECl
 3+nraDaR46gwbTuF6gmJEZ3yIuvA63WYKhcKBjIije98sIvRbFpuJeE/JD2A66mBrmubFdnkn
 U30vs0Qn/hGbwpzYquvAYx2Nlkvf5/MCQI7AbUHkEmh2gy1ae2b7oFdt+2vVPwxaz32bxDzSh
 4lPFyrQy+XiU6yh8cVTtnLInFn9sVEGyaXUSgUEEqrkjN05rOerO3W0hPBlcYPonGEjYdyzGX
 ejDycoHGxX/fZ8qm0TVHN7tUAMLVJRhPRsdXXLbaZiCKDdQRBoLo2mdq3hHaoTs8My4xlmh8q
 2ibf6HgtJ/LuttgyF+vXh8vNt6JzPo4ZghsBX1haVmNg50bIGs43W4dfJIT1eCxI6pVo+9fyk
 vCMjieZROC3wpR1q8EQ+c5LafoRbf3zohB7aOv39Yc2A+FcdfZmyzRg0T68NcUHoSB0unv5El
 5JfZt4tO3ygkgh+brQFxRbMQar/D78fO89GB9ecAaY5roAyyJDBR1v0q2eH9mMF2yr2rQMZGG
 2Wk6bjFgAgAysRGoyh93G/ztEwIB2M5B5NeijGHEEqOwsAxXCygF/z/z8bT8gh7qwsQW9sUtK
 CSbjubrnZJv/VepQwaK4UvTdhTAwYzVh3NcFflb0BvClxNNxqtpHl
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 14 Jun 2019, Junio C Hamano wrote:

> * js/gcc-8-and-9 (2019-06-13) 4 commits
>  - config: avoid calling `labs()` on too-large data type
>  - winansi: simplify loading the GetCurrentConsoleFontEx() function
>  - kwset: allow building with GCC 8
>  - poll (mingw): allow compiling with GCC 8 and DEVELOPER=3D1
>
>  Code clean-up for new compilers.
>
>  The 'kwset' one may want to be discussed a bit longer.  Perhaps
>  merge the other three earlier to 'next' and then to 'master'
>  separately?

Or just take the kwset one with an adjusted commit message because it may
turn out that the kwset update will be blocked for a while because of
licensing issues?

Ciao,
Dscho
