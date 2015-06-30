From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 07/10] send-email: reduce dependencies impact on parse_address_line
Date: Tue, 30 Jun 2015 12:43:11 -0700
Message-ID: <xmqq7fqlc78w.fsf@gitster.dls.corp.google.com>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqfv59ca4b.fsf@gitster.dls.corp.google.com>
	<vpqoajx2dka.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:43:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA1RC-0002Jd-JE
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 21:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbbF3TnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 15:43:18 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35955 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbbF3TnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 15:43:17 -0400
Received: by pdcu2 with SMTP id u2so11507520pdc.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vAT8sT8SNLOK8S6ioBV4KhJ6fgUNozSsGhsNWuDdE9U=;
        b=NWOGgzhvOIHPlWJtsLDHfd/SbqOLVIkJi6AcaCHLz0bDG3lW+13jN6iep1dYtpQeZg
         B4v8nUe3jMs1EVKjF8iLmoSpqYz0lAPheUAleLfbgNJwVb/qFRi1FgDHLSJXQ/U7b26R
         DQxpluos/L1aLfqUnHuYIolavKCTzZC61qyj8f4BLT+zRWTF80hgYyyno97KSwQqjV74
         hakZCG/Ihy1yS0QYT+Z26yhZ/1QR2aMuwHdic1Rz6XEazo5V6A3xA0DcCwfMRQ3WmQiH
         192up9GEVy+8Yesann3mgiRgyIjnWo+8zhhpOi79FWtKS/pxMt2V4fS6ql2Tp5jyQJS9
         jNJw==
X-Received: by 10.68.219.1 with SMTP id pk1mr46386868pbc.18.1435693395780;
        Tue, 30 Jun 2015 12:43:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id wm8sm43261375pbc.19.2015.06.30.12.43.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 12:43:15 -0700 (PDT)
In-Reply-To: <vpqoajx2dka.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	30 Jun 2015 21:36:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273102>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> diff --git a/t/t9000-addresses.sh b/t/t9000-addresses.sh
>>> new file mode 100755
>>> index 0000000..7223d03
>>> --- /dev/null
>>> +++ b/t/t9000-addresses.sh
>>> @@ -0,0 +1,30 @@
>>> +#!/bin/sh
>>> +#
>>> +# Copyright (c) 2015
>>
>> That does not look like a valid copyright notice.
>>
>> In the modern age, I'd personally perfer not to add one
>
> I'd vote for keeping it simple and not having the copyright notice. Most
> t/*.sh do not have one. The Git history + mailing-list archives are much
> better than in-code comments to keep track of who wrote what.
>
> Remi: any objection on removing it?
>
> Junio: do you want me to resend?

It would be simpler to amend in-place either way.  Just let me know
if we want to drop it or add a name (and if the latter, what name).

Thanks.
