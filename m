Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CCE1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfA3M0S (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:26:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:52017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3M0S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:26:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjquD-1hPoSJ0DDl-00boMt; Wed, 30
 Jan 2019 13:26:10 +0100
Date:   Wed, 30 Jan 2019 13:25:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -x: sanity check command
In-Reply-To: <20190129184327.30391-1-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1901301325370.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1901291632070.41@tvgsbejvaqbjf.bet> <20190129184327.30391-1-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fwt/R5AMncdPyYpaxwmJTXxTzrfXhLQYGHd4BllQrwlJTtJ7HBH
 EJY6K20N0/a/fspm3dJaXtdmtM9tvkIsILzLbN4ABhzaxdUQpTuwptLlu9CKtTd/v4towN5
 jkFc37uWDhwFNmY+uXyk9wdtF4UsLoI7ksUB+RL2E/BQMAXmweXaikl0O0OxL92dQyBPJNZ
 Ki8bfYp6qGqXhQ66dXDrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CwiY+VWtdZc=:fKTXwhKOHnRSJ2yvGC2x5v
 WeqdpvKmqmRFtt7HC8nFlODHfN6f3x2Gx9u9Yb/n6NDo9laGSyOlpdEVmgsYj16zHFFRWMS7r
 HWGrkQ38y4QC83Qp3HszFxCeaQjZuVtiBEmtb4MFfB1XQOCnRvTr3r4SDYT5w5kdPKauv7zHb
 82m7rEJzd3KbhbN7Uc718AIZpFpqIgZ0MsVmecHEMIU35A4t83+Fef9RhQZMtpePgbK8AmKHh
 BDNf7ZvKRlxv+ydA1+doEDdvSH9RSMrS2IHji0QLznksCy9CGoyWhNsd1wPXQbMi30+7kE+ZS
 AY9SmN1mPcshi54aSOptlXr/jbhPgL4l954RSt6VMfMR/LiH8zNIrOZvB9ZSNqv0CYYvY3UpQ
 8IuUSzkSL0t/RFjZdhEPc/TQDVX7FRvWpaVOvqXv7PKxtWesE46ZCM9I9r+s29EkPSRmf9Nvt
 MxWG0dBt9QLVbxEUEIEFXFVP0x/00S1srUx8ThVVK+TaGUvd9A44o5cFdtzCT/Gig57bqAYvn
 TVXLjBa8uiRX/6wUeNAXG6rOO5YdyfXsZoopX9qhqnM39dPH7ZlOVNwWjcaY8Jh10QKig0KeI
 ry3hrPjl+u0eZpQH7X82CT+x6WTN5N036AV7WB0hHFfznujxPakj8x4dIXogjjfhVOZPajMdm
 IXM5JfQDBOyP0iXphy0QFaa4YSnSMTVVywhSSu/qfTzR9D7T1a5X3cF043D1JaAOoLmwiPOKu
 hzT3ptfWAz74E6CwBNmxlkcvoCTVBRUYUzVcDYiUYXl2/+2nr4ip5ZR8NQP1QyWhNEZ7Scnvw
 Krg13MSsCfBiKGbpkLHhOQ57o7QjV7kYEZMyg5/sLsNQDLJWxKwDpT3+5fYDxL868a2nNiFcj
 g9K0NbVpV3Nk+otDbDs9hT99VnOrEuAa4TDcdQ7uvSiR2ijbRHHGFWlMYljkC+qD12rmOvz4C
 5jHJ4AVZ24Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 29 Jan 2019, Phillip Wood wrote:

> Range-diff against v1:
> 1:  9626549aec ! 1:  726b84c300 rebase -x: sanity check command
>     @@ -2,8 +2,9 @@
>      
>          rebase -x: sanity check command
>      
>     -    If the user gives an empty argument to --exec then the rebase starts to
>     -    run before erroring out with
>     +    If the user gives an empty argument to --exec then git creates a todo
>     +    list that it cannot parse. The rebase starts to run before erroring out
>     +    with
>      
>            error: missing arguments for exec
>            error: invalid line 2: exec
>     @@ -33,21 +34,16 @@
>       
>      +static int check_exec_cmd(const char *cmd)
>      +{
>     -+	int non_blank = 0;
>     ++	if (strchr(cmd, '\n'))
>     ++		return error(_("exec commands cannot contain newlines"));
>      +
>     -+	while (*cmd) {
>     -+		if (*cmd == '\n')
>     -+			return error(_("exec commands cannot contain newlines"));
>     -+		if (!isspace(*cmd))
>     -+			non_blank = 1;
>     -+		cmd++;
>     -+	}
>     ++	/* Does the command consist purely of whitespace? */
>     ++	if (!cmd[strspn(cmd, " \t\r\f\v")])
>     ++		return error(_("empty exec command"));
>      +
>     -+	if (non_blank)
>     -+		return 0;
>     -+
>     -+	return error(_("empty exec command"));
>     ++	return 0;
>      +}
>     ++
>      +
>       int cmd_rebase(int argc, const char **argv, const char *prefix)
>       {

Looks great!

Thanks,
Dscho
