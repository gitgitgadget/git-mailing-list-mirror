From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/7] git-p4: add support for large file systems
Date: Mon, 21 Sep 2015 13:05:10 -0700
Message-ID: <xmqq1tdra689.fsf@gitster.mtv.corp.google.com>
References: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
	<56005E6A.4000308@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 21 22:05:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze7Kx-0005K1-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 22:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbbIUUFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 16:05:14 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34281 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbIUUFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 16:05:13 -0400
Received: by padhy16 with SMTP id hy16so125270100pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=H7wkxBfYY6UiGcmEvlkDFpcDhwSzBwcha80HLd+VsMY=;
        b=jkmIb2TrJS7CAPRgJNV7B3v1XWPP/cqRIJq0sLGqu/y2YXVxicOq09Vvl2XU1243b2
         dHDOqmZuE7/BRPPfrT/ot19BnGmd5PurW9Zee4Se7o0eRJO+T0MnYxkyI8ZyzBYAI9l2
         P5MIRrGoUSFyXeA/uq0qoIjjho2OTDEcwuzNne+4f14BJer6iOfA9CpsPIbcbq5V9a3u
         InfDrZRWDVkTkzBNuwo+9qtEtP2IsV4Z/iG0YXNbKBsLdJpj94jHSNKALeeOPrZL32RI
         PPR4EkrSWHNuOV93Sh5D2MrtNBBzzhYJjToNiStSEEcNN8r3BJ+b0i1msFMq3DeHJQfn
         XRwg==
X-Received: by 10.68.94.195 with SMTP id de3mr26517459pbb.47.1442865912818;
        Mon, 21 Sep 2015 13:05:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id lg7sm26102540pbc.1.2015.09.21.13.05.10
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 13:05:11 -0700 (PDT)
In-Reply-To: <56005E6A.4000308@diamand.org> (Luke Diamand's message of "Mon,
	21 Sep 2015 20:45:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278329>

Luke Diamand <luke@diamand.org> writes:

> On 20/09/15 21:26, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> diff to v5:
>> * remove superfluous flush call (thanks Luke!)
>> * keep &&-chain intact in test cases (thanks Luke, Junio and Eric!)
>> * add mock LFS test case for deleting files (thanks Luke!)
>> * add mock LFS test case for git-p4.largeFileExtensions option
>> * add Luke's ACK to commit "git-p4: add optional type specifier to
>> gitConfig reader" (thanks Luke!)
>> * replace substring extraction in test case ... "${VAR:X:Y}" only
>> works in bash, "$(echo "$VAR" | cut -cX-Y)" works in sh
>
> Sorry about this, but patch 6 no longer seems to apply cleanly to next
> (or at least not for me).

Please check the conflict resolution when I push today's result out
on 'pu'.
