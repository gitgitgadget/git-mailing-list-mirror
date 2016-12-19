Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCE5203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 22:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbcLSWxj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 17:53:39 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:34749 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbcLSWxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 17:53:37 -0500
Received: from PhilipOakley ([92.22.30.2])
        by smtp.talktalk.net with SMTP
        id J6oIc5pvNHGLwJ6oIcDjou; Mon, 19 Dec 2016 22:53:35 +0000
X-Originating-IP: [92.22.30.2]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=Z2NLu57L91ZL4nWmcuAXTw==:117
 a=Z2NLu57L91ZL4nWmcuAXTw==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=7vUEEOO_AAAA:8 a=t5ezx9KkqYA6CUZBtkEA:9 a=wPNLvfGTeEIA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=Bn2pgwyD2vrAyMmN8A2t:22 a=X_Y1BvaDLgsXqAkisrwy:22
Message-ID: <CB83F601FBED482582F20099849D661A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Michael Haggerty" <mhagger@alum.mit.edu>,
        "Paul Mackerras" <paulus@samba.org>
Cc:     "Git List" <git@vger.kernel.org>,
        "Michael Haggerty" <mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
Date:   Mon, 19 Dec 2016 22:53:35 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNrURnb7+pWVZAd4juhxqCa61rhbWqacYAAvYiqGpkWZELlIkZujRcMJ3F8QV5mtYteFK+0hU2xemo5Uo58TlTl8OFbh8R5lw8ryXnPTCpG2rPp4PU3l
 cbbpTEl/ZdsPCmRjsNdm43C/JWRJrpMumDJpavtj8JJvbpgOZH+hv9O+oFdWmoy6tBhlvr/HfvPaSMLHr7qFIaNUBmMMx8NMazPdwhO/DU51wgTQXAl/kT9n
 TI2eFOSH5KwcXk81yhYiwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Michael Haggerty" <mhagger@alum.mit.edu>
> This patch series changes a bunch of details about how remote-tracking
> references are rendered in the commit list of gitk:
>
[...]
> * Introduce a separate constant to specify the background color used
>  for the branch name part of remote-tracking references, to allow it
>  to differ from the color used for local branches (which by default
>  is bright green).
>
> * Change the default background colors for remote-tracking branches to
>  light brown and brown (formerly they were pale orange and bright
>  green).
>
> I understand that the colors of pixels on computer screens is an even
> more emotional topic that that of bikesheds, so I implemented the last
> change as a separate commit, the last one in the series. Feel free to
> drop it if you don't want the default color change.
>


Just to say that there was an issue with the bright green (lime) a while
back when 'green' changed its colour.

dscho reported in
(https://github.com/git-for-windows/git/issues/300#issuecomment-133702654
26 Aug 2015)

"[T]his is a change in Tk 8.6 described here (http://wiki.tcl.tk/1424): From
Tcl/Tk 8.6 on, Tk uses Web colours instead of X11 ones, where they
conflict."

In particular the old bright green version of 'green' became a darker green,
with the old colour becoming named lime.

For me, I needed to change my colour scheme (to a lime) as I could not read
the refs against the darker colour.

Anyway, that's the background as I know it.

--
Philip


