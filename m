From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wither --local
Date: Thu, 26 Apr 2012 12:25:53 -0700
Message-ID: <xmqqpqau8fcu.fsf@junio.mtv.corp.google.com>
References: <799127EF-097F-41DA-A331-E38968ED531D@justatheory.com>
	<20120425214300.GB8590@sigill.intra.peff.net>
	<043D06DF-BF0C-4919-B787-601A93C8BD33@justatheory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "David E. Wheeler" <david@justatheory.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 21:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNUKH-0006dr-93
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567Ab2DZTZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 15:25:56 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:62431 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab2DZTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 15:25:56 -0400
Received: by lbbge1 with SMTP id ge1so75613lbb.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 12:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=ZZ7fTFasvkUC1GoFhFjUCKDr63kL7CfC+OS5Bu3l7zU=;
        b=JyWlXDxf4s1W+b/8s6tmfSoCQoLW99k9UiyGxYWebY5I1z3yzN2gSybaPY1ZShiy2C
         3WT1nuOstqk50UMX5SM9yeZccclQPt33EfjwsMD5uIhqFwMOhBpdTIDLGrtsfHMrtwh3
         sOsUNTcUmQ+kMGl4mco9/5sbQrZSMrSuAWn9g1OddqwGboIeTJpEp1VIJlYb5hyk09lC
         tmfKDmpQNWM3+62UITUVvBGGvwEtRkVLZti2Z4QSK9fj4MruHa3fnxmDzQp6dPNVer2I
         4t6J//0wK0acKWpEae7+aQO2lo8boVr61GF1ajmf3YK7vJdQmi67hRa6ZwlDI7pVd1t7
         T0bw==
Received: by 10.14.199.133 with SMTP id x5mr2418956een.7.1335468354602;
        Thu, 26 Apr 2012 12:25:54 -0700 (PDT)
Received: by 10.14.199.133 with SMTP id x5mr2418944een.7.1335468354523;
        Thu, 26 Apr 2012 12:25:54 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si3699902eef.1.2012.04.26.12.25.54
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 12:25:54 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 55EB75C0050;
	Thu, 26 Apr 2012 12:25:54 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id B7D09E125C; Thu, 26 Apr 2012 12:25:53 -0700 (PDT)
In-Reply-To: <043D06DF-BF0C-4919-B787-601A93C8BD33@justatheory.com> (David
	E. Wheeler's message of "Thu, 26 Apr 2012 12:09:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmqN4h2yfiANInCuDTAXpQdr8i40bP0RHmkOKidK6Y64bDGH5yScs3etveYRjKX7aZFeo0ExZX6ygTyYr6ovtiuK/Vlomr63Q36OnQ6pZn9ba8bWLbdQfcovgDFVQt+UY6KySCDpyTglIQ1SciPYDXuZu5T1hO9JRQ06LFkxAA17EkXkV0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196396>

"David E. Wheeler" <david@justatheory.com> writes:

> Is this thread sufficient to get it on someone's radar, or should
> there be a ticket somewhere?

It's already on _your_ radar, isn't it?
