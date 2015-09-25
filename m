From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] SQUASH???
Date: Fri, 25 Sep 2015 10:56:17 -0700
Message-ID: <xmqqk2re4c3i.fsf@gitster.mtv.corp.google.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
	<1443129187-18572-1-git-send-email-sbeller@google.com>
	<1443129187-18572-3-git-send-email-sbeller@google.com>
	<xmqqa8sbuxu0.fsf@gitster.mtv.corp.google.com>
	<CAGZ79katew0UnG2nMrXpnp3AEW+6JgjX9pKaXf6Jb-FfEgeFkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 19:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfXEP-0000ob-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 19:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbbIYR4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 13:56:20 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35782 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbbIYR4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 13:56:20 -0400
Received: by pacfv12 with SMTP id fv12so113894883pac.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OyNJWZSJl5b41SKKBgmVwGaK9bPFJvBduwjiIQc/3qc=;
        b=pxKkzwLRUrSKzb/slJ8ZOlJ3KPazcJ4PJ5wW3s+OpXBFAbirjIkPTE7sdZSUdKrjd3
         D3nl7wrUhyM/N8zYJPqs6Gv+VOA43lIrAHNffC4Ki7hApMbpx1+6EfEkjZHSV6VpDD11
         RTEhCcyyXiQovigDwB6r011LEkzm/qDRYyN5+QxVQ+t/JPwqrfR3/vGz6iXMNtUZ7Fj+
         1a+8WJ6Ip68GwZ/4sGaSg6poFUXH5oJQ16aqMGqnu+kNiHrfb5dIA4EXpCWYqupQFd6X
         3tiaMBDqPzxYPGttlnQ21Lh8KHWkdnwTV5b92I3A4Um3CVHiyZKNa+/KdM9FyNVgmdrf
         MEPA==
X-Received: by 10.66.235.42 with SMTP id uj10mr9065730pac.32.1443203779737;
        Fri, 25 Sep 2015 10:56:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id x6sm5051838pbt.3.2015.09.25.10.56.17
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 10:56:18 -0700 (PDT)
In-Reply-To: <CAGZ79katew0UnG2nMrXpnp3AEW+6JgjX9pKaXf6Jb-FfEgeFkw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 25 Sep 2015 10:52:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278671>

Stefan Beller <sbeller@google.com> writes:

> Sure. I just wanted to point out the details instead of resending the series.
> I'll do a resend later today, hoping to get all issues addressed.

Thanks.  For something this small, unless there are many small
pieces that need to be picked apart, I do not terribly mind to do
the squashing myself (after all that is what I do every day, prepare
a squash while queuing, do the integration testing and send the
squash out to make sure the original author agrees with it).

I just wanted to make sure that we won't be in a situation where
I am waiting forever expecting you to reroll while you are expecting
me to do the squashing, resulting in no progress getting made until
either one of us starts wondering what is going on.
