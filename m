Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92F4207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbcJFNJJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 09:09:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:63038 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753197AbcJFNJI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 09:09:08 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MI5JG-1bsfqj2PJW-003s6Q; Thu, 06 Oct 2016 15:08:55
 +0200
Date:   Thu, 6 Oct 2016 15:08:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 20/25] sequencer: left-trim lines read from the
 script
In-Reply-To: <xmqqr38p3z1i.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610061459390.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>        <cover.1473590966.git.johannes.schindelin@gmx.de>        <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de>        <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609121019290.129229@virtualbox> <xmqqr38p3z1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L5tWybAp89ZYs5E34YWFreMQg9w/3+rFyDAQu4/3ndd88BEjmRg
 gu0AqqiuG3f+Kni0425J9OOtRPbKVB0E6eyt0fQ8O04h/6EtDxTAVbBacbMqzUZ9Xz1gNgp
 SWWWDz0CHlLuWFJsybPGJ3G+AIRgXgXEWmL8bIHvTgx7kE09xzSH4iHGzea9WJuQ1eWH/jo
 ABG8Y+jcThiL7bQ56BZkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tEaauvMJB5I=:KStYZuVkCm+rhWRV3au1ES
 /t09C+qmNUK7jLzwVvFDN/nsP0ybUm0OOIHdat3w2zkuPOCtxkgadLHpxghmgO0VFJUqOAmrJ
 9ZHnlfx2iOJ29P+sPz7P1ZNq2aPcnLDVsY7KzoC7y7Rw3OkrXmBSb6CFEqzKeVWj86Ufs22QI
 IhUXwLpt5Jjtt6bHlyBKXV3sWshMZUS24yz44ABCzYnJ6SEg2+R+Hed2AD6nXgIshMrphk1OC
 DL0w2dVJ5zdmVxIzDJkAtOYLNKSjWbJqRjeSyQPU4LPXEkhlD0EevCNSMmEl/bxKEizl8VUH4
 Z9X9T6IsUzHLZyf7COiVKT8Esj/EhcpMipprUxDSMWilaPjJpOulD21bnW26Vvutlg3f23FfA
 /MR90YyLWoIHN4BMRaUUpn7/BsajZ3NaOqS99lyg8x8FpfOlhZd2KvEbhLotTeoeKFZ8yf+ac
 LdMnuku604mFIqbZTNEKTUBqrGZf8aMX1TJdavn69nt8j3dLpONBCz0G3faCA0tmcM9YwGkzr
 mQk2apRr4RFccnh8fSugudwUwOg/Ef5RriCpf3kV+3Z7VUI64Vx8eLl7B2i/BE6m4hChGkRi0
 +gmXleIVESSqm3goV7dW6RME161jUPAhZ7hyT5xc1HMCtarauxzsC//gwUv71kir5w4HGqhLG
 BfrDrVcX1PW5ZnT5x5eyeJCZmjLChbX8LTyFNit1iQ+z+aG5eAKiGj5gywvoUAFPDJnmhxavW
 1x6qpnTnMp5OrD51H37MNVfa0mSg/trPhbCE5DIZPEvfT903Bkiy82Jum5FrI00xjlTeQH8+A
 xhZW9c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I do not offhand see why we want to be lenient here,
> >> especially only to the left.
> >
> > Postel's Law.
> 
> How would that compare/relate to yagni, though?

I did need it, though. Blame it on being overworked or simply tired: I
ended up inserting a spurious space before a "fixup" command. This command
was handled as intended by the scripted rebase -i, and with the patch in
question the rebase--helper agreed, too.

Note: we have no problem to the right because we do handle variable-length
whitespace between command and SHA-1, and we do not care one iota about
the exact form of the oneline (hence right-stripping is not necessary).

Ciao,
Dscho
