From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] pack-objects: do not get distracted by broken symrefs
Date: Thu, 08 Oct 2015 12:42:56 -0700
Message-ID: <xmqqr3l5qh8f.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
	<cover.1444139796.git.johannes.schindelin@gmx.de>
	<f04229b0881eb7518a306ae07fe11ffc9589b1f1.1444139796.git.johannes.schindelin@gmx.de>
	<xmqq8u7evahd.fsf@gitster.mtv.corp.google.com>
	<5ee759ac37b2561eef9ab60d446ac463@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:43:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkH5k-00062Y-Ub
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbbJHTm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 15:42:59 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35512 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbJHTm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:42:59 -0400
Received: by pabve7 with SMTP id ve7so4550509pab.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qFB7DXQqxS/vsv4OHVALxgTU7JfvyL2Vk2XSBBZhQ5s=;
        b=FibhQzdDpmHN8pJO3wxobC2b+L640ZutiXMM9PWTCTuB5TsVTlbXI+SQyg9FYD7fKt
         1352WBGJwaV1cDcDyF+EqXZMCO1b3QHbEbO7WFxClcqSCc7n5MA47+v2D8HyzLQFFhLW
         UDxmgIgIvAkF7s3AVEoMQBUe7/pZqZMjuTI24maovK6xa+/tMUfihLD8MAjYR16WTGSn
         FOZBxZ3zDXk4KwcRi1Iv9si0PUFn6PaTBbIqRemEgrAobyea6YgD7hoeOK5A+/3l4Tng
         mtbXtXM9w+w3sDvbve3QVBreHd91HA9Qz0n/FMa9Xe7WAlgZxFMILtaNG37gIUkzxQSe
         V9cQ==
X-Received: by 10.67.3.2 with SMTP id bs2mr10079164pad.118.1444333378638;
        Thu, 08 Oct 2015 12:42:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id yg2sm46959039pbb.79.2015.10.08.12.42.56
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 12:42:57 -0700 (PDT)
In-Reply-To: <5ee759ac37b2561eef9ab60d446ac463@dscho.org> (Johannes
	Schindelin's message of "Thu, 08 Oct 2015 21:15:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279270>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Would yo kindly add the line
>
>     This fixes https://github.com/git-for-windows/git/issues/423
>
> before the Signed-off-by lines?

Oh, sorry, I missed that one.  Fixed.

Thanks.
