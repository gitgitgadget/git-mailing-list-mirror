From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Documentation/config: mention "now" and "never" for 'expire' settings
Date: Tue, 28 Jul 2015 11:36:57 -0700
Message-ID: <xmqqzj2gdt86.fsf@gitster.dls.corp.google.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
	<1437710457-38592-3-git-send-email-sunshine@sunshineco.com>
	<55B58C3B.7040200@alum.mit.edu>
	<CAPig+cTbTi5Uj_BFWBQ+rDc0=PhY1pu9Emr9TwTwPzGCeE5J2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:37:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9kR-0005IK-38
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbbG1ShA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:37:00 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34299 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbbG1Sg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:36:59 -0400
Received: by pdbbh15 with SMTP id bh15so74919118pdb.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KBnbjJFRQjJEzwDzVW34/FHgsFlVeMy8FHeG+TLwCUk=;
        b=h5+cKQU8y5b5dibROPt54vnaWPoE+3wCxUhnEZF5dL1yxYT3zZeucR0bxjz78Wz/np
         o1KbmN5ZcJBFtPeFC1tOksduwqjkA/64XLkaNOjAgnMkz6BmlNAXkyveCib+q9UUHUP7
         fNcXwoABiHiDlwX23pht+aCGEuduE6jY5vbtqHmPx7Tw1jKozFdmNT+Ic3iA24l6Ka5r
         NiVsZ/p9HmapAJ0LLT78BRhhAX0hya4sntCzK4zmYDNvwF/5ZsHlLg7FpWwje8m792LB
         TUU34zYeII0gAjyyG3BXUwD4QY3A0Xpoc36ANc0cGCPRD6vwtSUX9GZxTHh3Dac1WypF
         TSZQ==
X-Received: by 10.70.118.5 with SMTP id ki5mr84743422pdb.6.1438108619219;
        Tue, 28 Jul 2015 11:36:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id ph4sm36449739pdb.43.2015.07.28.11.36.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 11:36:58 -0700 (PDT)
In-Reply-To: <CAPig+cTbTi5Uj_BFWBQ+rDc0=PhY1pu9Emr9TwTwPzGCeE5J2A@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 28 Jul 2015 13:33:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274811>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I was just getting ready to re-roll this series[1] to address
> Michael's comments[2] and noticed that the add-on patch 7/6 which I
> sent later[3] seems to have been botched when Junio applied it to
> 'pu'. It's currently at 36598db (Documentation/git-tools: drop
> references to defunct tools, 2015-07-24) in
> es/doc-clean-outdated-tools and it appears that the --scissors option
> didn't cut off the leading cruft from the email conversation, thus the
> commit has the wrong "subject" plus a bunch of email conversation gunk
> in the commit message which doesn't belong. I understand that Junio
> uses a relatively bleeding-edge version of Git for his day-to-day work
> and was wondering if this is possible fallout from the git-am rewrite
> in C?

It is more likely that I was just lazy, knowing that the patch [3]
would not hit "next" and I'll have a more relaxed time to amend it
after the release was done, and let "am -s" without "-c" take it.

I just tried to re-apply the patch with "am -sc" on
es/doc-clean-outdated-tools^ and the built-in one takes it just
fine, so we should be OK.

Thanks.
