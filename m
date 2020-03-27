Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28750C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A381206F2
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgC0Slf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:41:35 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58677 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0Sle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:41:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48prKl6bpzz1qrGV;
        Fri, 27 Mar 2020 19:41:31 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48prKl6CXkz1qs9w;
        Fri, 27 Mar 2020 19:41:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id OYn-giXMZI6x; Fri, 27 Mar 2020 19:41:31 +0100 (CET)
X-Auth-Info: yu29oXDTKvEf33tGikk2I0TDfwhnB/d+OiUfras5/OaLFvWnkEwYbJdpGNdgkFE8
Received: from igel.home (ppp-46-244-163-78.dynamic.mnet-online.de [46.244.163.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 27 Mar 2020 19:41:31 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 74EE52C290B; Fri, 27 Mar 2020 19:41:30 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Andr=C3=A1s?= Kucsma via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?Q?Andr=C3=A1s?= Kucsma <r0maikx02b@gmail.com>
Subject: Re: [PATCH v3] run-command: trigger PATH lookup properly on Cygwin
References: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
        <pull.587.v3.git.1585269403947.gitgitgadget@gmail.com>
        <xmqqeetdhdxo.fsf@gitster.c.googlers.com>
X-Yow:  NEWARK has been REZONED!!  DES MOINES has been REZONED!!
Date:   Fri, 27 Mar 2020 19:41:30 +0100
In-Reply-To: <xmqqeetdhdxo.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 27 Mar 2020 11:04:35 -0700")
Message-ID: <877dz5bpyd.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 27 2020, Junio C Hamano wrote:

> The name of the ASCII character '\0' is NUL, not NULL

NUL is not a name, it is an abbreviation or acronym.  Its name is the
Null character.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
