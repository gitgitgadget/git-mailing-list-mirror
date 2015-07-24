From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] mh: worktree-related doc fixes
Date: Thu, 23 Jul 2015 17:51:51 -0700
Message-ID: <xmqqh9ounzrs.fsf@gitster.dls.corp.google.com>
References: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
	<55AD146D.3080509@alum.mit.edu>
	<CAPig+cRLZiLSrMDiPp9ZJ1RKELSEKqVc0K2h4CvnvXNk5t7aBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 02:52:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIRDU-00026P-DO
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 02:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbbGXAv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 20:51:56 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36550 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbbGXAvz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 20:51:55 -0400
Received: by pdjr16 with SMTP id r16so4514217pdj.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 17:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=axoTSeUduIg3F9V4g/qzAnxjRK4duylPs9QQb1iJ5Is=;
        b=mYqehjqRD8/ZCw9eLUGZ3ZLw35Rw+O7yec1kAuCsx/YKBjfB8QeP8mW4PSMmi1aJSk
         efBXWZ9BwE9H+fB3nn6eLzc11nawsfOoGumwT86jct2DGkuyTVi5DOWt2n4bofrs/+ze
         5T+FOf8fweu+65gZGYFhP2zWljSdtqPgJYbDGf5ZC2lPZ6OEO7KoutId3Dz6pG/ySAhL
         jKmxiG9HWJmfgAjdxIt6aozcXB4PMdka9LusePrBEF8oFiWh0+1KgTUsaBAhsSugrp/s
         FJA6+ssxe8YY4hooCiw1a4OsNcSUWB5R6q34cLcoOrQHqgeaQZ+4CK6cz3Y/zut2ZeqG
         YMQw==
X-Received: by 10.70.49.73 with SMTP id s9mr24265010pdn.149.1437699114827;
        Thu, 23 Jul 2015 17:51:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id 2sm11062133pdp.68.2015.07.23.17.51.52
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 23 Jul 2015 17:51:53 -0700 (PDT)
In-Reply-To: <CAPig+cRLZiLSrMDiPp9ZJ1RKELSEKqVc0K2h4CvnvXNk5t7aBw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 23 Jul 2015 20:10:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274535>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jul 20, 2015 at 11:31 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 07/19/2015 10:29 PM, Eric Sunshine wrote:
>>> This re-roll of Michael Haggerty's worktree-related documentation
>>> tweaks[1] takes my review comments into account and adds one new patch.
>>
>> Thanks for separating the wheat from the chaff. I'm still traveling,
>> which I'll claim as an excuse for my poor responsiveness.
>>
>> All of your changes look good.
>>
>> I was wondering one thing: is there a value like "never" or "false" to
>> which "gc.worktreepruneexpire" can be set to turn off pruning entirely?
>> If so, it might be nice to mention it in the config manpage. Similarly
>> for the other expiration grace time settings.
>> But it's definitely not a blocker.
>
> I browsed the code for the various "expire" settings, and it appears
> that they all accept and respect "now" and "never", as well, so I'll
> put together a patch as suggested.

Sounds good; thanks.
