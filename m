From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] make commit --verbose work with --no-status
Date: Fri, 05 Jun 2015 10:13:16 -0700
Message-ID: <xmqqlhfyrscz.fsf@gitster.dls.corp.google.com>
References: <1433440591-30917-1-git-send-email-rctay89@gmail.com>
	<xmqqd21buxla.fsf@gitster.dls.corp.google.com>
	<CALUzUxqeadRii1o0-yo=QaZCqoAzGk+aVq=y1-11dJvK=em0qw@mail.gmail.com>
	<xmqqbnguta69.fsf@gitster.dls.corp.google.com>
	<CALUzUxrFvE-SDW0q2P08vR7rc4GHdpm24y7dk+kUdyGGwmqwOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:13:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0vBL-0003Tm-EO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 19:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbbFERNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 13:13:19 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38551 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbFERNS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 13:13:18 -0400
Received: by igblz2 with SMTP id lz2so19347850igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bGJCStggRkOGhi1y0efnWMrxJRAh7tTddD2mMtdByq0=;
        b=PDTOxwbY3jc8lIII1nEBWw0djZ3bYaZyNg5aVC8z9oM+DI16necma/armHw8LvVllz
         rLerwo3yHJgywlMH/YZNy/qRCdmFt78IBLfWgxS/mYY4pC+z26s474srHJMEGd0x+oIM
         jhpBipcV2NkkXEk+oPlEcW3zn037BFV74jYyYOJliZSS+cnjIgK4xWelZaDciLZ2pZwY
         w433Z4Nr8zE6N9Syf2E9L8O3TNHJzop2nM+mpS8pgBziMGbCMjH9JrrgUSlFV//PsIt2
         YfZ4NsWahWbQqTc9fJSm9ner2jPTvvWI52w7s2VPw8gUS2IYfIxA2jwdVDIt4AlCmPIA
         LiSw==
X-Received: by 10.107.135.162 with SMTP id r34mr4988504ioi.13.1433524398060;
        Fri, 05 Jun 2015 10:13:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id o2sm1684002igr.9.2015.06.05.10.13.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 10:13:17 -0700 (PDT)
In-Reply-To: <CALUzUxrFvE-SDW0q2P08vR7rc4GHdpm24y7dk+kUdyGGwmqwOQ@mail.gmail.com>
	(Tay Ray Chuan's message of "Sat, 6 Jun 2015 00:48:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270862>

Tay Ray Chuan <rctay89@gmail.com> writes:

>> All of the above assumes that showing only the patch and not other
>> hints to help situation awareness while making a commit is a useful
>> thing in the first place.  I am undecided on that point myself.
>
> Hmm, perhaps such functionality should be off-loaded to a third-party
> wrapper. (I'd not be surprised if most wrappers already have this.)

If you believe that parenthesised comment to be true, then that
would be a sign that such a feature is desirable, no?  Substantiate
it and let's relieve the third-party wrappers of that burden, then.
