From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 3 Dec 2014 15:29:51 -0800
Message-ID: <20141203232951.GJ6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051911.GP6527@google.com>
 <xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
 <xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:30:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJMs-00031H-NZ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbaLCX3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:29:55 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37827 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaLCX3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 18:29:54 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so13707811igb.9
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 15:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6QeqIsJQ90evDWah8tuqFaiRrWCOmpnv8VKEKvYtsA0=;
        b=Oz3SLMzxhooBnsj20gQjKe6S/viZ1EFEpVEczEMBApdm47+6/RTmFKEr55+FohzsCw
         UA8U6prhLqRUXPnWoMoX5mPI1xZv+Imo06Pa23KDCCo4ERGzgJ/iCu+vmq9k+CycKv3K
         TCjt3DFws3rAMePtWgl/F10ttaON4pemqQts0UcIf3aV7LtB3reQE704nUWCRhv/nhXE
         PwqQVrUcdjnbvdYWfIdLJQjelNrCVtO3fdxSiTnzbv8tGb7/BtcqCF//xG9iFOwvLH/F
         fOmzTq3zawBUbmgXSCemPjmsBZkJYk3SPZdNIh+/Qz7Wf8Zvu+2zMB8G4Jd9eOgvMUsK
         HMLg==
X-Received: by 10.50.79.232 with SMTP id m8mr59972306igx.11.1417649393962;
        Wed, 03 Dec 2014 15:29:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id if1sm18319245igb.22.2014.12.03.15.29.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 15:29:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260710>

Junio C Hamano wrote:

> I tried to merge the 14-patch series with obvious fix-ups after
> dropping the rerere abortion change you sent separately and in
> duplicate and also dropping sb/copy-fd, but I've ran out of patience
> with this step, at least for today's integration cycle.  Should we
> also drop jk/lock-ref-sha1-basec-return-errors topic as well?

I don't mind adding it to the series.  Or feel free to hold off on
picking up this 14-patch series until tomorrow's reroll.  (Helping
with today's integration was why I was thinking of re-sending.  I
should have been clearer about saying that I prefer you don't pick
this up yet when I decided to give reviewers a little more time.)

> The 14-patch series may have been internally consistent and its
> individual patches, when each of them was taken alone by itself, may
> have made sense, but it appears that the aggregated whole these
> separate topics took their root from is inconsistent with itself
> in minor ways like this here and there X-<.

I don't follow.  It's normal for an API change to affect code that
uses the API --- what inconsistency are you talking about here?

Puzzled,
Jonathan
