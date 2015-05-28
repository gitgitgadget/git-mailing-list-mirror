From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: fix ending newline for template files
Date: Thu, 28 May 2015 11:22:15 -0700
Message-ID: <xmqqpp5kh8a0.fsf@gitster.dls.corp.google.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
	<CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patryk Obara <patryk.obara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 28 20:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy2Ri-0006jP-MU
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 20:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbbE1SWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 14:22:19 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37775 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbbE1SWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 14:22:17 -0400
Received: by igbsb11 with SMTP id sb11so46193774igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=igWA6/edft1wsYAxVYFZb07ZXqD1zqVsnRAVCQh2Bdc=;
        b=airCAUI+hcqKHXoft/7GyUP6gfIJUPY3UqMe44+Kg5g5Z4Mr4b/vMwTgy2jJCcUrva
         xNOHiYityCQJ6N+pmoJ6RkQqV2oJYSz4JgSZuIBqwCH33llLWncslX0Fa0IPfV0Sog5U
         iBtpHOGxdGD7uMXv+fyU/qBdY3eeDoEXQJLOOATr+lc12LaXVsxQNU82I1Oq8bQa6sbn
         7Vo3GtgcLrrnGuYtnJUH1qRjvQDVQlQMPWUc1XFerWPvZMrX+5HX3D3N6xCkKhQGCC0y
         J02e265ySz7/+yc2z5ozJ2Nfcf4BBw6QhB0xOUhcoxRJEDSm6FxOejACG2jok5tU3Cuh
         VqEg==
X-Received: by 10.50.67.146 with SMTP id n18mr7347660igt.40.1432837337326;
        Thu, 28 May 2015 11:22:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id d4sm4866166igl.1.2015.05.28.11.22.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 11:22:16 -0700 (PDT)
In-Reply-To: <CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 May 2015 10:29:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270176>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Moreover, it lacks justification and explanation of why you consider
> the cleanup unnecessary. History [1] indicates that its application to
> -F but not -t was intentional.
>
> [1]: bc92377 (commit: fix ending newline for template files, 2015-05-26)

Sorry, but the date of that commit seems to be too new to be
considered "history"; I do not seem to have it, either.

But I agree with you that I too failed to see why this change is
necessary or desirable in the explanation in the proposed log
message.
