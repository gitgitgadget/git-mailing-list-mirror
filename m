Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1411E20248
	for <e@80x24.org>; Sun, 24 Feb 2019 14:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfBXOQe (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 09:16:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:47987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfBXOQe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 09:16:34 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Metpl-1geTuG2e3F-00OajR; Sun, 24
 Feb 2019 15:15:41 +0100
Date:   Sun, 24 Feb 2019 15:15:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: does "git clean" deliberately ignore "core.excludesFile"?
In-Reply-To: <xmqq5zt9oirx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902241515120.45@tvgsbejvaqbjf.bet>
References: <alpine.LFD.2.21.1902231008530.28936@localhost.localdomain>        <xmqqimxao76b.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1902231905180.45@tvgsbejvaqbjf.bet>        <nycvar.QRO.7.76.6.1902231912370.45@tvgsbejvaqbjf.bet>       
 <alpine.LFD.2.21.1902231328560.2222@localhost.localdomain> <xmqq5zt9oirx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3cWwBz22PaP7Peap/SLHipfGbfVfnF2dY3TNFDZqoCsl2UyGDkC
 iDXWwX1Ji1dJ3MfkBLDo+g2uTBjkYp4KveNXXLSuwHqT0xRKEXfvV4WDREfIgI0nXwloOab
 2Nr8eWGZorVzTE/8D9CkKCq7BVUFAeYJ1K86Rx4AlglV4xfztlYLAJtvFlmuYOsFJURgpiW
 3EpiaBeFEEOcjXWArOiCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4qK9re/CkbQ=:x7LJrLbNknvSTnTK/hejkw
 5JnOH/xTLL5Q03VfE8SG41er+qdwnVz6NideVwv+EMWUcHk32QW5cKYGd1eR0KyVRp7AhA0tc
 HSkixekK0Dilsm/968OPui2CdkdQS5v/e3N7ddlhqRP93xGHuJunIi4L2pbduc9I56QVJahBS
 +TrYtdyT63xnnEceYcmJoE8Npc3Z7HrZzjthxb2RPVbyH6GkSrzSHDTk/t/qelRCuzta/DqAp
 RaCEl4qz04Eb7u/5O0jKsmQPwjRPZm1nL63anixdlZQ72fXQNYNNIPl+g8UOTGCp4j0MRNY8V
 6eOmaA31oqwDgl2D+upt5zrWjIvw+6mgGcbIsrFlnzWJS25qasZIS1shrPv98ph4LQMoxqOVk
 5u2U6dx2vSdCO89SEnMrTmoaD2ct7Y8Dj8L+63BoGY8WDS3TcBJoGiJI6OFKtyzDuae3BBvay
 ukRydjgXOfRNIs/bNbOq+r5R91uo+ckMC5zh/ZoJ6zLZhdg5v2r0/fYE508njLToqMspbj3pc
 1oAuNjy4jdpV4XR2JolvRvHD6LS/2mZiu+hbrb2kWPOGF6qN+QM5cQ509i5gbW0KUE6+pXSn/
 TaARSn+zQf/AkD3WL0ZxMt+OZiNBdRYH6XXdbzOuSxhAzm8PhvJV0+nhACKCyzvqunCE/7ktE
 15wdBnmvuRs+ayGOmmwTRL2pFklrRbxcWTMW4OTGOjoLo0EJPz/5SjskJ3DiqyRWa+HlPGVnx
 ya2SJamibAbo2+oo5CV8uQ8sW8SQp2pBANBRcFIfm9rjffJOwyi+H4AEs+I+a/CJ42LDH/iSe
 tSOBmed4go56Wz+1Rj+ptkrv71Tf9Suga7T0RQvYOJEpCedhNPN7ZMNQA5k0rIzQQAxsHeLBl
 e2GaNk4vjn35wbCdiZKpt8Xk2Jlo1ZSvir2fIAWbEwOYiK7uRr7jfZsMCsy4uSlPkAFPcGpUc
 p+7ly5Ivkcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 23 Feb 2019, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
> 
> > On Sat, 23 Feb 2019, Johannes Schindelin wrote:
> >
> >> Robert, care to come up with an example demonstrating where it does not?
> >
> >   sorry i wasn't clear, all i was pointing out was that "man
> > git-clean" *explicitly* mentioned two locations related to cleaning:
> > ...
> > without additionally *explicitly* mentioning core.excludesFile.
> 
> OK, so together with the homework Dscho did for you and what I wrote
> earlier, I think you have enough information to answer the question
> yourself.
> 
> That is, the code does *not* ignore, and the doc was trying to be
> (overly) exhaustive but because it predates core.excludesFile, after
> the introduction of that configuration, it no longer is exhaustigve
> and has become stale.
> 
> Which would leave a small, easy and low-hanging fruit, I guess ;-).

#leftoverbits

;-)

Thanks,
Dscho

> Thanks.
> 
