From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] --seed as an alias for --dissociate --reference
Date: Thu, 21 May 2015 09:41:08 -0700
Message-ID: <xmqqa8wxlw7v.fsf@gitster.dls.corp.google.com>
References: <20150521041435.GA18978@peff.net>
	<xmqqmw0yle0y.fsf@gitster.dls.corp.google.com>
	<20150521050645.GA27478@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 18:41:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvTX2-00059D-1r
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 18:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbbEUQlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 12:41:12 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34313 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161011AbbEUQlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 12:41:10 -0400
Received: by igbhj9 with SMTP id hj9so15093095igb.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=b4sw+ZGbIdWlw8ITrtYV2cmH62IHVNtyalzPDm6xTfk=;
        b=d/kyYY80lR32ou5jkJaeS5UEYD7mWn/OhrWHixRF1xWay7+sjl29mz1ln/btm1MZ1k
         KBGFulSTHbiigMVKLrWhdGUhNq+4PGyPALrvM+joTG9Hc3DeNAllBnhBBiEbKyD50Fdr
         +BZhtgkkTO9BpLrtHWHPDt5WiBUESKDIqxqvy3W38Qxc9aZ9wbHpH3rOZ6zEkRaPjzDn
         m9+IpC9ghGiV663dlbjq65iNbTNzEn884VPE6dvTtZwNoZ5e/yWidfV/jKxs7aA7il4i
         IsBuvD/yd15paOt/z76FkLNWPRC3xKKcu2TIuMmkldS0gYqiyaQJwCpGml1ofCDCZwGt
         BsKA==
X-Received: by 10.42.238.14 with SMTP id kq14mr4319393icb.23.1432226469867;
        Thu, 21 May 2015 09:41:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id a74sm15235761ioe.36.2015.05.21.09.41.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 09:41:09 -0700 (PDT)
In-Reply-To: <20150521050645.GA27478@peff.net> (Jeff King's message of "Thu,
	21 May 2015 01:06:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269606>

Jeff King <peff@peff.net> writes:

> Yeah, I was just looking over the list archives for the past few months,
> for things I had marked as "to read and think about later"[1].
> ...
> [1] My "think about later" mailbox has ~5000 messages in it, some of
>     which are from 2010. I think I may need to just declare bankruptcy.

Were you absolutely bored and didn't have anything better to do ;-)?

Thanks for sweeping the backlog.  I usually do the same myself while
the tree is more or less frozen first week of the new cycle waiting
for brown paper bag bugs to be discovered, but since we somehow kept
moving immediately after 2.4.0 release, I didn't have a chance to do
that.
