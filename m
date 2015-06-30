From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 07/10] send-email: reduce dependencies impact on parse_address_line
Date: Tue, 30 Jun 2015 11:41:08 -0700
Message-ID: <xmqqfv59ca4b.fsf@gitster.dls.corp.google.com>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 20:41:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA0T7-0005CR-0D
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 20:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbbF3SlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 14:41:13 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33603 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbbF3SlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 14:41:11 -0400
Received: by igcur8 with SMTP id ur8so71555217igc.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8VuEnbGw4yM+GgQyza/F7DJvm2NmE3BqReMwRrNG7Vo=;
        b=B+PEveLq2bM/If46ZGrRZUxcNTkMWVtsjlq9/hq/bWItPt6kwPg1MBfJGUqrWNIxLR
         4spfwU5/97FlkYns2RtFPGs2YCI8hiVZ2v3ziST1++TZ4L7Lzk4ifupnVBuI/s0M3LPd
         jGyYkXfnPGy8ux0JYXJBOtd1S90XGQ36yhlU/R6ITOzgaM7ErOUDDlNW62JEbE1jwWKT
         wZUC105IzpLpWshxaC8YF0UpBc9Dw5YkcsvssC14wHBP97LGWNav7uj7Fi0GBi4FXung
         H5KiwTI1YkD7yz2gdODP0sioADWNaVwARkG1CNwCzTM1VtJ4XJCNmeg+wu2PD/+twU5Z
         Gi8Q==
X-Received: by 10.42.105.16 with SMTP id t16mr27632906ico.40.1435689670079;
        Tue, 30 Jun 2015 11:41:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id kk9sm3935689igb.7.2015.06.30.11.41.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 11:41:09 -0700 (PDT)
In-Reply-To: <1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 30 Jun 2015 14:16:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273095>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/t/t9000-addresses.sh b/t/t9000-addresses.sh
> new file mode 100755
> index 0000000..7223d03
> --- /dev/null
> +++ b/t/t9000-addresses.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2015

That does not look like a valid copyright notice.

In the modern age, I'd personally perfer not to add one (I would not
have a strong objection to others asserting their copyright), but if
you want to add one, you would need the name of the copyright holder
after the year (I presume that it would be your school name?).

IIRC, (c) in place of circle-C does no carry legal weight, but
having the word "Copyright" spelled out there is sufficient.

Thanks for tying the loose ends (not just this topic, but the other
ones, too).  Very much appreciated.
