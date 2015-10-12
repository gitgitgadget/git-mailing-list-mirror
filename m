From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Add Travis CI support
Date: Mon, 12 Oct 2015 09:07:56 -0700
Message-ID: <xmqqoag4m5nn.fsf@gitster.mtv.corp.google.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, tboegi@web.de,
	pw@padd.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 12 18:08:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlfdq-0001AY-P5
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 18:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbJLQH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 12:07:58 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34002 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbbJLQH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 12:07:58 -0400
Received: by padhy16 with SMTP id hy16so157510516pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=3ywMxvdDpIVX7epsxyZqhok1M5Ct53EMQTpISGakhEM=;
        b=mEFCscrQu2hVfryQS9x7Csx8hCwWNL3uShKzRfSx+7p4oxx2Z9qAD4sF/K9r4bxgE6
         9LA0C0ALLlHpxy0azaPidiBA8IciK2UxuVZT9rztfDQR7dXP8iI2Wc9c6FS2RNpMfPtR
         AXtSz++uW74w4CLRq0wcC2L5DFpkpLRxIIiExznWSsjtmWNnvFHrYD3gbxFKKZt5wzIX
         83vozYymCmkwiDh2OsX6jSUYB1dt+5YPQB9+JV+KWT9WdPIndf+Ejkxo3AQeMTgnCi/G
         vig26v9y1dnYl57cT2uVBT09/v7vDqrwaGaqfQ0rtf2OeWhvl6c2WnUQlaPREAYxxaIP
         lxbQ==
X-Received: by 10.68.65.13 with SMTP id t13mr35310410pbs.43.1444666077847;
        Mon, 12 Oct 2015 09:07:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id qd5sm19115559pbc.73.2015.10.12.09.07.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 09:07:57 -0700 (PDT)
In-Reply-To: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 11 Oct 2015 10:54:59
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279381>

larsxschneider@gmail.com writes:

> Lars Schneider (3):
>   Add Travis CI support
>   git-p4: Improve test case portability for t9815 git-p4-submit-fail
>   git-p4: Skip t9819 test case on case insensitive file systems

Can you split this into two separate series?

It seems Luke is happy with the p4 bits and I think it makes sense
to have it as a separate series and apply sooner, while those who
are interested in and well versed in Travis to help polishing the
first one.

Thanks.
