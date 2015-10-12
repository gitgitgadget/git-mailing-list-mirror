From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Mon, 12 Oct 2015 10:03:37 +0200
Message-ID: <561B6959.20807@gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
 <1443150875.3042.3.camel@kaarsemaker.net>
 <699c08632232180166145f70c7f16645@dscho.org>
 <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
 <vpq7fnc83ki.fsf@grenoble-inp.fr> <vpq4mie1m3n.fsf@grenoble-inp.fr>
 <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
 <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
 <CAPc5daXkn=C-D5RQCw2w+JrHn7XZA6X-P4F-PugRe-S4Z2RO0g@mail.gmail.com>
 <vpq1tdb83nt.fsf@grenoble-inp.fr>
 <xmqqmvvy1q83.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Roberto Tyley <roberto.tyley@gmail.com>, Jeff King <peff@peff.net>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 12 10:03:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlY5D-0005Ih-7m
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 10:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbbJLIDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 04:03:43 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34393 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbJLIDl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 04:03:41 -0400
Received: by wicgb1 with SMTP id gb1so40000004wic.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=xVnGQmTOkSBVmBGjVsVOsHdsg0zWRPwY/uEKYqBa8qk=;
        b=ZCDXPRMI1ab3pKE6wC4TOIvfGpSeiMrAvDbiE3KYS5XWxKca3c8mVIoYwobiiE/z7E
         lTdV7k6DTq+99mEE3R0UoIflrCFBXY7qMqxQO9N3FpfaN0L7BMW4f2yFBe4GxUqW2A3H
         HYKDg4zst2SxLzAb8qpIkYZo9IBgUqMpONxH3YWZcq7EP1LEAG8m5I5lyZl1wS21C9cF
         odWRgzfmekXi6Xc40jq9DoG9PIexrUHRpNh4RimQ6RaQtgRY1egm+xq+ovSZ2AhYQTX/
         Q2FWiodZwDkxBaE2W+wLfGcm2crMmXrOALM5QAhfvTGVHeOPoxGXaHMiecEBw0VF3YAC
         9DSQ==
X-Received: by 10.194.81.169 with SMTP id b9mr28776603wjy.3.1444637019861;
        Mon, 12 Oct 2015 01:03:39 -0700 (PDT)
Received: from [10.223.62.214] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id ds10sm2333079wib.24.2015.10.12.01.03.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2015 01:03:39 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <xmqqmvvy1q83.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279364>

On 10/4/2015 19:46, Junio C Hamano wrote:

>> The very nice thing with Travis-CI is that it does not only test the
>> repository's branches, but also all pull-requests.
>
> OK, that is the first real argument I heard for enabling it on
> git/git that is worth listening to.

I was mentioning that very argument in the context of PRs filed for use 
with submitgit already back in July in the conversation at [1] in which 
you took part.

[1] https://github.com/rtyley/submitgit/issues/16

Regards,
Sebastian
