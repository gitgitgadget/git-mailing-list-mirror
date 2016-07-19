Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E28E1F744
	for <e@80x24.org>; Tue, 19 Jul 2016 11:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbcGSL1r (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 07:27:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:59901 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbcGSL1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 07:27:46 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LtmK9-1bG5AH3osX-0118Hm; Tue, 19 Jul 2016 13:27:33
 +0200
Date:	Tue, 19 Jul 2016 13:27:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
In-Reply-To: <xmqqtwfmkduk.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607191327260.3472@virtualbox>
References: <20160718064431.GA10819@starla> <20160718130405.GA19751@sigill.intra.peff.net> <alpine.DEB.2.20.1607181536540.3472@virtualbox> <xmqqtwfmkduk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wfUSybUt1unVhDiUnK3ljSBattr39UOlZ1WkzUeu8szwz+noYni
 hJIC9yWEeIaJvgU402Q2GTMvHt6gBzlm+UrDqNyCTnTi5CVYb6gMS8Wer/YCQ7g9jN9CJuo
 S8Qxt3qbwDJ/iXNoO2WL0WBRUu3codloLW3GmktYZDOYISKS8xJAzXGtp4QNiQTNa5LZgvw
 huaoNzszQSyanbVE53gGQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XxDQphF/H+c=:24LcXEUcsYEtmd0T/XurmG
 NTPYXgnpDNbmRQJVN5NkOH97RN4+7xP3Idw1nJHjwere1h7uWBn4+K59aX4H6LpcQ6ioyVY/M
 5DRwZTcRKTZcHi+WG4Dxp1GnV/hyHzwPLCwnjXVOiaQHQmJC2Ha2Qj1s/jmDWk83I1yJh0ORM
 myDR8RxURVEIecxHyZYzwv4q/XUkWkHQHjP6Szdm6hwBHZcPHmZQbJQnnMDCKwabNh17f0g+t
 Qc7Nf4wSVDoco5zHx/HVDiIL/UXRES25CqaF8aNvfZyuET6TGBAKXNMEt6llxAdRaKQ/2xk7X
 IDGPiULuXJlwCoEbyaGLx+wy12X/8MXD71YhlX0lhDIMGJAjakSDnm2FHlEMxzsHQ34tAQjLi
 m9nx2UlZo52dn5ipoa/Hi29DlE/nc5NZKMdlQcfZRR+H8EsYtqKpzfcwhMJVSJVoa3podDJzU
 o1bzaIskpfCCyUTjEcK7mdIYBD0by7ZmYreBZcbe3Ug50Llm9jghN0y5DD+zkIyD8vAJyvSW5
 PUcGRaKOTKGy37VfXNMGjBMOGSHn380V7rv7fVSD6QL7YNJOaGviNmCA5RiqHG0GhXvhl5A4u
 orROHPtHA4g9w/Q08VsJ9OdnxFl+NYZw9I3aDLBWWw6sJJIwDNttVSHXLB5ps38+QX67xlB+x
 aZVKgzlq9fRr1LGDzWeDxBm+fw2Vwsf6BFMVfPuPG3ss+1vUXjvpCwjwiEMmPCjw5H3RS5K7/
 wzY2ZNGl8qX0hzQa1PjE8bhnTSLPP39sbMeTlmE3xNZw6it10eW3mFAtWPfMMIemdVW+Am1V7
 NT95uep
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 18 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hrm. That sounds a little magical, and fragile, to me. What if the next
> > person's unzip returns 0 and *still* cannot handle -a?
> 
> That is a very sensible line of thought.
> 
> > I'd rather do something like
> 
> ... but the patch presented as an alternative does not seem to
> follow that line of thought.

Right. I tried to see whether I could come up with a test, but did not
immediately succeed. The patch I presented was the best I could do...

Ciao,
Dscho
