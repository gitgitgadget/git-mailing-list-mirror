Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD3E1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbdA0KWC (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:22:02 -0500
Received: from mout.gmx.net ([212.227.17.20]:60067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754795AbdA0KVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:21:49 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mg3h3-1ctvb1355Z-00NPyW; Fri, 27
 Jan 2017 11:21:42 +0100
Date:   Fri, 27 Jan 2017 11:21:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] use absolute_pathdup()
In-Reply-To: <d15fdbb9-2a21-eeab-1fee-4a1553bd3bcb@web.de>
Message-ID: <alpine.DEB.2.20.1701271121120.3469@virtualbox>
References: <d94d742d-1247-ac35-c081-7db1f2178d34@web.de> <d15fdbb9-2a21-eeab-1fee-4a1553bd3bcb@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-512445254-1485512502=:3469"
X-Provags-ID: V03:K0:AUp8FRK+Q7w06Jos2ATCvNYHRtCuIrnDarV76/mGIsegOPJhTtX
 TSXIgJY4vsZNnPs4NfMDWDcZwF02lyueeIFNMJ91kzxSFD878uxk9lY/DlWUIs2RFib3dSL
 vu6SC+9UPGKO83qZlrFKvvJ9BGSnVGino5WJ/7Sq3+4CH88Za6oK3I8DsYFJNtKh/Jp/7wU
 yBjhheDh0lJ3otDFcBr9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yRIY8Vig92A=:XoFcIUn3H0bkFk0KSlNZ2c
 CyPQaio7nHkCGGpX8axxhwA1tlgDhsufil8EdRxPfuXOE6fSS7CtSpW61OueYK24bD1E9YOAG
 oArU82RZ+5chYSrsTXGeqaQSKYWRUsU6HuQFN0uVkFMfbcVZRTMHV9BRw2TM/q5maV3UTOExf
 /ZMK8ZrLYzR1qzmfPwbb1OKfMhd/fPD7B2ac1O+l8NnvfB9u1CaKmUj6bJd5f6ZBOAa8ywcwH
 2zh3HWidwAESwbxJYQrsdcKkZnGGXAol/ZF7Z93bUlLt0L1xDsOXRTmCmfyuNCOmW40AB/MBv
 tC2vyExDLIrN76pI3z+ygGRoFOr4IK1Suyiec+Ni1u3X73YrD+ZCXI6kmlI7eellPUVhSYz5R
 T9mzkZOIPXRIS70NjvKymLUtB9pZJsO2DEB33RBEoWFmgWT/oFvQ0TCmt9ab345hMdajFm3t+
 /n+a+ulo+IRdnHD01gJKBgnQNpow3WIzYUPJxWJOWdXJ99YjsObzbmmzfhJZDEdyZP9RsfuzR
 j/I57wGcaTjClKla40wljdnaIxLsl3GwHvBnmrEuNgDQIeibYfa/ifcgB3Zxp3QR0Jyfdu7iD
 ae+1V6bSAE/zBEtF4Eu9bzPidDHD3cPfUNSDoN23RCgpYwwLQATlZ8vSBdPT0beFbLEQGirFC
 fOSXgTydMYw7k5OgIxrhqRqxPwUIg1V2cjnjW72sTMUephgDMEGfQ8K4s0NmJRNhGnX+8DSay
 3m+WhwlB5XCwS9olwr0nuQv86lxO8ertW5iB2zdMpYetN5/ByCHWwQ2IAcduQPaKdNqUMwNlL
 yu/qYX6UwLmqkztrE/ZbIsLLAK8ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-512445254-1485512502=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Thu, 26 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Apply the symantic patch for converting callers that duplicate the

s/symantic/semantic/

Ciao,
Dscho
--8323329-512445254-1485512502=:3469--
