From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 4/4] format-patch: introduce format.useAutoBase configuration
Date: Tue, 26 Apr 2016 10:11:13 -0700
Message-ID: <CAGZ79kbNzmP2Zwf-99R1jxteNAqV-4QatU0mGhQ9hyapvnAf4g@mail.gmail.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<1461657084-9223-5-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:11:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6W8-0006bA-1g
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbcDZRLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:11:16 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33243 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcDZRLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:11:15 -0400
Received: by mail-io0-f182.google.com with SMTP id f89so22329789ioi.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JcfzM7JOxCBil4wr3HVKoxnfrxgtmauLK/G6tPO/ABM=;
        b=SOWyI0Pjc6bKpbiOHngWezPByZSMXX0s9gQ0C122BiDYaKYlh/j6f4QD88AJnrb+gS
         AC238NtbPDfN6g26VUqhN0xgl0W7SPkVxCk9ZrKondc2GTgec2usckHX2kaYsB1V/Fez
         UoGUOah69O/p593C3f+kgkmbEUjsywhzVNeJ1EVqc/FAmhtXpxVeinVI0Q5rg2kgwz0p
         MLFP27n4aKb52mhptL8lm3iysBZg6b6WxTmplJkrtJZGZuM3ScKN3v+E49Vmt430hCd8
         fNiq26vz/db4pcrZX9++J3VNudnOZ2VNjx+60eFMp4lGwjovNUHHmUKm5WR3pbMBZOPS
         /dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JcfzM7JOxCBil4wr3HVKoxnfrxgtmauLK/G6tPO/ABM=;
        b=fn97adpD4ETbC9JhozRujHpiBZSbUG3wxSi2TpxGULVCL/Jsx7X0ecs84ZNtoy/mvv
         EdRcDW/LOd7blbcvS6W0LajR6ieqUkayxqbUJM5pRSTBIVM5Qt2Z70YugEbg2e/wz87t
         EoYxZu0mcWi3bkMYaqroMdSti5IR64tAiLv5JHxPzkks3J/fqdH22f6iuLX0TaPoosVj
         aYHAz2ih9r459zi/EOFulkzj0MCoTXbolIaq3+iK1LZGL1aWfHjnMIHF8pLNP0EeF7MW
         X/a3dB/FwyZg6UfFAwzPZfLSsKvNmg3H45cChStRmYe82Bjm5m1n7aBHlenshwie7pmI
         towA==
X-Gm-Message-State: AOPr4FXSwME32ZcrUwQ0ZomL9vUtxhF5t1mVC645x8g65uJOp0JBECMTVhchz2hAidqxKwNeFZPK0CMFKTJ/9N3i
X-Received: by 10.107.53.200 with SMTP id k69mr4754972ioo.174.1461690673527;
 Tue, 26 Apr 2016 10:11:13 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 10:11:13 -0700 (PDT)
In-Reply-To: <1461657084-9223-5-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292619>

> +format.useAutoBase::
> +       A boolean value which lets you enable the `--base=auto` option of
> +       format-patch by default.
> +
> +

In case you resend, please use just one empty line here?
(No need to resend because of this alone)
