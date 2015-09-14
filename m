From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/2] Submodule object path
Date: Mon, 14 Sep 2015 11:14:19 -0700
Message-ID: <xmqqk2rsx404.fsf@gitster.mtv.corp.google.com>
References: <1438725925-3689-1-git-send-email-max@max630.net>
	<1441922231-18270-1-git-send-email-max@max630.net>
	<xmqqoah9222y.fsf@gitster.mtv.corp.google.com>
	<20150913223256.GB8042@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 20:14:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbYGo-0003mA-Id
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 20:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbbINSOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 14:14:22 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35876 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbINSOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 14:14:21 -0400
Received: by padhk3 with SMTP id hk3so150310611pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=obLRyZa++ZTdNb6bIOXtZC8J9ixPPF1AQugJeRo+5Dg=;
        b=sDyAQ9yAXnFaWlEIGDErlYb2rr/AhKGpQ+b+QfXfGXYeGEv6VtJbUfzOI6N5CFmX/v
         FvYVq2xxEODFCPuE4FBkQKOjn/EJ5uTq/zwnNdmK+LLoM0EIizz2CqDcxpe3VMZbJqrF
         YJJNQL9Mw/YiGPmUMax7FkWX0eWrGSPe4KCgz+XI5A24jDJRCu0m8WuvWM5ah8fIbdzy
         o77vvsE2ggAGSONfxBgnRjeI9b1BATLfHVgf9dik7FX2PjIEc7Ig3/6zgLfZkBiTzagb
         EdxMeXBTCPGk+D/6s+4JnKDaf7gXoWJuZu7Athu/sldulBXjrq6HB4ZA/whReNndzOf8
         TFXw==
X-Received: by 10.68.213.234 with SMTP id nv10mr37746768pbc.145.1442254460982;
        Mon, 14 Sep 2015 11:14:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id xi1sm17527909pac.48.2015.09.14.11.14.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 11:14:20 -0700 (PDT)
In-Reply-To: <20150913223256.GB8042@wheezy.local> (Max Kirillov's message of
	"Mon, 14 Sep 2015 01:32:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277857>

Max Kirillov <max@max630.net> writes:

> On Thu, Sep 10, 2015 at 06:10:13PM -0700, Junio C Hamano wrote:
>> When I push the updated 'pu' out, could you please check
>
> I follow the pu merges. So far resolutions seem correct and
> all tests pass.

The primary thing I ask from "eyeballing by the original author" is
to see if "git diff M^ M" for the merge M of the topic is something
the original author would have done if he was given a starting point
of M^ to build his or her topic (which is what your "resolutions
seem correct" really is), so we are good.

> If you don't mind re-resolving it as I send newer versions I will
> base them on master.

So far rerere seems to be happy, so basing on the same commit is
fine, but I suspect this round should already be ready for 'next'.

I had to remove the now-unused variable "const char *git_dir;" in
[PATCH 1/2], but other than that it looked OK from a cursory re-read.

Thanks.
