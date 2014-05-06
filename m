From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Tue, 06 May 2014 14:39:21 -0500
Message-ID: <53693a69ed668_2c65106f2ecdb@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
 <20140506080749.GD23935@serenity.lan>
 <xmqqsiomem5t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 06 22:14:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhlNX-0005Gd-2M
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbaEFTuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:50:08 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:48661 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbaEFTuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:50:07 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so2058873oac.25
        for <git@vger.kernel.org>; Tue, 06 May 2014 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=DRqlmUZF3IZyB7hNA3aX5bnmiHleoyIMDEsh0aOWjMo=;
        b=CVYx8qehr5eKHl9a1y1OxIOX6aWSlsHztDn9QCXA0p3cQno6WiBsZDEJQrIZ/RXDMB
         IeHs1M+kEpSyemM8TIYKEo+OCnmXTBlFGeLcApmSxFt7Paz2S4+QoWXcKestHTpMSY9K
         z6tchrFds1tb31ldqPvgYfj9Ea/E61V75gTV4sLMOz45NyE/NUd4G5n0qiIeKluzySG8
         M7uXrGaNqGxWFPfKUhdbM2b5iOfeHnfEjx/keJjp2mPw7nP0V9xzg5qwMJ3iy0TQctBQ
         Y399ck44WIeY4RrG5UD7DeejY9inU/DelZpAJ78B5Bkf6vQzQrb1sOnfjhK2GbkhF3H5
         NwtA==
X-Received: by 10.182.248.131 with SMTP id ym3mr4348120obc.58.1399405807094;
        Tue, 06 May 2014 12:50:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id to6sm1294906obb.6.2014.05.06.12.50.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 12:50:06 -0700 (PDT)
In-Reply-To: <xmqqsiomem5t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248235>

Junio C Hamano wrote:
> Having said that, I agree with the conclusion of your message:
> 
> > There is a different level of urgency between "you cannot use this
> > new feature until you update Git" and "if you update Mercurial then
> > the remote helper will stop working", and that's why I think the
> > remote helpers may benefit from a separate release schedule.

The conclusion is correct, the premises are not.

-- 
Felipe Contreras
