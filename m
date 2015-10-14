From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 20/31] mailinfo: move cmitmsg and patchfile to struct mailinfo
Date: Wed, 14 Oct 2015 15:55:50 -0700
Message-ID: <xmqq7fmphxft.fsf@gitster.mtv.corp.google.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1444855557-2127-21-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 00:55:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmUxg-0005NS-Mt
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 00:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbbJNWzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 18:55:52 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36566 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbbJNWzw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 18:55:52 -0400
Received: by pabws5 with SMTP id ws5so2837731pab.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nu7ZKRhexiu2UCKH0yukS9E6xhjuULrWFYwmODJWFN0=;
        b=x3bWfvqSJYcUMsKiFISd7pXjECEK9M10OmIwlOkuUgdotIqnlQvw3FOebOEwtcthn7
         5o9MTQOiOKt3Gy0gmwqI+NPT7cwQkrb1K+KBqzo/BvSs/k3poF8dDit274KgFj2K7ZP1
         HRULYoUNpGur2Kb+CqfZqQ9Oc1A+Wr/QqcSZyFp+lum6KHu/GmEBhghP5HNlMV88pp32
         lnPzJ+2F4KkPz1WEalZiPilA/TxnK50yTe2rKMFe/nh339ecm4C6Mm+Jstsct8WXWauI
         qPi6RfXYk9xKiXrxnuoohReCqf2q8g98LNBskq3A+jO4Tpdejn8jaqN1oNVml5Qgh2fc
         PBLg==
X-Received: by 10.68.89.33 with SMTP id bl1mr1801989pbb.139.1444863351606;
        Wed, 14 Oct 2015 15:55:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id ez2sm11580159pbb.5.2015.10.14.15.55.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 15:55:51 -0700 (PDT)
In-Reply-To: <1444855557-2127-21-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Wed, 14 Oct 2015 13:45:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279637>

This step does not compile correctly; will be fixed in v3.
