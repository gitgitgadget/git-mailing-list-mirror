Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D95201A0
	for <e@80x24.org>; Sun,  2 Jul 2017 11:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdGBLTH (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jul 2017 07:19:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35367 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdGBLTG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2017 07:19:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so1826659pgc.2
        for <git@vger.kernel.org>; Sun, 02 Jul 2017 04:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=rfHZfW1YOWRWrpMHY67xjaCD+n7QMaTFl7AmOZJXwVs=;
        b=YGJSBIEO3Goifw2U0POGR7UGvM7THGeLZhTqK0B/tHPYAD0M2Wa1Azz2mkU6jptTIQ
         sn9HWmrZJ+H7avRMsAF89wzO+dIO1pyvdoEa5WIkI+d276QpzSqr09LgD6rnt0YLQihp
         lA5+VjiKQ7wMJiIUIZ4TEFwHHrk/ufOImDuiTms4uZWYMuJSTDfyLmF7qhwsmv6r50O+
         PpmemPko3jKAx74oQFCiZTdf8kz6Xt0eY2QnEvgt/k3yz8q6iCVs0KBimBAH+z4zud4Q
         7w9x9YFB8zdCWBJdmKYPtUkIpMM0HtAQ7b3b6yXk6X+mMJQAOMpPrtOjE4E4oDPyLqnX
         zj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=rfHZfW1YOWRWrpMHY67xjaCD+n7QMaTFl7AmOZJXwVs=;
        b=JB9Wg88E6RFc73pcOFY2Ru2x4ey8XBYoQCeYccGCFRG1UFMnFS2Vqa++XdFWKkZAC9
         bRbGGfEJkoOPxEO59CnZa2xUOqkVZa49+fROcvTiLYHim2Em9tqabf2V9wZkuuLPEZom
         8OMkfsal8RSay6YaEBh3L8RQggtE547TOmvfrV+qn+kae8fqZAySI975NmAXX89xF2Ef
         OHDQ9YI8l5/1z6TgwyjsYdJITcXLg6hCjdKQ3hliFBdk9tQjG9VwAEJv4NFf40IlYg3F
         mEbhWGX6COB6wHrbiBq3OVRuhbAM+sNQpoLzEG5ryE3w3O8grOkvT1QS3fgL6zvYIEyK
         X3RQ==
X-Gm-Message-State: AIVw111InAT1LMHmTtq1qL2bq9nYpaoChUaXe9BkZ7mwbx1OIsBvUFn0
        yx+DN8hFcy/SYA==
X-Received: by 10.84.141.3 with SMTP id 3mr5011902plu.227.1498994345490;
        Sun, 02 Jul 2017 04:19:05 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id u9sm30801841pfg.127.2017.07.02.04.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Jul 2017 04:19:05 -0700 (PDT)
Message-ID: <1498994345.1667.5.camel@gmail.com>
Subject: Re: [PATCH] hooks: add signature to the top of the commit message
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Date:   Sun, 02 Jul 2017 16:49:05 +0530
In-Reply-To: <xmqqy3s7nbkm.fsf@gitster.mtv.corp.google.com>
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
         <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
         <1498918546.4321.1.camel@gmail.com>
         <xmqqfuegnjnt.fsf@gitster.mtv.corp.google.com>
         <1498935127.11617.1.camel@gmail.com>
         <xmqqy3s7nbkm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-07-01 at 13:31 -0700, Junio C Hamano wrote:
> That sounds like a sample that is there not because it would be
> useful, but because we couldn't think of any useful example.
> 
> IOW, I view it just as useful as a sample that does
> 
> 	#!/bin/sh
> 	echo "# useless cruft" >>"$1"
> 
> whose sole value is to demonstrate that you could affect what you
> see in the editor by modifying "$1".
I thought it would be useful as it could serve as a simple example
about what could be done using hooks and further would help save some
vertical spacing for users who are acquainted with that message and
wouldn't want to see it anymore.

Sending a typical patch as a follow-up.

Apart from that I would like to share a patch of my attempt to give
"notes" about a commit while writing the commit message itself. It was
an attempt to combine three hooks at once to achieve the outcome. I
just wanted to share it so that it might be of use to someone.

-- 
Kaartic
